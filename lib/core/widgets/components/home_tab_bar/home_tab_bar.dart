import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worknetwork/constants/app_constants.dart';

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      BottomNavigationBarItem(
        label: 'Explore',
        icon: SvgPicture.asset(
          AppSvgAssets.home,
          color: Colors.grey,
          width: 20,
        ),
        activeIcon: SvgPicture.asset(
          AppSvgAssets.homeFilled,
          color: Theme.of(context).colorScheme.secondary,
          width: 20,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Streams',
        icon: SvgPicture.asset(
          AppSvgAssets.stream,
          color: Colors.grey,
          width: 20,
        ),
        activeIcon: SvgPicture.asset(
          AppSvgAssets.streamFilled,
          color: Theme.of(context).colorScheme.secondary,
          width: 20,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Creators',
        icon: SvgPicture.asset(
          AppSvgAssets.creators,
          color: Colors.grey,
          width: 20,
        ),
        activeIcon: SvgPicture.asset(
          AppSvgAssets.creatorsFilled,
          color: Theme.of(context).colorScheme.secondary,
          width: 20,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Creator Hub',
        icon: SvgPicture.asset(
          AppSvgAssets.hub,
          color: Colors.grey,
          width: 20,
        ),
        activeIcon: SvgPicture.asset(
          AppSvgAssets.hubFilled,
          color: Theme.of(context).colorScheme.secondary,
          width: 20,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Profile',
        icon: SvgPicture.asset(
          AppSvgAssets.profile,
          color: Colors.grey,
          width: 20,
        ),
        activeIcon: SvgPicture.asset(
          AppSvgAssets.profileFilled,
          color: Theme.of(context).colorScheme.secondary,
          width: 20,
        ),
      ),
    ];
    return BottomNavigationBar(
      currentIndex: _tabController.index,
      selectedFontSize: 8,
      unselectedFontSize: 8,
      type: BottomNavigationBarType.fixed,
      items: tabs,
      onTap: (int index) {
        _tabController.index = index;
      },
    );
  }
}
