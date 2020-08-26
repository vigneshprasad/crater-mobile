import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../chat_inbox/domain/entity/chat_user_entity.dart';
import '../entity/chat_message_entity.dart';
import '../entity/user_chat_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, void>> sendChatMessageToUser(String message);
  Future<Either<Failure, void>> sendUserIsTyping();
  Future<Either<Failure, void>> sendReadUserMessages();
  Future<Either<Failure, UserChat>> setChatWithUser(String receiverId);
  Either<Failure, Stream<dynamic>> getChatSocketStream();
  Future<Either<Failure, ChatMessage>> persistRecievedChatMessage(
    ChatMessage message,
    String chatKey,
  );
  Future<Either<Failure, UserChat>> recievedSetChatUser(
    List<ChatMessage> messages,
    ChatUser receiverUser,
    int page,
    int pages,
    int unreadCount,
  );
}
