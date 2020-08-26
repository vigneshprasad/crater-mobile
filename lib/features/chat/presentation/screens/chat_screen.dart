import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/features/chat/presentation/widgets/chat_layout.dart';
import 'package:worknetwork/ui/components/chat_input_bar/chat_input_bar.dart';
import 'package:worknetwork/ui/components/list_items/chat_message_item/chat_message_item.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/chat_bloc.dart';

class ChatScreen extends StatefulWidget {
  final String recieverId;

  const ChatScreen({
    Key key,
    @required this.recieverId,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatInputController = TextEditingController();
  ChatBloc _chatBloc;
  String message;
  bool _isTyping;

  @override
  void initState() {
    _isTyping = false;
    _chatBloc = KiwiContainer().resolve<ChatBloc>();
    _chatInputController.addListener(_onChatInputChanged);
    super.initState();
  }

  @override
  void dispose() {
    _chatInputController?.dispose();
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
              } else if (chatState is ChatMessagePersisted) {}
            },
            builder: (context, chatState) {
              if (chatState.receiverUser != null) {
                return ChatLayout(
                    userIsTyping: _isTyping,
                    user: chatState.receiverUser,
                    itemCount: chatState.messages.length,
                    listBuilder: (context, index) {
                      return ChatMessageItem(
                        user: authState.user,
                        message: chatState.messages[index],
                      );
                    },
                    chatBar: ChatInputBar(
                      onSubmitPress: _onSubmitMessage,
                      controller: _chatInputController,
                      user: authState.user,
                    ));
              } else {
                return Container();
              }
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
}
