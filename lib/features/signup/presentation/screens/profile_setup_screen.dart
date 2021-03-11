import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/theme.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/base/base_form_input/base_form_input.dart';
import '../../../../ui/base/base_large_button/base_large_button.dart';
import '../../../../utils/app_localizations.dart';
import '../../../auth/domain/entity/user_entity.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/profile_setup/profile_setup_bloc.dart';

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
    _bloc = KiwiContainer().resolve<ProfileSetupBloc>()
      ..add(const GetUserTagsRequestStarted());

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
        String heading = AppLocalizations.of(context)
            .translate('a_little_about_your_online_presence');
        String subHeading = AppLocalizations.of(context)
            .translate('providing_your_linkedin_will_improve_your_matches');
        final user = authState.user;
        final headingStyle = Theme.of(context).textTheme.headline5.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            );
        final subHeadingStyle = Theme.of(context).textTheme.headline6.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            );

        final next = AppLocalizations.of(context).translate("next");
        return BlocProvider.value(
          value: _bloc,
          child: BlocConsumer<ProfileSetupBloc, ProfileSetupState>(
            listener: _profileSetupBlocListener,
            builder: (context, state) {
              return Scaffold(
                body: SafeArea(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  Text(
                                    heading,
                                    style: headingStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    subHeading,
                                    style: subHeadingStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ])),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: _buildProfileForm(context, user),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: AppInsets.xxl),
                                  child: BaseLargeButton(
                                    text: next,
                                    onPressed: _onPressedSubmit,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
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
      final bloc = BlocProvider.of<AuthBloc>(context)
        ..add(AuthUserProfileUpdateRecieved(profile: state.profile));
      if (bloc.state.user.phoneNumberVerified) {
        ExtendedNavigator.of(context).popAndPush(Routes.homeScreen(tab: 0));
      } else {
        ExtendedNavigator.of(context)
            .popAndPush(Routes.phoneVerificationScreen);
      }
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
              validator: (value) =>
                  value.isEmpty ? "This field is required" : null,
            ),
            FlatButton(
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
}
