part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final bool loading;
  final String recieverId;
  final ChatUser? receiverUser;
  final int page;
  final int pages;
  final List<ChatMessage> messages;
  final int unreadCount;
  final Object? error;

  const ChatState({
    required this.loading,
    required this.recieverId,
    this.receiverUser,
    required this.page,
    required this.pages,
    required this.messages,
    required this.unreadCount,
    this.error,
  });

  @override
  List<Object> get props => receiverUser != null
      ? [
          loading,
          recieverId,
          receiverUser!,
          page,
          pages,
          messages,
          unreadCount,
        ]
      : [
          loading,
          recieverId,
          page,
          pages,
          messages,
          unreadCount,
        ];

  ChatState copyWith({
    bool? loading,
    String? recieverId,
    ChatUser? receiverUser,
    int? page,
    int? pages,
    List<ChatMessage>? messages,
    int? unreadCount,
    dynamic error,
  }) {
    return ChatState(
      loading: loading ?? this.loading,
      recieverId: recieverId ?? this.recieverId,
      receiverUser: receiverUser ?? this.receiverUser,
      page: page ?? this.page,
      pages: pages ?? this.pages,
      messages: messages ?? this.messages,
      unreadCount: unreadCount ?? this.unreadCount,
      error: error ?? this.error,
    );
  }
}

class ChatInitial extends ChatState {
  const ChatInitial()
      : super(
            loading: false,
            recieverId: "",
            page: 1,
            pages: 1,
            messages: const [],
            unreadCount: 0,
            error: null);
}

class ChatWebSocketReady extends ChatState {
  const ChatWebSocketReady()
      : super(
          loading: false,
          recieverId: "",
          page: 1,
          pages: 1,
          messages: const [],
          unreadCount: 0,
          error: null,
        );
}

class ChatMessagePersisted extends ChatState {
  const ChatMessagePersisted({
    required String recieverId,
    required ChatUser receiverUser,
    required int page,
    required int pages,
    required List<ChatMessage> messages,
    required int unreadCount,
    required dynamic error,
  }) : super(
          loading: false,
          recieverId: recieverId,
          receiverUser: receiverUser,
          page: page,
          pages: pages,
          messages: messages,
          unreadCount: unreadCount,
          error: error,
        );
}
