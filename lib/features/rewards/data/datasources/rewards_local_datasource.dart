import 'package:hive/hive.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entity/package_entity.dart';
import '../models/package_model.dart';

abstract class RewardsLocalDatasource {
  Future<List<Package>> persistPackagesToCache(List<Package> packages);
  List<Package> getPackagesFromCache();
  Future<Package> persistPackageToCache(Package package);
  Package getPackageFromCache(int packageId);
}

class RewardsLocalDatasourceImpl implements RewardsLocalDatasource {
  final Box<PackageModel> _box = Hive.box(AppHiveBoxes.packagesBox);
  @override
  List<Package> getPackagesFromCache() {
    if (_box.isEmpty) {
      throw CacheException('${_box.name} is empty.');
    }
    return _box.values.toList();
  }

  @override
  Future<List<Package>> persistPackagesToCache(List<Package> packages) async {
    try {
      final Map<String, PackageModel> entries = packages.fold(
        {},
        (previousValue, element) => {
          element.pk.toString(): element as PackageModel,
          ...previousValue,
        },
      );
      await _box.putAll(entries);
      return packages;
    } catch (error) {
      throw CacheException(error);
    }
  }

  @override
  Package getPackageFromCache(int packageId) {
    if (_box.isEmpty) {
      throw CacheException('${_box.name} is empty.');
    }
    return _box.get(packageId.toString());
  }

  @override
  Future<Package> persistPackageToCache(Package package) async {
    try {
      await _box.put(package.pk.toString(), package as PackageModel);
      return package;
    } catch (error) {
      throw CacheException(error);
    }
  }
}
