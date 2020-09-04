import 'package:hive/hive.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entity/comment_entity.dart';
import '../../domain/entity/post_entity.dart';
import '../models/comment_model.dart';
import '../models/post_model.dart';

abstract class CommunityLocalDatasource {
  Future<void> persistPostsToCache(List<Post> results);
  List<Post> getPostsfromCache();
  Post getPostFromCache(int postId);
  Future<void> deletePostfromCache(int postId);
  List<Comment> getCommentsFromCache(int postId);
  Future<void> persistCommentsToCache(List<Comment> results);
}

class CommunityLocalDatasourceImpl implements CommunityLocalDatasource {
  final Box<PostModel> _postsBox = Hive.box(AppHiveBoxes.postsBox);
  final Box<CommentModel> _commentsBox = Hive.box(AppHiveBoxes.commentsBox);

  @override
  List<Post> getPostsfromCache() {
    if (_postsBox.isEmpty) {
      throw CacheException("${_postsBox.name} is empty");
    }
    return _postsBox.values.toList();
  }

  @override
  Post getPostFromCache(int postId) {
    if (_postsBox.isEmpty) {
      throw CacheException("${_postsBox.name} is empty");
    }
    return _postsBox.get(postId.toString());
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
      await _postsBox.putAll(entries);
    } catch (error) {
      throw CacheException(error);
    }
  }

  @override
  Future<void> deletePostfromCache(int postId) async {
    final post = _postsBox.get(postId.toString());
    if (post == null) {
      throw CacheException("Post missing in cache");
    }
    await post.delete();
  }

  @override
  List<Comment> getCommentsFromCache(int postId) {
    if (_commentsBox.isEmpty) {
      throw CacheException("${_commentsBox.name} is empty");
    }
    final comments = _commentsBox.values
        .where((element) => element.postId == postId)
        .toList();
    return comments;
  }

  @override
  Future<void> persistCommentsToCache(List<Comment> results) async {
    final Map<String, CommentModel> entries = results.fold(
      {},
      (previousValue, element) => {
        ...previousValue,
        element.pk.toString(): element as CommentModel,
      },
    );
    try {
      await _commentsBox.putAll(entries);
    } catch (error) {
      throw CacheException(error);
    }
  }
}
