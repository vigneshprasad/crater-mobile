import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/data/models/user_model.dart';
import 'package:worknetwork/features/auth/data/repository/auth_repository_impl.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/signup/presentation/widgets/profile_header.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:worknetwork/ui/base/base_form_input/base_form_input.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';

class ProfileEmailScreen extends HookConsumerWidget {
  final bool editMode;
  final bool? popup;

  late WidgetRef ref;

  ProfileEmailScreen({
    Key? key,
    @PathParam("editMode") required this.editMode,
    this.popup = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;
    final email = ref.read(authStateProvider.notifier).getUser()?.email;

    final _emailController = useTextEditingController();
    final _formKey = useState(GlobalKey<FormState>());

    if (email != null && email.trim().isNotEmpty) {
      _emailController.text = email;
    }

    final heading = popup == true
        ? 'Enter your email'
        : 'Block your calendar for the the stream.';
    const subHeading = "Please provide an email ID where we can notify you";
    const firstnameLabel = 'Email';
    return Scaffold(
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileHeader(
                          title: heading,
                          subtitle: subHeading,
                        ),
                        Form(
                          key: _formKey.value,
                          child: Column(
                            children: [
                              const SizedBox(height: 50),
                              BaseFormInput(
                                controller: _emailController,
                                autovalidate: false,
                                label: firstnameLabel,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? "This field is required"
                                        : null,
                              ),
                            ],
                          ),
                        )
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
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: BaseLargeButton(
                      text: 'Submit',
                      onPressed: () => _onPressedSubmit(
                        context,
                        _formKey.value.currentState,
                        _emailController.text,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToNextScreen(BuildContext context) {
    AutoRouter.of(context).pushAndPopUntil(
      HomeScreenRoute(),
      predicate: (route) => false,
    );
  }

  Future<void> _onPressedSubmit(
    BuildContext context,
    FormState? formState,
    String email,
  ) async {
    final isValid = formState?.validate();
    if (isValid ?? false) {
      final _overlay = buildLoaderOverlay();

      Overlay.of(context)?.insert(_overlay);

      final data = UserModel(email: email);
      final result = await ref.read(authRepositoryProvider).patchUser(data);

      _overlay.remove();

      result.fold(
        (failure) {
          try {
            final message = failure as ServerFailure?;
            final map = jsonDecode(message?.message.toString() ?? '')
                as Map<String, dynamic>?;
            final error = map?['email'] as List?;
            if (error != null) {
              Fluttertoast.showToast(msg: error.first.toString());
            } else {
              Fluttertoast.showToast(msg: failure.toString());
            }
          } catch (e) {
            Fluttertoast.showToast(msg: failure.toString());
          }
        },
        (user) {
          _goToNextScreen(context);
        },
      );
    }
  }
}
