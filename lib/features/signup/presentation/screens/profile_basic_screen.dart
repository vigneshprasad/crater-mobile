import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/data/models/user_model.dart';
import 'package:worknetwork/features/auth/data/repository/auth_repository_impl.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/signup/presentation/widgets/profile_header.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';
import 'package:worknetwork/ui/base/base_form_input/base_form_input.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';

class ProfileBasicScreen extends HookConsumerWidget {
  final bool editMode;
  final VoidCallback? onCompletion;
  final bool? popup;

  late WidgetRef ref;

  ProfileBasicScreen({
    Key? key,
    @PathParam("editMode") required this.editMode,
    this.onCompletion,
    this.popup = false,
  }) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool allowSkip = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;

    final _validName = useState(false);
    final _firstNameController = useTextEditingController();
    useEffect(
      () {
        final name = ref.read(authStateProvider.notifier).getUser()?.name;

        if (name != null && name.trim().isNotEmpty) {
          _validName.value = true;
          _firstNameController.text = name;
        }
        return () {
          _firstNameController.dispose();
        };
      },
      [],
    );

    String heading;
    if (editMode) {
      heading = 'Your name';
    } else {
      heading = 'Lets get started';
    }

    return Scaffold(
      backgroundColor:
          popup == true ? Theme.of(context).dialogBackgroundColor : null,
      appBar: BaseAppBar(
        actions: [
          TextButton(
            onPressed: () => _goToNextScreen(context),
            child: const Text('Skip for now'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).canvasColor,
              child: Column(
                children: [
                  Stack(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 95, left: 12),
                        child: Image(
                          image: AppImageAssets.username,
                          width: 180,
                          height: 192,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileHeader(
                          title: heading,
                          subtitle: 'This will also be your username on Crater',
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 50),
                              BaseFormInput(
                                controller: _firstNameController,
                                label: 'Your name',
                                validator: (value) {
                                  _validName.value =
                                      value != null && value.trim().isNotEmpty;
                                  return value == null || value.trim().isEmpty
                                      ? "This field is required"
                                      : null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 52,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 56,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Checkbox(
                  //   checkColor: Colors.black,
                  //   splashRadius: 0,
                  //   activeColor: Colors.white,
                  //   value: true,
                  //   onChanged: (value) {},
                  // ),
                  // Text(
                  //   'Stay anonymous',
                  //   style: Theme.of(context).textTheme.titleMedium,
                  // ),
                  // const SizedBox(
                  //   height: 4,
                  // ),
                  // Text(
                  //   'We understand that privacy is important to you. You can talk to creators and other viewers anonymously on stream chats. You can change this in chat settings.',
                  //   style: Theme.of(context).textTheme.caption,
                  // )
                  // ,
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: BaseLargeButton(
                      text: 'Done',
                      enabled: _validName.value,
                      style: BaseLargeButtonStyle.secondary,
                      onPressed: () {
                        final name = _firstNameController.text;
                        ref.read(overlayProvider).show(context);
                        ref
                            .read(authRepositoryProvider)
                            .patchUser(UserModel(name: name))
                            .then((value) {
                          ref.read(overlayProvider).hide();
                          if (value.isRight()) {
                            _goToNextScreen(context);
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _goToNextScreen(BuildContext context) {
    if (onCompletion != null) {
      onCompletion!();
      return;
    }
    if (popup == true) {
      AutoRouter.of(context).pop();
      return;
    }

    final email = ref.read(authStateProvider.notifier).getUser()?.email;

    if (email != null && email.isNotEmpty) {
      AutoRouter.of(context).pushAndPopUntil(
        HomeScreenRoute(),
        predicate: (route) => false,
      );
      return;
    }

    AutoRouter.of(context).pushAndPopUntil(
      ProfileEmailScreenRoute(editMode: false, popup: true),
      predicate: (route) => false,
    );
  }
}
