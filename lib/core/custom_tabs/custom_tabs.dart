import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/theme.dart';

final customTabsProvider = Provider(
  (ref) {
    return CustomTabImpl();
  },
);

abstract class CustomTabs {
  Future<void> openLink(String link);
}

class CustomTabImpl implements CustomTabs {
  @override
  Future<void> openLink(String link) async {
    try {
      await launch(
        link,
        customTabsOption: const CustomTabsOption(
          toolbarColor: AppTheme.primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (error) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(error.toString());
    }
  }
}
