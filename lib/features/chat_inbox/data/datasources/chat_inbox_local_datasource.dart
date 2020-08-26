import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:worknetwork/core/error/exceptions.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../domain/entity/chat_user_entity.dart';
import '../models/chat_user_model.dart';

abstract class ChatInboxLocalDataSource {
  Future<void> persistChatUsers(List<ChatUser> users);
  List<ChatUser> getChatUsersFromCache(String search);
  Future<ChatUser> updateUserStarredInCache({
    @required String userId,
    @required bool isStarred,
  });
}

class ChatInboxLocalDataSourceImpl implements ChatInboxLocalDataSource {
  final Box<ChatUserModel> _box = Hive.box(AppHiveBoxes.chatUserBox);

  @override
  Future<void> persistChatUsers(List<ChatUser> users) async {
    final Map<String, ChatUserModel> entries = users.fold(
      {},
      (previousValue, element) => {
        element.pk: element as ChatUserModel,
        ...previousValue,
      },
    );
    try {
      await _box.putAll(entries);
    } catch (error) {
      throw CacheException(error);
    }
  }

  @override
  List<ChatUser> getChatUsersFromCache(String search) {
    if (search == null) {
      return _box.values.toList();
    }
    return _box.values
        .where((element) => element.name.contains(search))
        .toList();
  }

  @override
  Future<ChatUser> updateUserStarredInCache(
      {String userId, bool isStarred}) async {
    final user = _box.get(userId);
    if (user == null) {
      throw CacheException("Missing user in cache");
    }
    final updated = user.copyWith(isStarred: isStarred);
    await _box.put(userId, updated);
    return updated;
  }
}
