import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/presentation/screens/phone/phone_screen_state.dart';
import 'package:worknetwork/features/signup/presentation/widgets/profile_header.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/ui/base/code_input/code_input.dart';
import 'package:worknetwork/ui/base/phone_number_input/phone_number_input.dart';
import 'package:worknetwork/utils/app_localizations.dart';

class PhoneScreen extends HookConsumerWidget {
  final String state;

  const PhoneScreen({
    Key? key,
    @PathParam("state") required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _showSmsCodeInput = false;
    final otpFocusNode = useFocusNode();
    final _validPhoneNumber = useState(false);
    final _validOtp = useState(false);

    const verify = 'Submit';
    const heading = 'Enter your phone number';
    const subtitle = 'You will receive an OTP via SMS';
    final enterOtp =
        AppLocalizations.of(context)?.translate("phone_verify:enter_otp");
    final labelStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        );
    final sendOtp =
        AppLocalizations.of(context)?.translate("phone_verify:send_otp");

    final screenState = ref.watch(phoneScreenStateProvider);

    switch (screenState) {
      case PhoneScreenStatus.initial:
        break;
      case PhoneScreenStatus.phoneSubmitting:
        break;
      case PhoneScreenStatus.phoneError:
        ref.read(overlayProvider).hide();
        break;
      case PhoneScreenStatus.otpSent:
        _showSmsCodeInput = true;
        ref.read(overlayProvider).hide();
        otpFocusNode.requestFocus();
        break;
      case PhoneScreenStatus.otpSubmitting:
        _showSmsCodeInput = true;
        break;
      case PhoneScreenStatus.otpError:
        ref.read(overlayProvider).hide();
        _showSmsCodeInput = true;
        break;
      case PhoneScreenStatus.success:
        ref.read(overlayProvider).hide();

        _showSmsCodeInput = true;
        if (state == 'popup') {
          final user = ref.read(otpAPIProvider).mapOrNull();
          AutoRouter.of(context).pop(user);
        } else {
          AutoRouter.of(context).push(HomeScreenRoute());
        }
        break;
      default:
    }

    return Scaffold(
      backgroundColor:
          state == 'popup' ? Theme.of(context).dialogBackgroundColor : null,
      appBar: state == 'popup' ? null : BaseAppBar(),
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
                      onValidChange: (isValid) {
                        _validPhoneNumber.value = isValid;
                      },
                      initalCountry: "IN",
                      backgroundColor: state == 'popup'
                          ? Theme.of(context).scaffoldBackgroundColor
                          : null,
                      onChange: (value) {
                        if (value != ref.read(phoneStateProvider)) {
                          ref.read(phoneScreenStateProvider.notifier).state =
                              PhoneScreenStatus.initial;
                        }
                        ref.read(phoneStateProvider.notifier).state = value;
                      },
                    ),
                    const SizedBox(height: AppInsets.xl),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _validPhoneNumber.value &&
                                  !_showSmsCodeInput
                              ? () {
                                  ref.read(overlayProvider).show(context);
                                  ref.read(phoneAPIProvider.notifier).submit();
                                }
                              : null,
                          child: Text(sendOtp!),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppInsets.xl),
                    if (_showSmsCodeInput) Text(enterOtp!, style: labelStyle),
                    if (_showSmsCodeInput)
                      CodeInput(
                        focusNode: otpFocusNode,
                        length: 4,
                        onChange: (value) {
                          ref.read(otpStateProvider.notifier).state = value;
                        },
                        onValidChange: (isValid) {
                          _validOtp.value = isValid;
                        },
                      ),
                    const SizedBox(height: 20),
                    if (_showSmsCodeInput)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: BaseLargeButton(
                            enabled: _validOtp.value,
                            onPressed: _validOtp.value
                                ? () {
                                    ref.read(overlayProvider).show(context);
                                    ref.read(otpAPIProvider.notifier).submit();
                                  }
                                : null,
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
}
