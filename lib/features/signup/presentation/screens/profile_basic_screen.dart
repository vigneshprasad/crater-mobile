import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/data/models/user_model.dart';
import 'package:worknetwork/features/auth/data/repository/auth_repository_impl.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/signup/presentation/widgets/profile_footer.dart';
import 'package:worknetwork/features/signup/presentation/widgets/profile_header.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';
import 'package:worknetwork/ui/base/base_form_input/base_form_input.dart';

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
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();

  bool allowSkip = false;
  OverlayEntry? _overlay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;
    useEffect(
      () {
        final name = ref.read(authStateProvider.notifier).getUser()?.name;

        if (name != null && name.trim().isNotEmpty) {
          final parts = name.split(' ');
          _firstNameController.text = parts.first;
          if (parts.length > 1) {
            _lastNameController.text = parts.last;
          }
        }
        return () {
          _lastNameController.dispose();
          _firstNameController.dispose();
        };
      },
      [],
    );

    String heading;
    if (editMode) {
      heading = 'Enter your name';
    } else {
      heading = 'Lets get started';
    }

    return Scaffold(
      backgroundColor:
          popup == true ? Theme.of(context).dialogBackgroundColor : null,
      appBar: BaseAppBar(),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(title: heading),
                _buildProfileForm(context),
              ],
            ),
          ),
          const Spacer(),
          ProfileFooter(
            onSave: () => _onPressedSubmit(context),
            onSkip: () => allowSkip ? _goToNextScreen(context) : null,
          )
        ],
      ),
    );
  }

  Widget _buildProfileForm(BuildContext context) {
    const firstnameLabel = 'Your first name';
    const lastnameLabel = 'Your last name';
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppInsets.xxl,
        vertical: AppInsets.l,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: AppInsets.xxl),
            BaseFormInput(
              controller: _firstNameController,
              autovalidate: false,
              label: firstnameLabel,
              validator: (value) => value == null || value.isEmpty
                  ? "This field is required"
                  : null,
            ),
            const SizedBox(height: AppInsets.xxl),
            BaseFormInput(
              controller: _lastNameController,
              autovalidate: false,
              label: lastnameLabel,
              validator: (value) => value == null || value.isEmpty
                  ? "This field is required"
                  : null,
            ),
            const SizedBox(height: AppInsets.xxl),
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
    AutoRouter.of(context).pop();
  }

  Future<void> _onPressedSubmit(BuildContext context) async {
    final isValid = _formKey.currentState?.validate();
    if (isValid ?? false) {
      _overlay = buildLoaderOverlay();
      Overlay.of(context)?.insert(_overlay!);

      final name = '${_firstNameController.text} ${_lastNameController.text}';

      final response = await ref
          .read(authRepositoryProvider)
          .patchUser(UserModel(name: name));

      response.fold((l) => null, (r) {
        _overlay?.remove();
        _goToNextScreen(context);
      });
    }
  }
}
