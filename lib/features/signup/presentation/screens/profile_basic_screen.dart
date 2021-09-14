import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worknetwork/features/social_auth/domain/usecase/get_social_auth_token.dart';
import 'package:worknetwork/utils/navigation_helpers/navigate_post_auth.dart';

import '../../../../constants/theme.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../ui/base/base_form_input/base_form_input.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/profile_basic/profile_basic_bloc.dart';
import '../widgets/profile_footer.dart';
import '../widgets/profile_header.dart';

class ProfileBasicScreen extends StatefulWidget {
  final bool editMode;

  const ProfileBasicScreen({
    Key? key,
    @PathParam("editMode") required this.editMode,
  }) : super(key: key);

  @override
  _ProfileBasicScreenState createState() => _ProfileBasicScreenState();
}

class _ProfileBasicScreenState extends State<ProfileBasicScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  late ProfileBasicBloc _bloc;
  bool allowSkip = false;

  @override
  void initState() {
    final name = BlocProvider.of<AuthBloc>(context).state.user?.name;

    _bloc = KiwiContainer().resolve<ProfileBasicBloc>();

    if (name != null && name.trim().isNotEmpty) {
      final parts = name.split(' ');
      _firstNameController.text = parts.first;
      if (parts.length > 1) {
        _lastNameController.text = parts.last;
      }
    } else if (widget.editMode == false) {
      SharedPreferences.getInstance().then((prefs) {
        final provider = prefs.getString('AuthProvider');
        if (provider == SocialAuthProviders.apple.toString()) {
          setState(() {
            allowSkip = true;
          });
        }
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const heading = 'Lets get started';

    return BlocProvider.value(
      value: _bloc,
      child: BlocConsumer<ProfileBasicBloc, ProfileBasicState>(
        listener: _profileSetupBlocListener,
        builder: (context, state) {
          return Scaffold(
            appBar: BaseAppBar(),
            body: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ProfileHeader(title: heading),
                      _buildProfileForm(context),
                    ],
                  ),
                ),
                const Spacer(),
                ProfileFooter(
                  onSave: _onPressedSubmit,
                  onSkip: allowSkip ? _goToNextScreen : null,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _bloc.close();
    super.dispose();
  }

  Widget _buildProfileForm(BuildContext context) {
    const firstnameLabel = 'Your first name';
    const lastnameLabel = 'Your last name';
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppInsets.xxl, vertical: AppInsets.l),
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

  void _goToNextScreen() {
    navigateNextProfileStep(editMode: widget.editMode);
  }

  void _onPressedSubmit() {
    final isValid = _formKey.currentState?.validate();
    if (isValid ?? false) {
      final name = '${_firstNameController.text} ${_lastNameController.text}';
      _bloc.add(PostProfileBasicRequestStarted(name: name));
    }
  }

  void _profileSetupBlocListener(
      BuildContext context, ProfileBasicState state) {
    if (state is PatchProfileBasicRequestLoaded) {
      BlocProvider.of<AuthBloc>(context)
          .add(AuthUserUpdateRecieved(user: state.user));
      BlocProvider.of<AuthBloc>(context)
          .add(AuthUserProfileUpdateRecieved(profile: state.profile));
      _goToNextScreen();
    }
  }
}
