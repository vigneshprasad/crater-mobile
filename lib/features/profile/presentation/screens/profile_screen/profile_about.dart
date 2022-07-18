import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/custom_tabs/custom_tabs.dart';
import 'package:worknetwork/core/features/socket_io/socket_io_manager.dart';
import 'package:worknetwork/core/local_storage/local_storage.dart';
import 'package:worknetwork/core/push_notfications/push_notifications.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/data/repository/auth_repository_impl.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';

class AboutTab extends HookConsumerWidget {
  final UserProfile profile;
  final Map<String, String>? meta;
  final bool showLogout;
  late WidgetRef ref;

  AboutTab({
    required this.profile,
    this.meta,
    required this.showLogout,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Me',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(height: AppInsets.l),
          if (profile.introduction != null ||
              profile.generatedIntroduction != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (profile.generatedIntroduction != null)
                  Text(
                    profile.generatedIntroduction!,
                  ),
                if (profile.introduction != null)
                  Text(
                    profile.introduction!,
                  )
              ],
            ),
          const SizedBox(height: 40),
          if (meta?.isNotEmpty ?? false)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Snapshot',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: AppInsets.l),
                Column(
                  children: meta!.entries
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text(
                                  e.key,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  e.value,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          const SizedBox(height: AppInsets.xxl),
          Text(
            'Connect',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(height: AppInsets.l),
          if (profile.linkedIn != null) _buildLinkedInButton(profile.linkedIn!),
          const SizedBox(height: AppInsets.xxl),
          if (showLogout)
            Center(
              child: BaseLargeButton(
                text: 'Logout',
                onPressed: () => _handleLogout(context),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildLinkedInButton(String linkedUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RawMaterialButton(
        constraints: const BoxConstraints(
          minWidth: 40,
        ),
        fillColor: AppTheme.linkedInColor,
        padding: const EdgeInsets.symmetric(
          vertical: AppInsets.sm,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () => ref.read(customTabsProvider).openLink(linkedUrl),
        child: SvgPicture.asset(
          AppSvgAssets.linkedinFilled,
          height: 30.0,
        ),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final _overlay = buildLoaderOverlay();
    Overlay.of(context)?.insert(_overlay);
    // BlocProvider.of<WebsocketBloc>(context).add(const WebSocketCloseStarted());

    final osId =
        await ref.read(pushNotificationsProvider).getSubscriptionToken();
    final response = await ref.read(authRepositoryProvider).logout(osId);

    response.fold((l) {
      _overlay.remove();
    }, (r) async {
      await ref.read(analyticsProvider).reset();
      await ref.read(localStorageProvider).value?.resetStorage();

      final socketIOManager = ref.read(userPermissionNotifierProvider.notifier);
      socketIOManager.onLogout();
      _overlay.remove();

      AutoRouter.of(context).pushAndPopUntil(
        const SplashScreenRoute(),
        predicate: (route) => false,
      );
    });
  }
}
