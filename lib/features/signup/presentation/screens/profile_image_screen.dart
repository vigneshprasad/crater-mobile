import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../constants/app_constants.dart';
import '../../../../core/widgets/base/base_container/scaffold_container.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/profile_intro/profile_intro_bloc.dart';
import '../widgets/profile_footer.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_photo_picker.dart';

class ProfileImageScreen extends StatefulWidget {
  final bool editMode;

  const ProfileImageScreen({
    Key key,
    @PathParam("editMode") this.editMode,
  }) : super(key: key);

  @override
  _ProfileImageScreenState createState() => _ProfileImageScreenState();
}

class _ProfileImageScreenState extends State<ProfileImageScreen> {
  ProfileIntroBloc _bloc;
  File _photo;
  String _photoUrl;
  String _name;

  @override
  void initState() {
    final user = BlocProvider.of<AuthBloc>(context).state.user;

    _bloc = KiwiContainer().resolve<ProfileIntroBloc>()
      ..add(GetProfileIntroRequestStarted(user: user));

    _name = user.name;
    _photoUrl = user.photo;

    if (_photoUrl == null) {
      if (_name.trim().isNotEmpty) {
        final letter = _name.substring(0, 1).toLowerCase();
        _photoUrl = AppConstants.defaultAvatar[letter];
      } else {
        _photoUrl = AppConstants.defaultAvatar["default"];
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
      final title = 'Want to add a photo?';
      final info = 'Users with photos see a 70% increase in the number of people joining their group conversations';

      return BlocProvider.value(
          value: _bloc,
          child: BlocConsumer<ProfileIntroBloc, ProfileIntroState>(
              listener: _blocListener,
              builder: (context, state) {
                return Scaffold(
                  extendBody: true,
                  extendBodyBehindAppBar: true,
                  appBar: BaseAppBar(),
                  body: ScaffoldContainer(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ProfileHeader(
                              title: title,
                              subtitle: info,
                            ),
                            const Spacer(),
                            Center(
                                child: ProfilePhotoPicker(
                              photoUrl: _photoUrl,
                              onChoosePhoto: (photo) => _photo = photo,
                            )),
                            const Spacer(),
                            ProfileFooter(
                              onSave: submitAnswers,
                              onSkip: _onPressedSkip,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }));
    });
  }

  void submitAnswers() {
    _bloc.add(PostProfileIntroRequestStarted(
      values: {},
      photo: _photo,
    ));
  }

  void _goToNextScreen() {
    ExtendedNavigator.of(context)
        .push(Routes.profileBioScreen(editMode: widget.editMode));
  }

  void _onPressedSkip() {
    _goToNextScreen();
  }

  void _blocListener(BuildContext context, ProfileIntroState state) {
    if (state is ProfileIntroRequestLoaded) {
    } else if (state is PatchProfileIntroRequestLoaded) {
      final _ = BlocProvider.of<AuthBloc>(context)
        ..add(AuthUserProfileUpdateRecieved(profile: state.profile));

      _goToNextScreen();
    }
  }
}
