import 'package:hive/hive.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../constants/app_hive_boxes.dart';
import '../../../models/chat/chat_model.dart';

class NotificationRepository {
  final WebSocketChannel channel;
  Box<MessageNotification> messageNotificationsBox;

  NotificationRepository(this.channel);

  Future<Box<MessageNotification>> get box async =>
      Hive.openBox<MessageNotification>(AppHiveBoxes.notificationBox);

  Future<void> openMessageNotificationsBox() async {
    messageNotificationsBox =
        await Hive.openBox<MessageNotification>(AppHiveBoxes.notificationBox);
  }

  Future<List<MessageNotification>> setNotificationToBox(
      MessageNotification notification) async {
    messageNotificationsBox ??= await box;
    await messageNotificationsBox.put(notification.messageId, notification);
    return messageNotificationsBox.values.toList();
  }

  Future<List<MessageNotification>> getNotificationsFromBox() async {
    messageNotificationsBox ??= await box;
    return messageNotificationsBox.values.toList();
  }
}
