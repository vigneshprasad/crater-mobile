import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/chat/presentation/screens/chat_reactions_screen.dart';
import 'package:worknetwork/features/conversations/domain/entity/chat_reaction_entity/chat_reaction_entity.dart';

import '../../../../ui/components/chat_input_bar/chat_input_bar.dart';
import '../../../../ui/components/list_items/chat_message_item/chat_message_item.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/chat_bloc.dart';
import '../widgets/chat_layout.dart';

class ChatScreen extends StatefulWidget {
  final String recieverId;
  final String? groupId;

  const ChatScreen({
    Key? key,
    required this.recieverId,
    this.groupId,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatInputController = TextEditingController();
  late ChatBloc _chatBloc;
  late String message;
  late bool _isTyping;
  bool showReactions = false;

  @override
  void initState() {
    _isTyping = false;
    _chatBloc = KiwiContainer().resolve<ChatBloc>();
    _chatInputController.addListener(_onChatInputChanged);
    super.initState();

    final groupId = widget.groupId ?? '';
    _chatBloc.startWebinarChat(groupId);
  }

  @override
  void dispose() {
    _chatInputController.dispose();
    _chatBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _chatBloc,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          return BlocConsumer<ChatBloc, ChatState>(
            listener: (context, chatState) {
              if (chatState is ChatWebSocketReady) {
                _chatBloc
                    .add(SetChatWithUserStarted(recieverId: widget.recieverId));
                // _chatBloc.add(const SendReadChatMessagesRequest());
              }
            },
            builder: (context, chatState) {
              // if (chatState.receiverUser != null) {
              return Stack(
                children: [
                  ChatLayout(
                    userIsTyping: _isTyping,
                    user: chatState.receiverUser,
                    itemCount: chatState.messages.length,
                    listBuilder: (context, index) {
                      return ChatMessageItem(
                        user: authState.user!,
                        message: chatState.messages[index],
                      );
                    },
                    chatBar: ChatInputBar(
                      onSubmitPress: _onSubmitMessage,
                      onReactionPress: _openReactionScreen,
                      controller: _chatInputController,
                      user: authState.user,
                      placeholder: "Send message",
                    ),
                  ),
                  SizedBox(
                    height: showReactions ? double.infinity : 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(
                                AppBorderRadius.bottomSheetRadius),
                            topRight: Radius.circular(
                                AppBorderRadius.bottomSheetRadius),
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
                                        setState(() {
                                          showReactions = false;
                                        });
                                      },
                                      icon: Icon(Icons.close))),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
              // } else {
              //   return Container();
              // }
            },
          );
        },
      ),
    );
  }

  void _onChatInputChanged() {
    _chatBloc.add(const SendUserIsTypingRequest());
    setState(() {
      message = _chatInputController.text;
    });
  }

  void _onSubmitMessage() {
    if (message.isNotEmpty) {
      _chatBloc.add(SendChatMessageStarted(message: message));
      _chatInputController.clear();
    }
  }

  void _openReactionScreen() {
    setState(() {
      showReactions = true;
    });
  }

  void _onSubmitReaction(ChatReaction reaction) {
    setState(() {
      showReactions = false;
    });
    _chatBloc.add(SendChatReactionStarted(reactionId: reaction.id.toString()));
  }
}
