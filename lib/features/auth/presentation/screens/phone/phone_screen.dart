import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/analytics/anlytics_events.dart';
import 'package:worknetwork/core/attribution/attribution_manager.dart';
import 'package:worknetwork/core/error/failures.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/features/socket_io/socket_io_manager.dart';
import 'package:worknetwork/core/push_notfications/push_notifications.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/data/repository/auth_repository_impl.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/signup/presentation/widgets/profile_header.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/ui/base/code_input/code_input.dart';
import 'package:worknetwork/ui/base/phone_number_input/phone_number_input.dart';
import 'package:worknetwork/utils/analytics_helpers.dart';
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
  late FocusNode myFocusNode;

  @override
  void dispose() {
    myFocusNode.dispose();

    super.dispose();
  }

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

    myFocusNode = FocusNode();

    return Scaffold(
      backgroundColor: widget.state == 'popup'
          ? Theme.of(context).dialogBackgroundColor
          : null,
      appBar: widget.state == 'popup' ? null : BaseAppBar(),
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
                      backgroundColor: widget.state == 'popup'
                          ? Theme.of(context).scaffoldBackgroundColor
                          : null,
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
                        focusNode: myFocusNode,
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
                    const SizedBox(height: 20),
                    if (_showSmsCodeInput)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: BaseLargeButton(
                            enabled: _validOtp,
                            onPressed: _validOtp ? _postSmsCode : null,
                            text: verify,
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
    final _overlay = buildLoaderOverlay();

    Overlay.of(context)?.insert(_overlay);
    final response =
        await context.read(authRepositoryProvider).sendOtp(_phoneNumber);

    _overlay.remove();

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
      myFocusNode.requestFocus();
    });
  }

  Future<void> _postSmsCode() async {
    final _overlay = buildLoaderOverlay();

    Overlay.of(context)?.insert(_overlay);

    final attributionProvider = context.read(attributionManagerProvider);
    final data = await attributionProvider.getAttributionData();

    final response = await context
        .read(authRepositoryProvider)
        .verifyOtp(_phoneNumber, _smsCode, data);

    response.fold((failure) {
      final message = failure as ServerFailure?;

      Map? map;
      try {
        map = jsonDecode(message?.message.toString() ?? '') as Map?;
      } catch (e) {}
      final error = map?['otp'] as List<String>?;

      _overlay.remove();

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

      final socketIOManager =
          context.read(userPermissionNotifierProvider.notifier);
      await socketIOManager.listenPermissions();

      final _ = BlocProvider.of<AuthBloc>(context)
        ..add(AuthCompleted(user: user, profile: profile));

      final analytics = KiwiContainer().resolve<Analytics>();
      analytics.initSdk();
      analytics.identify(properties: getUserTraitsFromModel(user));
      await analytics.trackEvent(
        eventName: AnalyticsEvents.login,
        properties: {
          "email": user.email,
          "intent": user.intent,
        },
      );

      final pushNotifications = KiwiContainer().resolve<PushNotifications>();
      await pushNotifications.setUserIdentifier(_phoneNumber);

      final osId = await KiwiContainer()
          .resolve<PushNotifications>()
          .getSubscriptionToken();
      debugPrint(osId);

      _overlay.remove();

      if (widget.state == 'popup') {
        Navigator.of(context).pop(user);
      } else {
        navigatePostAuth(user, profile: profile);
      }
    });
  }

  void _onValidPhoneNumber(bool isValid) {
    setState(() {
      _validPhoneNumber = isValid;
    });
  }
}
