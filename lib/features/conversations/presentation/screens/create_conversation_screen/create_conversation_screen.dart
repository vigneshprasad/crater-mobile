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
import '../../../data/repository/conversation_repository_impl.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';
import '../../widgets/meeting_interest_picker/meeting_interest_picker.dart';
import 'create_conversation_state.dart';

const kBottomPadding = 96.00;

class CreateConversationScreen extends HookWidget {
  final Topic topic;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CreateConversationScreen({
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

    final _scrollControiler = useScrollController();

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
                controller: _scrollControiler,
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
                        if (topic.root != null)
                          Text(
                            topic.root.name,
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
                          heading: AppLocalizations.of(context)
                              .translate("conversations:interests_label"),
                          subheading: "Pick atleast 3 options",
                        ),
                        const SizedBox(height: AppInsets.xl),
                        FormMeetingInterestPicker(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          options: meta.interests,
                          onSaved: (value) {
                            _interests.value = value;
                            if (_interests.value.length >= 3) {
                              _scrollControiler.animateTo(
                                  _scrollControiler.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            }
                          },
                          validator: (value) {
                            if (value.length < 3) {
                              return "Please select atleast 3 types of people.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppInsets.xl),
                        _FormLabel(
                            heading: AppLocalizations.of(context)
                                .translate("conversations:time_slot_label")),
                        const SizedBox(height: AppInsets.xl),
                        TimeSlotFormField(
                          initialValue: const [],
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
                    text: AppLocalizations.of(context).translate("confirm"),
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
        .read(conversationRepositoryProvider)
        .postGroupOptin(interests, timeslots, config, topic);

    response.fold(
      (failure) {
        _overlay.remove();
        Fluttertoast.showToast(msg: failure.message);
      },
      (optin) {
        _overlay.remove();
        ExtendedNavigator.of(context).pop(optin);
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
