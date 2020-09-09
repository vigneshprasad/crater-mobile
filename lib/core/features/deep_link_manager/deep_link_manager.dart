import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';

import '../../../routes.gr.dart';

abstract class DeepLinkManager {
  Future<void> handleDeepLink();
}

class DeepLinkManagerImpl implements DeepLinkManager {
  @override
  Future<void> handleDeepLink() async {
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (linkData) async {
        final Uri deeplink = linkData?.link;
        if (deeplink != null) {
          _handleDeepLink(deeplink);
        }
      },
    );

    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deeplink = data?.link;
    if (deeplink != null) {
      _handleDeepLink(deeplink);
    }
  }

  void _handleDeepLink(Uri deeplink) {
    final GlobalKey<NavigatorState> _navigator = KiwiContainer().resolve();

    final pathSegments = deeplink.pathSegments;

    if (pathSegments.contains("community-chat")) {
      _navigator.currentState.pushNamed(Routes.homeScreen(tab: 0));
    } else if (pathSegments.contains("meetings")) {
      _navigator.currentState.pushNamed(Routes.homeScreen(tab: 1));
    } else if (pathSegments.contains("inbox")) {
      _navigator.currentState.pushNamed(Routes.homeScreen(tab: 2));
    } else if (pathSegments.contains("curated-articles")) {
      _navigator.currentState.pushNamed(Routes.homeScreen(tab: 3));
    } else if (pathSegments.contains("master-classes")) {
      _navigator.currentState.pushNamed(Routes.homeScreen(tab: 4));
    }
  }
}
