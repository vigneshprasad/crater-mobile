import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/analytics/anlytics_events.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/core/features/socket_io/socket_io_manager.dart';
import 'package:worknetwork/core/widgets/base/base_network_image/base_network_image.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/chat/data/models/chat_message_model.dart';
import 'package:worknetwork/features/chat/presentation/screens/chat_reactions_screen.dart';
import 'package:worknetwork/features/chat/presentation/screens/chat_screen_state.dart';
import 'package:worknetwork/features/chat/presentation/widgets/chat_layout.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/creator_list_state.dart';
import 'package:worknetwork/features/conversations/domain/entity/chat_reaction_entity/chat_reaction_entity.dart';
import 'package:worknetwork/features/conversations/presentation/screens/conversation_screen/conversation_screen_state.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/ui/components/chat_input_bar/chat_input_bar.dart';
import 'package:worknetwork/ui/components/list_items/chat_message_item/chat_message_item.dart';
import 'package:worknetwork/utils/navigation_helpers/navigate_post_auth.dart';

class ChatScreen extends HookConsumerWidget {
  final String recieverId;
  final String? groupId;
  final bool? allowChat;
  final Creator streamCreator;

  const ChatScreen({
    required this.recieverId,
    this.groupId,
    this.allowChat = true,
    required this.streamCreator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _isTyping = useState(false);
    final _chatInputController = useTextEditingController();

    final listner = ref.watch(chatStateProvider(groupId ?? ''));

    final chatState = ref.read(chatStateProvider(groupId ?? '').notifier);
    final showReactions = useState(false);

    final user = ref.read(authStateProvider.notifier).getUser();

    final conversationState =
        ref.read(conversationStateProvider(int.parse(groupId ?? '0')).notifier);

    final permissionState = ref.watch(userPermissionNotifierProvider);

    final creator = useState(streamCreator);

    if (creator.value.id == 0) {
      conversationState.addListener((state) {
        state.when(
          loading: () {},
          data: (data) {
            final c = data.conversation.hostDetail?.creatorDetail;
            if (c != null) {
              creator.value = c;
            }
          },
          error: (error, stack) {},
        );
      });
    }

    Future<void> _onSubmitMessage() async {
      final isNameFilled = await showName(context, ref);
      if (!isNameFilled) {
        return;
      }
      final isEmailFilled = await showEmail(context, ref);
      if (!isEmailFilled) {
        return;
      }

      if (_chatInputController.text.isNotEmpty && user != null) {
        ref
            .read(chatStateProvider(groupId ?? '').notifier)
            .sendChatMessages(_chatInputController.text, user);
        _chatInputController.clear();

        final analytics = ref.read(analyticsProvider);
        analytics.trackEvent(
          eventName: AnalyticsEvents.sentChatMessageStream,
          properties: {
            "id": groupId,
          },
        );
      }
    }

    void _onSubmitReaction(ChatReaction reaction) {
      showReactions.value = false;
      // _chatBloc.add(SendChatReactionStarted(reactionId: reaction.id.toString()));
    }

    useEffect(
      () {
        return () async {
          await chatState.disconnect();
        };
      },
      [],
    );

    return listner.when(
      loading: () => Container(),
      data: (modal) => Stack(
        children: [
          ChatLayout(
            userIsTyping: _isTyping.value,
            itemCount: modal.messages.length,
            listBuilder: (context, index) {
              return ChatMessageItem(
                user: user,
                message: modal.messages[index],
                conversationId: groupId ?? '',
                creator: creator.value,
              );
            },
            chatBar:
                // ChatInputBar(
                //       onSubmitPress: _onSubmitMessage,
                //       onReactionPress: () => {showReactions.value = true},
                //       controller: _chatInputController,
                //       user: user,
                //       placeholder: "Ask a question...",
                //     ) ??
                permissionState.when(
              data: (permission) {
                return permission.allowChat ?? false
                    ? ChatInputBar(
                        onSubmitPress: _onSubmitMessage,
                        onReactionPress: () => {showReactions.value = true},
                        controller: _chatInputController,
                        user: user,
                        placeholder: "Ask a question...",
                      )
                    : Container();
              },
              loading: () => Container(),
              error: (failure, stack) => Container(),
            ),
          ),
          // Column(
          //   children: [
          //     const Spacer(),
          //     Padding(
          //       padding: const EdgeInsets.all(16.0),
          //       child: Stack(
          //         children: [
          //           ChatAction(
          //             message: modal.actionQueue.first,
          //             creator: creator.value,
          //             isFollowing: false,
          //           ),
          //           TimerProgressBar()
          //         ],
          //       ),
          //     ),
          //     const SizedBox(height: 60)
          //   ],
          // ),
          SizedBox(
            height: showReactions.value ? double.infinity : 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(
                      AppBorderRadius.bottomSheetRadius,
                    ),
                    topRight: Radius.circular(
                      AppBorderRadius.bottomSheetRadius,
                    ),
                  ),
                  child: Stack(
                    children: [
                      ChatReactionsScreen(
                        onReactionSelect: _onSubmitReaction,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            showReactions.value = false;
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      error: (failure, stack) => Container(),
    );
  }
}

class TimerProgressBar extends StatefulWidget {
  const TimerProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  State<TimerProgressBar> createState() => _TimerProgressBarState();
}

class _TimerProgressBarState extends State<TimerProgressBar> {
  late Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = const Duration(seconds: 10);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (_start < 1) {
        timer.cancel();
      } else {
        setState(() {
          _start = _start - 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white24,
      child: Row(
        children: [
          Container(
            height: 8,
            width: 200.0 + (10 - _start),
            color: HexColor.fromHex('#FA5B5B'),
          ),
        ],
      ),
    );
  }
}

class ChatAction extends HookConsumerWidget {
  final ChatMessage message;
  final Creator creator;
  final bool isFollowing;

  late WidgetRef ref;

  ChatAction({
    required this.message,
    required this.creator,
    required this.isFollowing,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;

    if (message.action == 3) {
      final title = message.stream?.topicDetail?.description ??
          message.message ??
          'Join the stream';

      final startDateFormat = DateFormat('dd MMMM yyyy hh:mm a');
      final time = message.stream?.start?.toLocal() ?? DateTime.now();
      final date = startDateFormat.format(time);

      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: HexColor.fromHex("#134D34"),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SIMILAR STREAM',
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(height: 4),
                Container(
                  color: Colors.white,
                  width: 65,
                  height: 1,
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppSvgAssets.cableTV,
                      width: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      date,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                BaseLargeButton(
                  style: BaseLargeButtonStyle.secondary,
                  text: 'Remind Me',
                  icon: Icons.notifications_outlined,
                  onPressed: () => performAction(context),
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/images/chat_action_bg.png',
          ),
        ],
      );
    }

    if (message.action == 1) {
      final headingStyle = Theme.of(context).textTheme.subtitle2;
      final bodyStyle = Theme.of(context).textTheme.caption;

      final title = message.message ?? '';
      return Container(
        decoration: BoxDecoration(
          color: HexColor.fromHex("#5F1DAB"),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseNetworkImage(
                    imageUrl: creator.profileDetail?.photo,
                    defaultImage: AppImageAssets.defaultAvatar,
                    imagebuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                      radius: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(creator.profileDetail?.name ?? '',
                            style: headingStyle),
                        Text(
                          '21 Streams',
                          overflow: TextOverflow.ellipsis,
                          style: bodyStyle,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 20),
            BaseLargeButton(
              style: BaseLargeButtonStyle.secondary,
              text: 'Follow',
              onPressed: () => performAction(context),
            )
          ],
        ),
      );
    }

    return Container();
  }

  Future<void> followHost(BuildContext context) async {
    final userPK = creator.id;

    final response = await ref
        .read(creatorStateProvider('').notifier)
        .followCreator(userPK, context);

    response.fold(
      (failure) {
        // isFollowing.value = !isFollowing.value;
        // message.isFollowing = isFollowing.value;
        // Fluttertoast.showToast(msg: failure.message.toString());
      },
      (request) {
        // isFollowing.value = !isFollowing.value;
        // message.isFollowing = isFollowing.value;

        final analytics = ref.read(analyticsProvider);
        analytics.trackEvent(
          eventName: AnalyticsEvents.followCreator,
          properties: {},
        );

        // Fluttertoast.showToast(msg: '');
      },
    );
  }

  Future<void> exploreStreams(BuildContext context) async {
    await manageRSVPPopup(context, '', slide: 2);
  }

  Future<void> performAction(BuildContext context) async {
    switch (message.action) {
      case 1:
        await followHost(context);
        break;
      case 2:
        // await inviteFriends(context);
        break;
      case 3:
        await exploreStreams(context);
        break;
    }
  }
}
