import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worknetwork/core/widgets/root_app.dart';

import '../../../../constants/theme.dart';
import '../../../../core/error/failures.dart';
import '../../../../ui/base/base_form_input/base_form_input.dart';
import '../../../../ui/base/base_large_button/base_large_button.dart';
import '../../../../utils/navigation_helpers/navigate_post_auth.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/data/repository/auth_repository_impl.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../social_auth/domain/usecase/get_social_auth_token.dart';
import '../widgets/profile_header.dart';

class ProfileEmailScreen extends HookWidget {
  final bool editMode;

  const ProfileEmailScreen({
    Key? key,
    @PathParam("editMode") required this.editMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = BlocProvider.of<AuthBloc>(context).state.user?.email;
    final allowSkip = useState(false);

    final _emailController = useTextEditingController();
    final _formKey = useState(GlobalKey<FormState>());

    if (name != null && name.trim().isNotEmpty) {
      _emailController.text = name;
    } else if (editMode == false) {
      SharedPreferences.getInstance().then((prefs) {
        final provider = prefs.getString('AuthProvider');
        if (provider == SocialAuthProviders.apple.toString()) {
          allowSkip.value = true;
        }
      });
    }

    const heading = 'Where should we send your meeting invites?';
    const subHeading =
        "This is used to block your calendar when a meeting is set up.";
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
            color: Theme.of(context).backgroundColor,
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
                    const ProfileHeader(
                      title: heading,
                      subtitle: subHeading,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppInsets.xxl, vertical: AppInsets.l),
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
                  onPressed: () => _onPressedSubmit(context,
                      _formKey.value.currentState, _emailController.text),
                ),
              ),
            ],
          )),
        ));
  }

  void _goToNextScreen(BuildContext context) {
    AutoRouter.of(context).pop();
  }

  Future<void> _onPressedSubmit(
      BuildContext context, FormState? formState, String email) async {
    final isValid = formState?.validate();
    if (isValid ?? false) {
      final _overlay = buildLoaderOverlay();

      Overlay.of(context)?.insert(_overlay);

      final data = UserModel(email: email);
      final result = await context.read(authRepositoryProvider).patchUser(data);

      _overlay.remove();

      result.fold(
        (failure) {
          try {
            final message = failure as ServerFailure?;
            final map = jsonDecode(message?.message.toString() ?? '');
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
          BlocProvider.of<AuthBloc>(context)
              .add(AuthUserUpdateRecieved(user: user));
          _goToNextScreen(context);
        },
      );
    }
  }
}
