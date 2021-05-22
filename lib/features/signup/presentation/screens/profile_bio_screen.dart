import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:worknetwork/features/signup/presentation/bloc/profile_intro/profile_intro_bloc.dart';

import '../../../../constants/theme.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../ui/base/base_form_input/base_form_input.dart';
import '../../../../utils/app_localizations.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entity/profile_intro_question.dart';
import '../widgets/profile_footer.dart';
import '../widgets/profile_header.dart';

class ProfileBioScreen extends StatefulWidget {
  final bool editMode;

  const ProfileBioScreen({
    Key key,
    @PathParam("editMode") this.editMode,
  }) : super(key: key);

  @override
  _ProfileBioScreenState createState() => _ProfileBioScreenState();
}

class _ProfileBioScreenState extends State<ProfileBioScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _bioController = TextEditingController();
  ProfileIntroBloc _bloc;
  Map<String, dynamic> _values;
  @override
  void initState() {
    _values = {};
    final user = BlocProvider.of<AuthBloc>(context).state.user;

    _bloc = KiwiContainer().resolve<ProfileIntroBloc>()
      ..add(GetProfileIntroRequestStarted(user: user));

    final userProfile = BlocProvider.of<AuthBloc>(context).state.profile;
    if (userProfile != null) {
      _bioController.text = userProfile.introduction;

      // Prefill Values in Editing mode
      _values[ProfileIntroElement.introduction] = userProfile.introduction;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String heading = 'Have a few achievements to share?';
    String subHeading =
        'A detailed bio = 50% increase in the relevancy of professional connections';

    final next = AppLocalizations.of(context).translate("next");
    return BlocProvider.value(
      value: _bloc,
      child: BlocConsumer<ProfileIntroBloc, ProfileIntroState>(
        listener: _profileSetupBlocListener,
        builder: (context, state) {
          return Scaffold(
            appBar: BaseAppBar(),
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: ProfileHeader(
                      title: heading,
                      subtitle: subHeading,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _buildProfileForm(context),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: ProfileFooter(
                      onSave: _onPressedSubmit,
                      onSkip: _onPressedSkip,
                    ),
                  )
                ],
              ),
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
    final bioLabel =
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
              validator: (value) =>
                  value.isEmpty ? "This field is required" : null,
            ),
            const SizedBox(height: AppInsets.xxl),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                  onPressed: () async {
                    try {
                      final status =
                          await launch('linkedin://in/me/detail/contact-info/');
                    } catch (e) {
                      await launch(
                          'https://www.linkedin.com/in/me/detail/contact-info/');
                    }
                  },
                  child: Text('Copy From LinkedIn')),
            ),
            const SizedBox(height: AppInsets.xxl),
          ],
        ),
      ),
    );
  }

  void _goToNextScreen() {
    ExtendedNavigator.of(context)
        .push(Routes.profileSetupScreen(editMode: widget.editMode));
  }

  void _onPressedSkip() {
    _goToNextScreen();
  }

  void _onPressedSubmit() {
    final isValid = _formKey.currentState.validate();
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
