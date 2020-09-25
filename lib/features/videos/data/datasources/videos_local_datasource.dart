import 'package:hive/hive.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entity/video_entity.dart';
import '../models/video_model.dart';

abstract class VideoLocalDataSource {
  Future<void> persistVideoToCache(List<Video> videos);
  List<Video> getAllVideosFromCache();
  Video getVideoItemfromCache(int objectId);
}

class VideoLocalDataSourceImpl implements VideoLocalDataSource {
  final _box = Hive.box<VideoModel>(AppHiveBoxes.videoBox);
  @override
  Future<void> persistVideoToCache(List<Video> videos) async {
    final Map<String, VideoModel> entries = videos.fold(
        {},
        (previousValue, element) => {
              ...previousValue,
              element.pk.toString(): element as VideoModel,
            });
    try {
      await _box.putAll(entries);
    } catch (error) {
      throw CacheException(error);
    }
  }

  @override
  List<Video> getAllVideosFromCache() {
    if (_box.isEmpty) return [];
    return _box.values.toList();
  }

  @override
  Video getVideoItemfromCache(int objectId) {
    final item = _box.get(objectId.toString());
    if (item == null || _box.isEmpty) throw CacheException();
    return item;
  }
}
