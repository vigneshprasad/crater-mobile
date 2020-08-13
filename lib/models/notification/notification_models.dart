import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../chat/chat_model.dart';

part 'notification_models.g.dart';

@HiveType(typeId: 7)
@JsonSerializable()
class NotificationHive {
  final List<MessageNotification> messageNotifications;

  NotificationHive({
    this.messageNotifications,
  });
}
