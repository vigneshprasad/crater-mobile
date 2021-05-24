import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../constants/theme.dart';
import '../../../../core/widgets/base/base_container/base_container.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../ui/base/code_input/code_input.dart';
import '../../../../ui/base/phone_number_input/phone_number_input.dart';
import '../../../../utils/app_localizations.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/phone_verify/phone_verify_bloc.dart';
import '../widgets/profile_header.dart';

class PhoneVerificationScreen extends StatefulWidget {
  @override
  _PhoneVerificationScreenState createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  PhoneVerifyBloc _bloc;
  bool _validPhoneNumber;
  String _phoneNumber;
  bool _showSmsCodeInput;
  String _smsCode;
  bool _validOtp;
  String otpResponse = "";

  @override
  void initState() {
    _validOtp = false;
    _showSmsCodeInput = false;
    _validPhoneNumber = false;
    _bloc = KiwiContainer().resolve<PhoneVerifyBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verify = 'Submit';
    const heading = "You are all done!!";
    const subtitle = 'Verify your account';
    final enterOtp =
        AppLocalizations.of(context).translate("phone_verify:enter_otp");
    final labelStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        );
    final statusStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).primaryColor,
        );
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return BlocProvider.value(
          value: _bloc,
          child: BlocConsumer<PhoneVerifyBloc, PhoneVerifyState>(
            listener: _phoneVerifyBlocListener,
            builder: (context, state) {
              final sendOtp = AppLocalizations.of(context)
                  .translate("phone_verify:send_otp");
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppInsets.xl),
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
                                  RaisedButton(
                                    onPressed:
                                        _validPhoneNumber && !_showSmsCodeInput
                                            ? _postNewPhoneNumber
                                            : null,
                                    child: Text(sendOtp),
                                  ),
                                  const SizedBox(width: AppInsets.l),
                                  if (otpResponse.isNotEmpty)
                                    Text(otpResponse, style: statusStyle)
                                ],
                              ),
                              const SizedBox(height: AppInsets.xl),
                              if (_showSmsCodeInput)
                                Text(enterOtp, style: labelStyle),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: FlatButton(
                                        onPressed:
                                            _validOtp ? _postSmsCode : null,
                                        child: Text(verify),
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
            },
          ),
        );
      },
    );
  }

  void _phoneVerifyBlocListener(BuildContext context, PhoneVerifyState state) {
    if (state is PhoneNumberPostRequestLoaded) {
      setState(() {
        _showSmsCodeInput = true;
        otpResponse = state.status;
      });
    } else if (state is PhoneSmsCodeRequestLoaded) {
      Fluttertoast.showToast(
        msg: "Phone Number verified successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white,
        fontSize: 14,
      );
      Future.delayed(const Duration(seconds: 1), () {
        ExtendedNavigator.of(context).popAndPush(Routes.homeScreen(tab: 0));
      });
    }
  }

  void _postNewPhoneNumber() {
    _bloc.add(PostNewPhoneNumberRequestStarted(phoneNumber: _phoneNumber));
  }

  void _postSmsCode() {
    _bloc.add(PostSmsCodeRequestStarted(
      smsCode: _smsCode,
      phoneNumber: _phoneNumber,
    ));
  }

  void _onValidPhoneNumber(bool isValid) {
    setState(() {
      _validPhoneNumber = isValid;
    });
  }
}
