import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknetwork/blocs/auth/bloc/auth_bloc.dart';
import 'package:worknetwork/blocs/chat/bloc/chat_bloc.dart';
import 'package:worknetwork/blocs/notification/bloc/notification_bloc.dart';
import 'package:worknetwork/blocs/websocket/repo/websocket_repository.dart';
import 'package:worknetwork/models/chat/chat_model.dart';
import 'package:worknetwork/ui/components/chat_input_bar/chat_input_bar.dart';
import 'package:worknetwork/ui/components/list_items/chat_message_item/chat_message_item.dart';
import 'package:worknetwork/ui/screens/chat/chat_layout.dart';

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
  NotificationBloc _notificationBloc;
  ChatBloc _chatBloc;
  WebSocketRepository _webSocketRepository;
  final TextEditingController _chatInputController = TextEditingController();
  String message;
  List<ChatMessage> _messages;
  ChatUser _chatUser;

  @override
  void initState() {
    _notificationBloc = BlocProvider.of<NotificationBloc>(context);
    _webSocketRepository = RepositoryProvider.of<WebSocketRepository>(context);
    _chatBloc = ChatBloc(
      recieverId: widget.recieverId,
      webSocketRepository: _webSocketRepository,
      notificationBloc: _notificationBloc,
    )
      ..add(SetChatWithUser(recieverId: widget.recieverId))
      ..add(ChatReadMessages());
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
              if (chatState is SetChatUpdated) {
                setState(() {
                  _messages = [...chatState.messages];
                  _chatUser = chatState.recieverUser;
                });
              }
            },
            builder: (context, chatState) {
              if (_chatUser != null) {
                return ChatLayout(
                    user: _chatUser,
                    itemCount: _messages.length,
                    listBuilder: (context, index) {
                      return ChatMessageItem(
                        user: authState.user,
                        message: _messages[index],
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
    _chatBloc.add(const SendUserIsTyping());
    setState(() {
      message = _chatInputController.text;
    });
  }

  void _onSubmitMessage() {
    if (message.isNotEmpty) {
      _chatBloc.add(SendMessageToUser(message: message));
      _chatInputController.clear();
    }
  }
}
