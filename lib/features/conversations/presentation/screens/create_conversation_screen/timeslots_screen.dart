import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/widgets/base/base_container/scaffold_container.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/base/base_large_button/base_large_button.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../auth/presentation/screens/onboarding/onboarding_screen.dart';
import '../../../../meeting/data/repository/meeting_respository_impl.dart';
import '../../../../meeting/domain/entity/meeting_config_entity.dart';
import '../../../../meeting/domain/entity/meeting_interest_entity.dart';
import '../../../../meeting/domain/entity/time_slot_entity.dart';
import '../../../../meeting/presentation/widgets/time_slot_picker.dart';
import 'create_conversation_state.dart';

const kBottomPadding = 96.00;

class TimeSlotsScreen extends HookWidget {
  final String profileId;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TimeSlotsScreen({
    required this.profileId,
  });

  @override
  Widget build(BuildContext context) {
    final state =
        useProvider(getCreateTableMetaNotifier(ConversationType.curated));
    final _interests = useState<List<MeetingInterest>>([]);
    final _timeslots = useState<List<TimeSlot>>([]);
    final _formStep = useState<int>(0);

    final _scrollControiler = useScrollController();

    return ScaffoldContainer(
      child: state.when(
        loading: () => _Loader(),
        emptyConfig: () => _NoConfig(),
        data: (meta) {
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
                                TimeSlotFormField(
                                  initialValue: const [],
                                  slots: meta.config?.availableTimeSlots ?? {},
                                  onChange: (slots) => _timeslots.value = slots,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please select atleast 1 slots.";
                                    }
                                    return null;
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
                      text: 'SUBMIT',
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _postGroupOptin(
                            context,
                            _interests.value,
                            _timeslots.value,
                            meta.config!,
                          );
                        }
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
    List<TimeSlot> timeslots,
    MeetingConfig config,
  ) async {
    final _overlay = _buildLoaderOverlay();
    Overlay.of(context)?.insert(_overlay);
    final user = BlocProvider.of<AuthBloc>(context).state.profile;
    final response =
        await context.read(meetingRepositoryProvider).postMeetingRequest(
              timeslots.map((e) => e.start!).toList(),
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
