import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/features/popup_manager/popup_manager.dart';
import '../../../../../core/widgets/base/base_container/base_container.dart';
import '../../../../../core/widgets/base/base_container/scaffold_container.dart';
import '../../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../../ui/base/base_large_button/base_large_button.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../meeting/domain/entity/meeting_config_entity.dart';
import '../../../../meeting/domain/entity/meeting_interest_entity.dart';
import '../../../../meeting/domain/entity/time_slot_entity.dart';
import '../../../../meeting/presentation/widgets/time_slot_picker.dart';
import '../../../data/repository/conversation_repository_impl.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';
import '../../widgets/article_topic_card/article_topic_card.dart';
import '../../widgets/date_time_picker/date_time_picker.dart';
import '../../widgets/meeting_interest_picker/meeting_interest_picker.dart';
import 'create_conversation_state.dart';

const kBottomPadding = 96.00;

class CreateConversationScreen extends HookWidget {
  final Topic topic;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ConversationType type;
  final _interestFormFieldKey = GlobalKey<FormFieldState>();

  CreateConversationScreen({
    Key key,
    @required this.topic,
    @required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(getCreateTableMetaNotifier(type).state);
    final topicStyle = Theme.of(context).textTheme.headline6;
    final _interests = useState<List<MeetingInterest>>([]);
    final _timeslots = useState<List<TimeSlot>>();
    final _instantTimeSlot = useState<DateTime>();
    final _formStep = useState<int>(0);
    final descriptionStyle =
        Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white70);
    final rootTopicStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 14,
        );

    final _scrollControiler = useScrollController();

    return Scaffold(
      appBar: BaseAppBar(),
      body: SafeArea(
        child: ScaffoldContainer(
          child: state.when(
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
                          vertical: AppInsets.xxl,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (topic.root != null)
                              Chip(
                                backgroundColor:
                                    Theme.of(context).backgroundColor,
                                label: Text(
                                  topic.root.name,
                                  style: rootTopicStyle,
                                ),
                              ),
                            (topic.articleDetail != null)
                                ? ArticleTopicCard(
                                    topic: topic,
                                    enabled: false,
                                  )
                                : BaseContainer(
                                    radius: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
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
                                        ],
                                      ),
                                    ),
                                  ),
                            const SizedBox(height: AppInsets.xxl * 2),
                            IndexedStack(index: _formStep.value, children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: _FormLabel(
                                      heading: AppLocalizations.of(context)
                                          .translate(
                                              "conversations:interests_label"),
                                      subheading: "Pick atleast 3 options",
                                    ),
                                  ),
                                  const SizedBox(height: AppInsets.xxl),
                                  FormMeetingInterestPicker(
                                    key: _interestFormFieldKey,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    options: meta.interests,
                                    onSaved: (value) {
                                      _interests.value = value;
                                    },
                                    validator: (value) {
                                      if (value.length < 3) {
                                        return "Please select atleast 3 types of people.";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: kBottomPadding)
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: AppInsets.xxl),
                                  Center(
                                    child: _FormLabel(
                                        heading: AppLocalizations.of(context)
                                            .translate(
                                                "conversations:time_slot_label")),
                                  ),
                                  const SizedBox(height: AppInsets.xl),
                                  if (type == ConversationType.curated)
                                    TimeSlotFormField(
                                      initialValue: const [],
                                      slots: meta.config.availableTimeSlots,
                                      onChange: (slots) =>
                                          _timeslots.value = slots,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Please select atleast 1 slots.";
                                        }
                                        return null;
                                      },
                                    ),
                                  if (type == ConversationType.instant)
                                    DateTimeFormField(
                                      slots: meta.timeSlots,
                                      onChanged: (value) =>
                                          _instantTimeSlot.value = value,
                                      validator: (value) {
                                        if (value == null) {
                                          return "Please select a timeslot";
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: AppInsets.xxl),
                      child: BaseLargeButton(
                        text: AppLocalizations.of(context).translate(
                            _formStep.value == 0 ? 'next' : "confirm"),
                        onPressed: () {
                          if (_formStep.value == 0) {
                            if (_interestFormFieldKey.currentState.validate()) {
                              _scrollControiler.animateTo(0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease);
                              Future.delayed(const Duration(milliseconds: 300))
                                  .then((value) => _formStep.value = 1);
                            }
                          } else if (_formKey.currentState.validate()) {
                            if (type == ConversationType.curated) {
                              _postGroupOptin(
                                context,
                                _interests.value,
                                _timeslots.value,
                                meta.config,
                                topic,
                              );
                            } else {
                              _postInstantConversation(context,
                                  _instantTimeSlot.value, _interests.value);
                            }
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
        ),
      ),
    );
  }

  Future<void> _postInstantConversation(
    BuildContext context,
    DateTime start,
    List<MeetingInterest> interests,
  ) async {
    final _overlay = _buildLoaderOverlay();
    final conversation = Conversation(
      topic: topic.id,
      description: topic.description,
      start: start.toLocal(),
      interests: interests.map((e) => e.pk).toList(),
      privacy: ConversationPrivacy.public,
      medium: ConversationMedium.audio,
      closed: false,
      maxSpeakers: 6,
    );

    Overlay.of(context).insert(_overlay);
    final response = await context
        .read(conversationRepositoryProvider)
        .postCreateInstantConversation(conversation);

    response.fold(
      (failure) {
        _overlay.remove();
        Fluttertoast.showToast(msg: failure.message);
      },
      (conversation) {
        _overlay.remove();

        ExtendedNavigator.of(context).pop(conversation);
      },
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
      (optin) async {
        _overlay.remove();

        final popupManager = context.read(popupManagerProvider);
        await popupManager.showPopup(PopupType.conversationOptIn, context);

        ExtendedNavigator.of(context).pop(optin);
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
        );
    final subheadingStyle = Theme.of(context).textTheme.bodyText2.copyWith(
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
