import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';

import '../../../routes.gr.dart';

final deepLinkManagerProvider = Provider<DeepLinkManager>((_) {
  final providers = [DeepLinkProviderType.firebase];
  return DeepLinkManagerImpl(providers);
});

enum DeepLinkProviderType { firebase }

abstract class DeepLinkManager {
  List<DeepLinkProviderType> get providers;
  Future<void> handleDeepLink();
}

class DeepLinkManagerImpl implements DeepLinkManager {
  final List<DeepLinkProviderType> _providers;

  const DeepLinkManagerImpl(this._providers);

  @override
  List<DeepLinkProviderType> get providers => _providers;

  @override
  Future<void> handleDeepLink() async {
    for (final provider in _providers) {
      switch (provider) {
        case DeepLinkProviderType.firebase:
          await _handleFirebase();
          break;

        default:
          break;
      }
    }
  }

  Future<void> _handleFirebase() async {
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
    } else if (pathSegments.contains("new-password")) {
      _navigator.currentState
          .pushNamed(Routes.newPasswordScreen(params: deeplink.query));
    }
  }
}
