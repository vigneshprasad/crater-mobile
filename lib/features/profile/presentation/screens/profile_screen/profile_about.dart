import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/features/socket_io/socket_io_manager.dart';
import 'package:worknetwork/core/local_storage/local_storage.dart';
import 'package:worknetwork/core/push_notfications/push_notifications.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/data/repository/auth_repository_impl.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';

class AboutTab extends HookConsumerWidget {
  final UserProfile profile;
  final Creator? creator;
  final Map<String, String>? meta;
  final bool showLogout;
  late WidgetRef ref;

  AboutTab({
    required this.profile,
    this.creator,
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
          if (profile.introduction != null ||
              profile.generatedIntroduction != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About ${profile.name}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: AppInsets.l),
                if (profile.generatedIntroduction != null)
                  Text(
                    profile.generatedIntroduction!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                if (profile.introduction != null)
                  Text(
                    profile.introduction!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(height: 1.5),
                  )
              ],
            ),
          const SizedBox(height: 40),
          if (profile.linkedIn != null)
            Column(
              children: [
                Text(
                  'Connect with ${profile.name}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: AppInsets.l),
                _buildLinkedInButton(profile.linkedIn!),
              ],
            ),
          const SizedBox(height: AppInsets.xxl),
          if (showLogout)
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BaseLargeButton(
                    style: BaseLargeButtonStyle.secondary,
                    text: 'Logout Account',
                    onPressed: () => _handleLogout(context),
                  ),
                  const SizedBox(height: 40),
                  BaseLargeButton(
                    icon: Icons.delete_forever,
                    style: BaseLargeButtonStyle.destructive,
                    text: 'Delete Account',
                    onPressed: () => deleteAccount(context),
                  ),
                ],
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
        onPressed: () {
          launchUrlString(linkedUrl);
        },
        child: SvgPicture.asset(
          AppSvgAssets.linkedinFilled,
          height: 30.0,
        ),
      ),
    );
  }

  Future<void> deleteAccount(BuildContext context) async {
    final ok = TextButton(
      child: Text(
        "Delete",
        style: Theme.of(context).textTheme.button?.copyWith(color: Colors.red),
      ),
      onPressed: () async {
        Navigator.of(context).pop();
        await requestDeleteAccount(context);
      },
    );
    final cancel = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // show the alert dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete My Account"),
          content: const Text(
            "This will delete all your information. Are you sure?",
          ),
          actions: [
            ok,
            cancel,
          ],
          actionsAlignment: MainAxisAlignment.spaceBetween,
          elevation: 5,
        );
      },
    );
  }

  Future<void> requestDeleteAccount(BuildContext context) async {
    final ok = TextButton(
      child: const Text("Okay"),
      onPressed: () async {
        Navigator.of(context).pop();
        await _handleLogout(context);
      },
    );

    // show the alert dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Request Received"),
          content: const Text(
            "We will delete your information as soon as possible.",
          ),
          actions: [
            ok,
          ],
          actionsAlignment: MainAxisAlignment.spaceBetween,
          elevation: 5,
        );
      },
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final _overlay = buildLoaderOverlay();
    Overlay.of(context)?.insert(_overlay);
    // BlocProvider.of<WebsocketBloc>(context).add(const WebSocketCloseStarted());

    final osId =
        await ref.read(pushNotificationsProvider).getSubscriptionToken();
    final response = await ref.read(authRepositoryProvider).logout(osId);

    // response.fold((l) {
    //   _overlay.remove();
    //   Fluttertoast.showToast(msg: 'Something went wrong');
    // }, (r) async {
    await ref.read(analyticsProvider).reset();
    await ref.read(localStorageProvider).value?.resetStorage();

    final socketIOManager = ref.read(userPermissionNotifierProvider.notifier);
    socketIOManager.onLogout();
    _overlay.remove();

    AutoRouter.of(context).pushAndPopUntil(
      const PhoneScreenRoute(),
      predicate: (route) => false,
    );
    // });
  }
}
