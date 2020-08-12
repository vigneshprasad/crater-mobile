import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:worknetwork/models/comment/comment_model.dart';
import 'package:worknetwork/models/post/post_model.dart';
import 'package:worknetwork/models/user/user_model.dart';

Future<void> initHive() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // Register Adapters
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(PostModelAdapter());
  Hive.registerAdapter(CommentAdapter());
}
