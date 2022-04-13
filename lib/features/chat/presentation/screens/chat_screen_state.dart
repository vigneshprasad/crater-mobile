import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/config_reader/config_reader.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';
import 'package:worknetwork/features/chat/data/models/chat_message_model.dart';
import 'package:worknetwork/features/chat/domain/entity/chat_message_entity.dart';

final chatStateProvider = StateNotifierProvider.autoDispose
    .family<ChatScreenState, ApiResult<List<ChatMessage>>, String>(
  (ref, id) => ChatScreenState(ref.read, id),
);

class ChatScreenState extends StateNotifier<ApiResult<List<ChatMessage>>> {
  final Reader read;
  final String webinarId;

  CollectionReference? chatRef;
  String? groupKey;

  List<ChatMessage> messages = [];

  ChatScreenState(this.read, this.webinarId)
      : super(ApiResult<List<ChatMessage>>.loading()) {
    retrieveChatMessages();
  }

  Future<void> retrieveChatMessages() async {

    groupKey = 'preprod_$webinarId';

    if(ConfigReader.getEnv() == 'prod') {
      groupKey = webinarId;
    }

    final firestore =
        FirebaseFirestore.instanceFor(app: Firebase.app('Crater'));
    chatRef =
        firestore.collection('group').doc(groupKey).collection('messages');

    final Stream<QuerySnapshot> messagesStream = chatRef!.snapshots();


    // messagesStream.listen((event) {
    //   for (final element in event.docs) {
    //     final json = element.data() as Map<String, dynamic>;
    //     final newItem = ChatMessageModel.fromJson(json);
    //     newItem.firebaseId = element.id;

    //     // Remove old item
    //     final item = messages.firstWhere((e) => e.firebaseId == element.id, orElse: ()=>ChatMessage());
    //     if (item.firebaseId != null) {
    //       messages.remove(item);
    //     }

    //     messages.add(newItem);
    //   }

    //   messages.sort((a,b) {
    //     final aCreated = a.created as Timestamp? ?? Timestamp.now();
    //     final bCreated = b.created as Timestamp? ?? Timestamp.now();
    //     return bCreated.compareTo(aCreated);
    //   });

    //   state = ApiResult<List<ChatMessage>>.data(messages);
    // });

    messagesStream.listen((event) {
      for (final element in event.docChanges) {
        final json = element.doc.data();
        final newItem = ChatMessageModel.fromJson(json!);
        newItem.firebaseId = element.doc.id;

        // Remove old item
        final item = messages.firstWhere((e) => e.firebaseId == element.doc.id, orElse: ()=>ChatMessage());
        if (item.firebaseId != null) {
          messages.remove(item);
        }

        messages.add(newItem);
      }

      messages.sort((a,b) {
        final aCreated = a.created as Timestamp? ?? Timestamp.now();
        final bCreated = b.created as Timestamp? ?? Timestamp.now();
        return bCreated.compareTo(aCreated);
      });

      state = ApiResult<List<ChatMessage>>.data(messages);
    });
  }

  Future<void> sendChatMessages(String message, User sender) async {
    final firstName = sender.name?.split(' ').first ?? '';
    final object = {
      'message': message,
      'group': groupKey,
      'sender': sender.pk,
      'display_name': firstName,
      'sender_details': {
        'email': sender.email,
        'first_name': firstName,
        'name': sender.name,
        'pk': sender.pk,
      },
      'type': 1,
      'created_at': DateTime.now(),
    };
    chatRef!.add(object);
  }
}
