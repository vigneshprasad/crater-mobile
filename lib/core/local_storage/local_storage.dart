import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:worknetwork/constants/app_hive_boxes.dart';
import 'package:worknetwork/features/auth/data/models/user_model.dart';
import 'package:worknetwork/features/auth/data/models/user_profile_model.dart';

final localStorageProvider = FutureProvider<LocalStorage>(
  (ref) async {
    final storage = LocalStorageImpl();
    await storage.initSdk();
    storage.registerAdapters();
    await storage.initStorage();
    return storage;
  },
);

abstract class LocalStorage {
  Future<void> resetStorage();
}

class LocalStorageImpl implements LocalStorage {
  void registerAdapters() {
    // Register Adapters
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(UserProfileModelAdapter());
  }

  Future<void> initSdk() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }

  Future<void> initStorage() async {
    // Open Boxes
    try {
      await Hive.openBox<UserModel>(AppHiveBoxes.userModelBox);
      await Hive.openBox<UserProfileModel>(AppHiveBoxes.userProfileModelBox);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> resetStorage() async {
    await Hive.box<UserModel>(AppHiveBoxes.userModelBox).clear();
    await Hive.box<UserProfileModel>(AppHiveBoxes.userProfileModelBox).clear();

    initStorage();
  }
}
