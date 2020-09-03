import 'package:hive/hive.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entity/post_entity.dart';
import '../models/post_model.dart';

abstract class CommunityLocalDatasource {
  Future<void> persistPostsToCache(List<Post> results);
  List<Post> getPostsfromCache();
}

class CommunityLocalDatasourceImpl implements CommunityLocalDatasource {
  final Box<PostModel> _box = Hive.box(AppHiveBoxes.postsBox);
  @override
  List<Post> getPostsfromCache() {
    if (_box.isEmpty) {
      throw CacheException("${_box.name} is empty");
    }
    return _box.values.toList() as List<Post>;
  }

  @override
  Future<void> persistPostsToCache(List<Post> results) async {
    final Map<String, PostModel> entries = results.fold(
      {},
      (previousValue, element) => {
        ...previousValue,
        element.pk.toString(): element as PostModel,
      },
    );
    try {
      await _box.putAll(entries);
    } catch (error) {
      throw CacheException(error);
    }
  }
}
