import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/presentation/screens/phone/phone_screen_state.dart';
import 'package:worknetwork/features/signup/presentation/widgets/profile_header.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/ui/base/phone_number_input/phone_number_input.dart';

class PhoneScreen extends HookConsumerWidget {
  final String state;

  const PhoneScreen({
    Key? key,
    @PathParam("state") required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _validPhoneNumber = useState(false);

    const heading = 'Your contact number';
    const subtitle = 'We swear by our Craternaut that we will not spam you.';
    const sendOtp = 'Get OTP';

    return Scaffold(
      backgroundColor:
          state == 'popup' ? Theme.of(context).dialogBackgroundColor : null,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Theme.of(context).canvasColor,
                    child: Column(
                      children: [
                        if (state != 'popup')
                          Stack(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(top: 95),
                                child: Image(
                                  image: AppImageAssets.phone,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Image(
                                  image: AppImageAssets.circles,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: 48,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const ProfileHeader(
                                title: heading,
                                subtitle: subtitle,
                              ),
                              const SizedBox(height: 50),
                              PhoneNumberInput(
                                onValidChange: (isValid) {
                                  _validPhoneNumber.value = isValid;
                                },
                                initalCountry: "IN",
                                backgroundColor: state == 'popup'
                                    ? Theme.of(context).scaffoldBackgroundColor
                                    : null,
                                onChange: (value) {
                                  ref.read(phoneStateProvider.notifier).state =
                                      value;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 52),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                    child: BaseLargeButton(
                      text: sendOtp,
                      enabled: _validPhoneNumber.value,
                      style: BaseLargeButtonStyle.secondary,
                      onPressed: () {
                        ref.read(overlayProvider).show(context);
                        ref
                            .read(phoneAPIProvider.notifier)
                            .submit()
                            .then((value) {
                          ref.read(overlayProvider).hide();
                          if (value) {
                            AutoRouter.of(context)
                                .push(OTPScreenRoute(state: state));
                          }
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 56,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).dividerColor),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.info,
                            size: 14,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              'Verification of your phone number is needed to send you updates about creators and streams you follow on Crater.',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
