import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/features/auth/presentation/widgets/user_profile_nav_item/user_profile_nav_item.dart';

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
        label: 'Live',
        icon: SvgPicture.asset(
          AppSvgAssets.streams,
          color: Colors.grey,
          width: 20,
        ),
        activeIcon: SvgPicture.asset(
          AppSvgAssets.streams,
          color: Theme.of(context).colorScheme.secondary,
          width: 20,
        ),
      ),
      const BottomNavigationBarItem(
        label: 'Past',
        icon: Icon(Icons.play_arrow_outlined),
      ),
      const BottomNavigationBarItem(
        label: 'Creators',
        icon: Icon(Icons.people_outline),
      ),
      const BottomNavigationBarItem(label: 'Hub', icon: Icon(Icons.grid_view)),
      const BottomNavigationBarItem(
        label: 'Profile',
        icon: UserProfileNavItem(),
      ),
    ];
    return BottomNavigationBar(
      currentIndex: _tabController.index,
      selectedFontSize: 12,
      type: BottomNavigationBarType.fixed,
      items: tabs,
      onTap: (int index) {
        _tabController.index = index;
      },
    );
  }
}
