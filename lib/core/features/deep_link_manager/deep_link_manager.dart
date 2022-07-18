import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/routes.gr.dart';

final deepLinkManagerProvider = Provider<DeepLinkManager>((ref) {
  final providers = [
    DeepLinkProviderType.firebase,
  ];
  return DeepLinkManagerImpl(providers, ref.read);
});

enum DeepLinkProviderType {
  firebase,
}

abstract class DeepLinkManager {
  List<DeepLinkProviderType> get providers;
  Future<void> handleDeepLink();
}

class DeepLinkManagerImpl implements DeepLinkManager {
  final List<DeepLinkProviderType> _providers;
  final Reader read;
  const DeepLinkManagerImpl(this._providers, this.read);

  @override
  List<DeepLinkProviderType> get providers => _providers;

  @override
  Future<void> handleDeepLink() async {
    for (final provider in _providers) {
      switch (provider) {
        case DeepLinkProviderType.firebase:
          await _handleFirebaseDeepLink();
          break;

        default:
          break;
      }
    }
  }

  Future<void> _handleFirebaseDeepLink() async {
    FirebaseDynamicLinks.instance.onLink.listen((event) {
      final deeplink = event.link;
      _handleDeepLink(deeplink);
    });

    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deeplink = data?.link;
    if (deeplink != null) {
      _handleDeepLink(deeplink);
    }
  }

  void _handleDeepLink(Uri deeplink) {
    final _navigator = read(appRouterProvider);

    final pathSegments = deeplink.pathSegments;

    if (pathSegments.contains("community-chat")) {
      _navigator.push(HomeScreenRoute());
    } else if (pathSegments.contains("meetings")) {
      _navigator.push(HomeScreenRoute(tab: 1));
    } else if (pathSegments.contains("inbox")) {
      _navigator.push(HomeScreenRoute(tab: 2));
    } else if (pathSegments.contains("curated-articles")) {
      _navigator.push(HomeScreenRoute(tab: 3));
    } else if (pathSegments.contains("master-classes")) {
      _navigator.push(HomeScreenRoute(tab: 4));
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
