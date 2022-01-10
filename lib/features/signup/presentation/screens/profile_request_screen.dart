import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/features/profile/presentation/widget/gradient_radio.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/theme.dart';
import '../../../../core/widgets/base/base_container/scaffold_container.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../utils/navigation_helpers/navigate_post_auth.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/profile_intro/profile_intro_bloc.dart';
import '../widgets/profile_footer.dart';
import '../widgets/profile_header.dart';

const kHeaderFraction = 0.5;
const kbottomBarHeight = 72.00;

class ProfileRequestScreen extends StatefulWidget {
  final bool editMode;

  const ProfileRequestScreen({
    Key? key,
    @PathParam("editMode") required this.editMode,
  }) : super(key: key);

  @override
  _ProfileRequestScreenState createState() => _ProfileRequestScreenState();
}

class _ProfileRequestScreenState extends State<ProfileRequestScreen> {
  late ProfileIntroBloc _bloc;
  bool allowMeetingRequests = true;

  @override
  void initState() {
    final user = BlocProvider.of<AuthBloc>(context).state.user;

    _bloc = KiwiContainer().resolve<ProfileIntroBloc>();
    if (user != null) {
      _bloc.add(GetProfileIntroRequestStarted(user: user));
    }

    if (widget.editMode) {
      allowMeetingRequests = BlocProvider.of<AuthBloc>(context)
              .state
              .profile
              ?.allowMeetingRequest ??
          true;
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
      const title =
          'Allow relevant professional to discover & request meetings with you';

      return BlocProvider.value(
          value: _bloc,
          child: BlocConsumer<ProfileIntroBloc, ProfileIntroState>(
              listener: _blocListener,
              builder: (context, state) {
                return Scaffold(
                  appBar: BaseAppBar(),
                  body: ScaffoldContainer(
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const ProfileHeader(
                                title: title,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    kHeaderFraction,
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(AppInsets.xxl),
                                    child:
                                        Image(image: AppImageAssets.splashAI),
                                  ),
                                ),
                              ),
                              FittedBox(
                                child: GradientRadio(
                                    isEnabled: allowMeetingRequests,
                                    onPressed: (value) {
                                      allowMeetingRequests = value;
                                    }),
                              )
                            ],
                          ),
                        ),
                        ProfileFooter(
                          onSave: submitAnswers,
                          // onSkip: _goToNextScreen,
                        ),
                      ],
                    ),
                  ),
                );
              }));
    });
  }

  void submitAnswers() {
    _bloc.add(PostProfileIntroRequestStarted(values: {
      'allow_meeting_request': allowMeetingRequests,
    }));
  }

  void _goToNextScreen() {
    navigateNextProfileStep(editMode: widget.editMode);
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
