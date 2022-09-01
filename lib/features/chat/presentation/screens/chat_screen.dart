import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/analytics/anlytics_events.dart';
import 'package:worknetwork/core/features/socket_io/socket_io_manager.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/chat/data/models/chat_message_model.dart';
import 'package:worknetwork/features/chat/presentation/screens/chat_reactions_screen.dart';
import 'package:worknetwork/features/chat/presentation/screens/chat_screen_state.dart';
import 'package:worknetwork/features/chat/presentation/widgets/chat_action.dart';
import 'package:worknetwork/features/chat/presentation/widgets/chat_layout.dart';
import 'package:worknetwork/features/chat/presentation/widgets/timer_progress_bar.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/conversations/domain/entity/chat_reaction_entity/chat_reaction_entity.dart';
import 'package:worknetwork/features/conversations/presentation/screens/conversation_screen/conversation_screen_state.dart';
import 'package:worknetwork/ui/components/chat_input_bar/chat_input_bar.dart';
import 'package:worknetwork/ui/components/list_items/chat_message_item/chat_message_item.dart';

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
      data: (modal) {
        return Stack(
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
            if (modal.actionQueue.isNotEmpty)
              ChatAction(
                message: modal.actionQueue.isEmpty
                    ? ChatMessage(action: 3)
                    : modal.actionQueue.first,
                creator: creator.value,
                isFollowing: false,
              ),
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
        );
      },
      error: (failure, stack) => Container(),
    );
  }
}
