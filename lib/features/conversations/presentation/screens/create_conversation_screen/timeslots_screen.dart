import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/widgets/base/base_date_time_picker/base_date_time_picker.dart.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/conversations/presentation/screens/create_conversation_screen/timeslots_screen_state.dart';
import 'package:worknetwork/features/meeting/presentation/widgets/reschedule_slot_picker.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/widgets/base/base_container/scaffold_container.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/base/base_large_button/base_large_button.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../auth/presentation/screens/onboarding/onboarding_screen.dart';
import '../../../../meeting/data/repository/meeting_respository_impl.dart';
import '../../../../meeting/domain/entity/meeting_interest_entity.dart';

const kBottomPadding = 96.00;

class TimeSlotsScreen extends HookWidget {
  final String profileId;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TimeSlotsScreen({
    required this.profileId,
  });

  @override
  Widget build(BuildContext context) {
    final state = useProvider(getTimeslotsNotifier(profileId));
    final _interests = useState<List<MeetingInterest>>([]);
    final _timeslots = useState<List<DateTime>>([]);
    final _formStep = useState<int>(0);
    final _enableButton = useState<bool>(false);

    final _scrollControiler = useScrollController();

    return ScaffoldContainer(
      child: state.when(
        loading: () => _Loader(),
        data: (timeslots) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollControiler,
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppInsets.xl,
                        vertical: AppInsets.xxl,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IndexedStack(index: _formStep.value, children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: AppInsets.xxl),
                                const Center(
                                  child: _FormLabel(heading: 'SUGGEST TIMES'),
                                ),
                                const SizedBox(height: AppInsets.xl),
                                BaseDateTimePicker<DateTime>(
                                  initialValue: _timeslots.value,
                                  timeSlots: timeslots
                                      .map((e) => [e.start!, e.end!])
                                      .toList(),
                                  getDateTime: (obj) => obj,
                                  maxLength: 3,
                                  onValueChanged: (value) {
                                    if (value.length == 3) {
                                      _enableButton.value = true;
                                    } else {
                                      _enableButton.value = false;
                                    }
                                    _timeslots.value = value;
                                  },
                                ),
                              ],
                            )
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppInsets.xxl),
                  child: Center(
                    child: BaseLargeButton(
                      enabled: _enableButton.value,
                      text: 'SUBMIT',
                      onPressed: () {
                        // if (_formKey.currentState?.validate() ?? false) {
                        _postGroupOptin(
                          context,
                          _interests.value,
                          _timeslots.value,
                        );
                        // }
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        error: (error, st) => Container(),
      ),
    );
  }

  Future<void> _postGroupOptin(
    BuildContext context,
    List<MeetingInterest> interests,
    List<DateTime> timeslots,
  ) async {
    final _overlay = _buildLoaderOverlay();
    Overlay.of(context)?.insert(_overlay);
    final user = BlocProvider.of<AuthBloc>(context).state.profile;
    final response =
        await context.read(meetingRepositoryProvider).postMeetingRequest(
              timeslots,
              user!.uuid!,
              profileId,
            );

    response.fold(
      (failure) {
        _overlay.remove();
        // Fluttertoast.showToast(msg: failure.message!);
      },
      (optin) async {
        _overlay.remove();

        // final popupManager = context.read(popupManagerProvider);
        // await popupManager.showPopup(PopupType.conversationOptIn, context);

        AutoRouter.of(context).pushAndPopUntil(
          OnboardingScreenRoute(
              type: OnboardingType.oneOnOneMeetingCreation.toString()),
          predicate: (_) => false,
        );

        // AutoRouter.of(context).pop(optin);
      },
    );
  }

  OverlayEntry _buildLoaderOverlay() {
    return OverlayEntry(
      builder: (context) {
        return Container(
          color: Theme.of(context).backgroundColor.withOpacity(0.8),
          child: _Loader(),
        );
      },
    );
  }
}

class _FormLabel extends StatelessWidget {
  final String heading;
  final String? subheading;

  const _FormLabel({
    Key? key,
    required this.heading,
    this.subheading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: 16,
        );
    final subheadingStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
          fontSize: 14,
          color: Colors.grey,
        );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          heading,
          style: headingStyle,
        ),
        if (subheading != null) const SizedBox(height: AppInsets.sm),
        if (subheading != null)
          Text(
            subheading!,
            style: subheadingStyle,
          )
      ],
    );
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _NoConfig extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context)?.translate("error:generic");
    final labelStyle = Theme.of(context).textTheme.bodyText2?.copyWith();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AppImageAssets.meetingsEmpty,
            width: 240,
          ),
          Text(label!, style: labelStyle),
        ],
      ),
    );
  }
}
