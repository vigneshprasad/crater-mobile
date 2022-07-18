import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/data/models/user_model.dart';
import 'package:worknetwork/features/auth/data/repository/auth_repository_impl.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/signup/presentation/widgets/profile_header.dart';
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
    final name = ref.read(authStateProvider.notifier).getUser()?.email;

    final _emailController = useTextEditingController();
    final _formKey = useState(GlobalKey<FormState>());

    if (name != null && name.trim().isNotEmpty) {
      _emailController.text = name;
    }

    final heading = popup == true
        ? 'Enter your email'
        : 'Block your calendar for the the stream.';
    final subHeading = popup == true
        ? ''
        : "Please provide an email ID where we can notify you";
    const firstnameLabel = 'Email';
    final height = MediaQuery.of(context).size.height * 0.8;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(AppBorderRadius.bottomSheetRadius),
        topRight: Radius.circular(AppBorderRadius.bottomSheetRadius),
      ),
      child: Container(
        height: height,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: popup == true
              ? Theme.of(context).dialogBackgroundColor
              : Theme.of(context).backgroundColor,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileHeader(
                      title: heading,
                      subtitle: subHeading,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppInsets.xxl,
                        vertical: AppInsets.l,
                      ),
                      child: Form(
                        key: _formKey.value,
                        child: Column(
                          children: [
                            const SizedBox(height: AppInsets.xxl),
                            BaseFormInput(
                              controller: _emailController,
                              autovalidate: false,
                              label: firstnameLabel,
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? "This field is required"
                                      : null,
                            ),
                            const SizedBox(height: AppInsets.xxl),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 120,
                child: BaseLargeButton(
                  text: 'Submit',
                  onPressed: () => _onPressedSubmit(
                    context,
                    _formKey.value.currentState,
                    _emailController.text,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToNextScreen(BuildContext context) {
    AutoRouter.of(context).pop();
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
