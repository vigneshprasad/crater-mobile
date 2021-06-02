import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiwi/kiwi.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/theme.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../ui/base/base_form_input/base_form_input.dart';
import '../../../../utils/app_localizations.dart';
import '../../../auth/domain/entity/user_entity.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/profile_setup/profile_setup_bloc.dart';
import '../widgets/profile_footer.dart';
import '../widgets/profile_header.dart';

class ProfileSetupScreen extends StatefulWidget {
  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _linkedInController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  ProfileSetupBloc _bloc;

  @override
  void initState() {
    _bloc = KiwiContainer().resolve<ProfileSetupBloc>();

    final user = BlocProvider.of<AuthBloc>(context).state.user;
    _linkedInController.text = user.linkedinUrl;

    super.initState();
  }

  @override
  void dispose() {
    _linkedInController.dispose();
    _nameController.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        String heading = 'Want to grow your influence?';
        String subHeading =
            'Enable your matches to discover you on other platforms';
        final user = authState.user;

        return BlocProvider.value(
          value: _bloc,
          child: BlocConsumer<ProfileSetupBloc, ProfileSetupState>(
            listener: _profileSetupBlocListener,
            builder: (context, state) {
              return Scaffold(
                appBar: BaseAppBar(),
                body: Column(
                  children: [
                    ProfileHeader(
                      title: heading,
                      subtitle: subHeading,
                    ),
                    _buildProfileForm(context, user),
                    const Spacer(),
                    ProfileFooter(
                      onSkip: _onPressedSkip,
                      onSave: _onPressedSubmit,
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _profileSetupBlocListener(
      BuildContext context, ProfileSetupState state) {
    if (state is PostUserProfileRequestLoaded) {
      BlocProvider.of<AuthBloc>(context)
          .add(AuthUserProfileUpdateRecieved(profile: state.profile));
      _goToNextScreen();
    }
  }

  Widget _buildProfileForm(BuildContext context, User user) {
    final linkedinLabel =
        AppLocalizations.of(context).translate("linkedin:placeholder");
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppInsets.xxl, vertical: AppInsets.l),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: AppInsets.xxl),
            const SizedBox(height: AppInsets.xxl),
            BaseFormInput(
              controller: _linkedInController,
              autovalidate: false,
              label: linkedinLabel,
              icon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  AppSvgAssets.linkedinFilled,
                  height: 12,
                  width: 12,
                ),
              ),
              validator: (value) =>
                  value.isEmpty ? "This field is required" : null,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                  onPressed: () async {
                    try {
                      final _ =
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

  void _onPressedSubmit() {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _bloc.add(PostProfileRequestStarted(
        linkedinUrl: _linkedInController.text,
      ));
    }
  }

  void _onPressedSkip() {
    _goToNextScreen();
  }

  void _goToNextScreen() {
    final bloc = BlocProvider.of<AuthBloc>(context);
    if (bloc.state.user.phoneNumberVerified) {
      ExtendedNavigator.of(context)
          .pushAndRemoveUntil(Routes.homeScreen(tab: 0), (_) => false);
    } else {
      ExtendedNavigator.of(context).push(Routes.phoneVerificationScreen);
    }
  }
}
