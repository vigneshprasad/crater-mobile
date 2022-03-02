import 'package:auto_route/auto_route.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../routes.gr.dart';

final deepLinkManagerProvider = Provider<DeepLinkManager>((_) {
  final providers = [DeepLinkProviderType.firebase];
  return DeepLinkManagerImpl(providers);
});

enum DeepLinkProviderType { firebase }

abstract class DeepLinkManager {
  List<DeepLinkProviderType> get providers;
  Future<void> handleDeepLink(BuildContext context);
}

class DeepLinkManagerImpl implements DeepLinkManager {
  final List<DeepLinkProviderType> _providers;

  const DeepLinkManagerImpl(this._providers);

  @override
  List<DeepLinkProviderType> get providers => _providers;

  @override
  Future<void> handleDeepLink(BuildContext context) async {
    for (final provider in _providers) {
      switch (provider) {
        case DeepLinkProviderType.firebase:
          await _handleFirebaseDeepLink(context);
          break;

        default:
          break;
      }
    }
  }

  Future<void> _handleFirebaseDeepLink(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink(onSuccess: (event) async {
      final Uri? deeplink = event?.link;
      if (deeplink!=null) {
        _handleDeepLink(deeplink, context);
      }
    });
    
    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deeplink = data?.link;
    if (deeplink != null) {
      _handleDeepLink(deeplink, context);
    }
  }

  void _handleDeepLink(Uri deeplink, BuildContext context) {
    final _navigator = AutoRouter.of(context).root;

    final pathSegments = deeplink.pathSegments;

    if (pathSegments.contains("community-chat")) {
      _navigator.push(HomeScreenRoute(tab: 0));
    } else if (pathSegments.contains("meetings")) {
      _navigator.push(HomeScreenRoute(tab: 1));
    } else if (pathSegments.contains("inbox")) {
      _navigator.push(HomeScreenRoute(tab: 2));
    } else if (pathSegments.contains("curated-articles")) {
      _navigator.push(HomeScreenRoute(tab: 3));
    } else if (pathSegments.contains("master-classes")) {
      _navigator.push(HomeScreenRoute(tab: 4));
    } else if (pathSegments.contains("new-password")) {
      _navigator.push(NewPasswordScreenRoute(params: deeplink.query));
    } else if (pathSegments.contains("group")) {
      final queryParam = deeplink.queryParameters['id'];
      if (queryParam != null) {
        final groupId = int.tryParse(queryParam);
        if (groupId != null) {
          _navigator.push(ConversationScreenRoute(id: groupId));
        }
      }
    }
  }
}
