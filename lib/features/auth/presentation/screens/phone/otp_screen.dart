import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/presentation/screens/phone/otp_screen_state.dart';
import 'package:worknetwork/features/signup/presentation/widgets/profile_header.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/ui/base/code_input/code_input.dart';

class OTPScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpFocusNode = useFocusNode();
    final _validOtp = useState(false);
    const verify = 'Submit';
    const heading = 'An OTP has been sent to you';
    const subtitle =
        'Enter the 4 digit OTP sent on your mobile number to continue';

    useEffect(
      () {
        otpFocusNode.requestFocus();
        return () {};
      },
      [],
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Theme.of(context).canvasColor,
                child: Column(
                  children: [
                    Stack(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(top: 95),
                          child: Image(
                            image: AppImageAssets.phone,
                            width: 180,
                            height: 172,
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
                      height: 28,
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 52),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                child: BaseLargeButton(
                  text: verify,
                  enabled: _validOtp.value,
                  style: BaseLargeButtonStyle.secondary,
                  onPressed: () {
                    ref.read(overlayProvider).show(context);
                    ref.read(otpAPIProvider.notifier).submit().then((user) {
                      ref.read(overlayProvider).hide();
                      if (user == null) {
                        return;
                      }

                      final showUsernameScreen =
                          user.name?.trim().isEmpty ?? true;
                      if (showUsernameScreen) {
                        AutoRouter.of(context).pushAndPopUntil(
                          ProfileBasicScreenRoute(editMode: false),
                          predicate: (route) => false,
                        );
                      } else {
                        AutoRouter.of(context).pushAndPopUntil(
                          HomeScreenRoute(),
                          predicate: (route) => false,
                        );
                      }
                    });
                  },
                ),
              ),
              const SizedBox(height: AppInsets.xl),
              Row(
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
            ],
          ),
        ),
      ),
    );
  }
}
