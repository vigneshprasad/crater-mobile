import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:kiwi/kiwi.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/theme.dart';
import '../../../constants/work_net_icons_icons.dart';
import '../../../core/analytics/analytics.dart';
import '../../../core/features/websocket/presentation/bloc/websocket_bloc.dart';
import '../../../core/local_storage/local_storage.dart';
import '../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../routes.gr.dart';
import '../list_items/drawer_item/drawer_menu_item.dart';

enum DrawerItemKeys { notificationSettings, logout, account, whatsnew }

class DrawerItem extends Equatable {
  final IconData icon;
  final DrawerItemKeys key;
  final String label;

  const DrawerItem({
    required this.icon,
    required this.key,
    required this.label,
  });

  @override
  List<Object> get props => [icon, key, label];
}

class AppDrawer extends StatelessWidget {
  final List<DrawerItem> _items = const [
    // DrawerItem(
    //   icon: WorkNetIcons.notification,
    //   label: "drawer_item:notfication",
    //   key: DrawerItemKeys.notificationSettings,
    // ),
    DrawerItem(
        icon: WorkNetIcons.account,
        label: "drawer_item:account",
        key: DrawerItemKeys.account),
    DrawerItem(
        icon: Icons.open_in_new_rounded,
        label: "drawer_item:whatsnew",
        key: DrawerItemKeys.whatsnew),
    DrawerItem(
      icon: WorkNetIcons.logout,
      label: "drawer_item:logout",
      key: DrawerItemKeys.logout,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<AuthBloc>(context).state;
    return Drawer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: DrawerHeader(
            margin: const EdgeInsets.all(0),
            decoration: const BoxDecoration(
              color: AppTheme.blueAccent,
              image: DecorationImage(
                  image: AppImageAssets.drawerBg, fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state is AuthStateSuccess)
                  _buildInfoSection(context, state),
              ],
            ),
          ),
        ),
        _buildMenuItems(_items, state),
      ],
    ));
  }

  Widget _buildInfoSection(BuildContext context, AuthStateSuccess state) {
    final nameStyle = Theme.of(context).textTheme.headline5?.copyWith(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        );
    final emailStyle = Theme.of(context).textTheme.subtitle2?.copyWith(
          fontSize: 13,
          color: Colors.white.withOpacity(0.7),
        );
    return Row(
      children: [
        _buildImageAvatar(state),
        const SizedBox(width: AppInsets.med),
        LimitedBox(
          maxWidth: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.user!.name ?? "",
                style: nameStyle,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                state.user!.email ?? "",
                style: emailStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageAvatar(AuthStateSuccess state) {
    if (state.user!.photo != null) {
      return CachedNetworkImage(
        imageUrl: state.user!.photo!,
        errorWidget: (context, url, error) {
          return const CircleAvatar(
            backgroundImage: AppImageAssets.defaultAvatar,
            radius: 24,
          );
        },
        imageBuilder: (context, imageProvider) {
          return CircleAvatar(
            backgroundImage: imageProvider,
            radius: 24,
          );
        },
      );
    } else {
      return const CircleAvatar(
        backgroundImage: AppImageAssets.defaultAvatar,
        radius: 24,
      );
    }
  }

  Widget _buildMenuItems(List<DrawerItem> items, AuthState authState) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(top: AppInsets.med),
        itemCount: items.length,
        itemBuilder: (context, index) => DrawerMenuItem(
          item: items[index],
          onPressItem: (item) {
            _onPressItem(item, context, authState);
          },
        ),
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }

  void _onPressItem(
      DrawerItem item, BuildContext context, AuthState authState) {
    switch (item.key) {
      case DrawerItemKeys.logout:
        _handleLogout(context);
        break;
      case DrawerItemKeys.account:
        AutoRouter.of(context).push(
            ProfileScreenRoute(userId: authState.user!.pk!, allowEdit: true));
        break;
      case DrawerItemKeys.whatsnew:
        _openWhatsnewPage(context);
        break;
      default:
        break;
    }
  }

  Future<void> _handleLogout(BuildContext context) async {
    BlocProvider.of<WebsocketBloc>(context).add(const WebSocketCloseStarted());
    await KiwiContainer().resolve<Analytics>().reset();
    await KiwiContainer().resolve<LocalStorage>().deleteStorage();
    await KiwiContainer().resolve<LocalStorage>().initStorage();
    AutoRouter.of(context).pushAndPopUntil(const WelcomeScreenRoute(),
        predicate: (route) => false);
  }

  Future<void> _openWhatsnewPage(BuildContext context) async {
    try {
      await launch(
        AppConstants.whatsNewPageLink,
        option: CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          extraCustomTabs: const <String>[
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
