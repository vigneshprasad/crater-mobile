import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/theme.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../ui/base/base_form_input/base_form_input.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entity/profile_intro_question.dart';
import '../bloc/profile_intro/profile_intro_bloc.dart';
import '../widgets/profile_footer.dart';
import '../widgets/profile_header.dart';

class ProfileBioScreen extends StatefulWidget {
  final bool editMode;

  const ProfileBioScreen({
    Key? key,
    @PathParam("editMode") required this.editMode,
  }) : super(key: key);

  @override
  _ProfileBioScreenState createState() => _ProfileBioScreenState();
}

class _ProfileBioScreenState extends State<ProfileBioScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _bioController = TextEditingController();
  late ProfileIntroBloc _bloc;
  late Map<String, dynamic> _values;
  @override
  void initState() {
    _values = {};
    final user = BlocProvider.of<AuthBloc>(context).state.user;

    _bloc = KiwiContainer().resolve<ProfileIntroBloc>();
    if (user != null) _bloc.add(GetProfileIntroRequestStarted(user: user));

    final userProfile = BlocProvider.of<AuthBloc>(context).state.profile;
    if (userProfile != null) {
      _bioController.text = userProfile.introduction ?? '';

      // Prefill Values in Editing mode
      _values[ProfileIntroElement.introduction] = userProfile.introduction;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const heading = 'Intro yourself';
    const subHeading =
        'Your intro is a snapshot into you & it leads to a 30% increase in the relevancy of matches.';

    return BlocProvider.value(
      value: _bloc,
      child: BlocConsumer<ProfileIntroBloc, ProfileIntroState>(
        listener: _profileSetupBlocListener,
        builder: (context, state) {
          return Scaffold(
            appBar: BaseAppBar(),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      const ProfileHeader(
                        title: heading,
                        subtitle: subHeading,
                      ),
                      _buildProfileForm(context),
                    ],
                  )),
                ),
                ProfileFooter(
                  onSave: _onPressedSubmit,
                  onSkip: _onPressedSkip,
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
    _bioController.dispose();
    _bloc.close();
    super.dispose();
  }

  Widget _buildProfileForm(BuildContext context) {
    const bioLabel =
        'A good bio talks about yout past & current professional achievements...';
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppInsets.xxl, vertical: AppInsets.l),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: AppInsets.xxl),
            BaseFormInput(
              controller: _bioController,
              autovalidate: false,
              minLines: 10,
              label: bioLabel,
              validator: (value) => value == null || value.isEmpty
                  ? "This field is required"
                  : null,
            ),
            const SizedBox(height: AppInsets.xxl),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () async {
                    try {
                      final _ =
                          await launch('linkedin://in/me/detail/contact-info/');
                    } catch (e) {
                      await launch(
                          'https://www.linkedin.com/in/me/detail/contact-info/');
                    }
                  },
                  child: const Text('Copy From LinkedIn')),
            ),
            const SizedBox(height: AppInsets.xxl),
          ],
        ),
      ),
    );
  }

  void _goToNextScreen() {
    AutoRouter.of(context).push(const ProfileSetupScreenRoute());
  }

  void _onPressedSkip() {
    _goToNextScreen();
  }

  void _onPressedSubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      _bloc.add(PostProfileIntroRequestStarted(
        values: {ProfileIntroElement.introduction: _bioController.text},
      ));
    }
  }

  void _profileSetupBlocListener(
      BuildContext context, ProfileIntroState state) {
    if (state is PatchProfileIntroRequestLoaded) {
      final _ = BlocProvider.of<AuthBloc>(context)
        ..add(AuthUserProfileUpdateRecieved(profile: state.profile));
      _goToNextScreen();
    }
  }
}
