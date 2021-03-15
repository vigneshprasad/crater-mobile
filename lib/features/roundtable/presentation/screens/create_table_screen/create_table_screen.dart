import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../../ui/base/base_large_button/base_large_button.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../meeting/domain/entity/meeting_config_entity.dart';
import '../../../../meeting/domain/entity/meeting_interest_entity.dart';
import '../../../../meeting/domain/entity/time_slot_entity.dart';
import '../../../../meeting/presentation/widgets/time_slot_picker.dart';
import '../../../data/repository/roundtable_repository_impl.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';
import '../../widgets/meeting_interest_picker/meeting_interest_picker.dart';
import 'create_table_state.dart';

const kBottomPadding = 96.00;

class CreateTableScreen extends HookWidget {
  final Topic topic;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CreateTableScreen({
    Key key,
    @required this.topic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(getCreateTableMetaNotifier(topic.id).state);
    final topicStyle = Theme.of(context).textTheme.headline6;
    final _interests = useState<List<MeetingInterest>>([]);
    final _timeslots = useState<List<TimeSlot>>();
    final primaryColor = Theme.of(context).primaryColor;
    final descriptionStyle =
        Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey[700]);
    final rootTopicStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          color: primaryColor,
          fontSize: 14,
        );

    return Scaffold(
      appBar: BaseAppBar(),
      body: state.when(
        loading: () => _Loader(),
        emptyConfig: () => _NoConfig(),
        data: (meta) {
          return Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppInsets.xl,
                      vertical: AppInsets.l,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (meta.rootTopic != null)
                          Text(
                            meta.rootTopic.name,
                            style: rootTopicStyle,
                          ),
                        Text(
                          topic.name,
                          style: topicStyle,
                        ),
                        const SizedBox(height: AppInsets.l),
                        if (topic.description != null)
                          Text(
                            topic.description,
                            style: descriptionStyle,
                          ),
                        const SizedBox(height: AppInsets.xl),
                        _FormLabel(
                          heading: "Pick people of interest",
                          subheading: "Pick atleast 3 options",
                        ),
                        const SizedBox(height: AppInsets.xl),
                        FormMeetingInterestPicker(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          options: meta.interests,
                          onSaved: (value) => _interests.value = value,
                          validator: (value) {
                            if (value.length < 3) {
                              return "Please select atleast 3 interests.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppInsets.xl),
                        _FormLabel(heading: "Pick suitable time slots"),
                        const SizedBox(height: AppInsets.xl),
                        TimeSlotFormField(
                          initialValue: [],
                          slots: meta.config.availableTimeSlots,
                          onChange: (slots) => _timeslots.value = slots,
                          validator: (value) {
                            if (value.length < 2) {
                              return "Please select atleast 2 slots.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: kBottomPadding)
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppInsets.xxl),
                  child: BaseLargeButton(
                    text: "Submit",
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _postGroupOptin(
                          context,
                          _interests.value,
                          _timeslots.value,
                          meta.config,
                          topic,
                        );
                      }
                    },
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
    Topic topic,
  ) async {
    final _overlay = _buildLoaderOverlay();
    Overlay.of(context).insert(_overlay);
    final response = await context
        .read(roundtableRepositoryProvider)
        .postGroupOptin(interests, timeslots, config, topic);

    response.fold(
      (failure) {
        _overlay.remove();
        Fluttertoast.showToast(msg: failure.message);
      },
      (optin) {
        _overlay.remove();
        ExtendedNavigator.of(context).pop();
      },
    );
  }

  OverlayEntry _buildLoaderOverlay() {
    return OverlayEntry(
      builder: (context) {
        return Container(
          color: Colors.white.withOpacity(0.8),
          child: _Loader(),
        );
      },
    );
  }
}

class _FormLabel extends StatelessWidget {
  final String heading;
  final String subheading;

  const _FormLabel({
    Key key,
    @required this.heading,
    this.subheading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        );
    final subheadingStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 14,
          color: Colors.grey,
        );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: headingStyle,
        ),
        if (subheading != null) const SizedBox(height: AppInsets.sm),
        if (subheading != null)
          Text(
            subheading,
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
    final label = AppLocalizations.of(context).translate("error:generic");
    final labelStyle = Theme.of(context).textTheme.bodyText2.copyWith();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AppImageAssets.meetingsEmpty,
            width: 240,
          ),
          Text(label, style: labelStyle),
        ],
      ),
    );
  }
}
