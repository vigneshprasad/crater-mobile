import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/ui/base/code_input/code_input.dart';
import 'package:worknetwork/ui/base/phone_number_input/phone_number_input.dart';
import 'package:worknetwork/utils/app_localizations.dart';

import '../../../../constants/theme.dart';
import '../../../../routes.gr.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/phone_verify/phone_verify_bloc.dart';

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
    final headingStyle = Theme.of(context).textTheme.headline5.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w500,
        );
    final verify = AppLocalizations.of(context).translate("verify");
    const heading = "And lastly, could we have your phone number?";
    final enterOtp =
        AppLocalizations.of(context).translate("phone_verify:enter_otp");
    final labelStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey[600],
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
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Flex(
                        direction: Axis.vertical,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                heading,
                                style: headingStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
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
                                        onPressed: _validPhoneNumber &&
                                                !_showSmsCodeInput
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
                                  if (_showSmsCodeInput)
                                    RaisedButton(
                                      onPressed:
                                          _validOtp ? _postSmsCode : null,
                                      child: Text(verify),
                                    ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
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
    _bloc.add(PostSmsCodeRequestStarted(smsCode: _smsCode));
  }

  void _onValidPhoneNumber(bool isValid) {
    setState(() {
      _validPhoneNumber = isValid;
    });
  }
}
