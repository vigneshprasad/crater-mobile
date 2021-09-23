import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/core/integrations/user_leap/user_leap_provider.dart';
import 'package:worknetwork/core/widgets/base/base_container/base_container.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/auth/data/repository/auth_repository_impl.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/signup/presentation/widgets/profile_header.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';
import 'package:worknetwork/ui/base/code_input/code_input.dart';
import 'package:worknetwork/ui/base/phone_number_input/phone_number_input.dart';
import 'package:worknetwork/utils/app_localizations.dart';
import 'package:worknetwork/utils/navigation_helpers/navigate_post_auth.dart';

class PhoneScreen extends StatefulWidget {
  final String state;

  const PhoneScreen({
    Key? key,
    @PathParam("state") required this.state,
  }) : super(key: key);

  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  late bool _validPhoneNumber = false;
  late String _phoneNumber = '';
  late bool _showSmsCodeInput = false;
  late String _smsCode;
  late bool _validOtp = false;
  String otpResponse = '';

  @override
  Widget build(BuildContext context) {
    const verify = 'Submit';
    const heading = 'Enter your phone number';
    const subtitle = 'You will receive an OTP via SMS';
    final enterOtp =
        AppLocalizations.of(context)?.translate("phone_verify:enter_otp");
    final labelStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        );
    final statusStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).primaryColor,
        );
    final sendOtp =
        AppLocalizations.of(context)?.translate("phone_verify:send_otp");
    return Scaffold(
      appBar: BaseAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ProfileHeader(
                title: heading,
                subtitle: subtitle,
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppInsets.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PhoneNumberInput(
                      onValidChange: _onValidPhoneNumber,
                      initalCountry: "IN",
                      onChange: (value) {
                        setState(() {
                          if (value != _phoneNumber) {
                            _showSmsCodeInput = false;
                          }
                          _phoneNumber = value;
                        });
                      },
                    ),
                    const SizedBox(height: AppInsets.xl),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _validPhoneNumber && !_showSmsCodeInput
                              ? _postNewPhoneNumber
                              : null,
                          child: Text(sendOtp!),
                        ),
                        const SizedBox(width: AppInsets.l),
                        if (otpResponse.isNotEmpty)
                          Text(otpResponse, style: statusStyle)
                      ],
                    ),
                    const SizedBox(height: AppInsets.xl),
                    if (_showSmsCodeInput) Text(enterOtp!, style: labelStyle),
                    if (_showSmsCodeInput)
                      CodeInput(
                        length: 4,
                        onChange: (value) {
                          setState(() {
                            _smsCode = value;
                          });
                        },
                        onValidChange: (isValid) {
                          setState(() {
                            _validOtp = isValid;
                          });
                        },
                      ),
                    const SizedBox(height: 80),
                    if (_showSmsCodeInput)
                      Center(
                        child: BaseContainer(
                          radius: 30,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextButton(
                              onPressed: _validOtp ? _postSmsCode : null,
                              child: const Text(verify),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _postNewPhoneNumber() async {
    _buildOverlay();
    final response =
        await context.read(authRepositoryProvider).sendOtp(_phoneNumber);
    response.fold((failure) {
      final message = failure as ServerFailure?;
      final map = jsonDecode(message?.message.toString() ?? '');
      final error = map?['username'] as List<String>?;
      if (error != null) {
        Fluttertoast.showToast(msg: error.first);
      } else {
        Fluttertoast.showToast(
          msg: failure.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
          fontSize: 14,
        );
      }
    }, (r) {
      setState(() {
        _showSmsCodeInput = true;
        otpResponse = '';
      });
    });
  }

  Future<void> _postSmsCode() async {
    final response = await context
        .read(authRepositoryProvider)
        .verifyOtp(_phoneNumber, _smsCode);

    response.fold((failure) {
      final message = failure as ServerFailure?;
      final map = jsonDecode(message?.message.toString() ?? '');
      final error = map?['otp'] as List<String>?;
      if (error != null) {
        Fluttertoast.showToast(msg: error.first);
      } else {
        Fluttertoast.showToast(
          msg: failure.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
          fontSize: 14,
        );
      }
    }, (user) async {
      final profileResponse =
          await context.read(authRepositoryProvider).getUserProfile();
      final profile = profileResponse.getOrElse(() => UserProfile());
      final _ = BlocProvider.of<AuthBloc>(context)
        ..add(AuthUserUpdateRecieved(user: user))
        ..add(AuthUserProfileUpdateRecieved(profile: profile));

      context.read(userLeapProvider).setUserData(user);
      // analytics.initSdk();
      // analytics.identify(properties: getUserTraitsFromModel(user));
      // analytics.trackEvent(
      //   eventName: AnalyticsEvents.signUpEmail,
      //   properties: {
      //     "email": user.email,
      //     "intent": user.intent,
      //   },
      // );
      // navigatePostAuth(user, profile: profile);
    });
  }

  void _onValidPhoneNumber(bool isValid) {
    setState(() {
      _validPhoneNumber = isValid;
    });
  }

  Widget _buildOverlay() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                height: 32,
                width: 32,
                child: CircularProgressIndicator(),
              ),
              SizedBox(height: AppInsets.xl),
              Text("Loading..."),
            ],
          ),
        ),
      ),
    );
  }
}
