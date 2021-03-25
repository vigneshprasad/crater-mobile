import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../constants/theme.dart';
import '../../../../../core/widgets/components/home_screen_app_bar/home_screen_app_bar.dart';
import '../../../../../utils/app_localizations.dart';
import '../roundtables_page/roundtables_page.dart';
import '../topics_filter_list/topics_filter_list.dart';

enum RoundTablePageType { all, user }

class RoundTableTab extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _pageController = usePageController();
    final activeTab = useState(0);
    final pages = [
      RoundTablePageType.all,
      RoundTablePageType.user,
    ];
    _pageController.addListener(() {
      if (_pageController.page.toInt() != activeTab.value) {
        activeTab.value = _pageController.page.toInt();
      }
    });

    return SafeArea(
      child: Column(
        children: [
          const HomeScreenAppBar(),
          Flexible(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  children: [
                    _TabHeader(
                      heading: _getTabHeader(activeTab.value, context),
                      subheading: _getTabSubHeader(activeTab.value, context),
                    ),
                    const SizedBox(height: AppInsets.l),
                    TopicsFilterList(
                      type: pages[activeTab.value],
                      onPressAction: (action) {
                        if (action == 'my_conversation') {
                          _pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: AppInsets.l),
                    _PageBuilderVertical(
                      pages: pages,
                      controller: _pageController,
                    ),
                  ],
                ),
                _PageIndicator(
                  length: pages.length,
                  selected: activeTab.value,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTabHeader(int index, BuildContext context) {
    if (index == 0) {
      return AppLocalizations.of(context).translate("conversatons:upcoming");
    } else if (index == 1) {
      return AppLocalizations.of(context).translate("conversatons:my");
    }
    return "";
  }

  String _getTabSubHeader(int index, BuildContext context) {
    switch (index) {
      case 0:
        return AppLocalizations.of(context)
            .translate("conversatons:upcoming_subheading");
      case 1:
        return AppLocalizations.of(context)
            .translate("conversatons:my_subheading");
      default:
        return "";
    }
  }
}

class _PageBuilderVertical extends StatelessWidget {
  final PageController controller;
  final List<RoundTablePageType> pages;

  const _PageBuilderVertical({
    Key key,
    @required this.controller,
    @required this.pages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: PageView.builder(
        itemCount: pages.length,
        controller: controller,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => RoundTablesPage(type: pages[index]),
      ),
    );
  }
}

class _TabHeader extends StatelessWidget {
  final String heading;
  final String subheading;

  const _TabHeader({
    Key key,
    @required this.heading,
    this.subheading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context)
        .textTheme
        .headline5
        .copyWith(fontWeight: FontWeight.w700);
    final subheadingStyle = Theme.of(context).textTheme.subtitle1.copyWith(
          color: Colors.grey[500],
        );
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
          vertical: AppInsets.sm, horizontal: AppInsets.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(heading, style: headingStyle),
          if (subheading != null)
            Text(
              subheading,
              style: subheadingStyle,
              overflow: TextOverflow.ellipsis,
            )
        ],
      ),
    );
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final int length;
  final int selected;

  const _PageIndicator({
    Key key,
    @required this.length,
    @required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 36,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildChildren(context),
        ),
      ),
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    final List<Widget> widgets = [];
    final primaryColor = Theme.of(context).primaryColor;

    for (int index = 0; index < length; index++) {
      final _selected = index == selected;
      widgets.add(Container(
        height: _selected ? 12 : 8,
        width: _selected ? 12 : 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _selected ? primaryColor : Colors.grey[400],
        ),
      ));

      if (index != length - 1) {
        widgets.add(const SizedBox(height: AppInsets.med));
      }
    }

    return widgets;
  }
}
