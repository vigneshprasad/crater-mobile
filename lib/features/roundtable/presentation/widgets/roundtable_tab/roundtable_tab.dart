import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../constants/theme.dart';
import '../../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../../utils/app_localizations.dart';
import '../category_list/category_list.dart';
import '../roundtables_page/roundtables_page.dart';
import 'roundtable_tab_state.dart';

enum RoundTablePageType { all, user, upcoming }

class RoundTableTab extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final heading =
        AppLocalizations.of(context).translate("roundtable_tab:explore");
    final roundTableMetaState =
        useProvider(roundTableMetaStateNotifierProvider.state);
    final _pageController = usePageController();
    final activeTab = useState(0);
    _pageController.addListener(() {
      if (_pageController.page.toInt() != activeTab.value) {
        activeTab.value = _pageController.page.toInt();
      }
    });
    return SafeArea(
      child: roundTableMetaState.when(
        loading: () => _Loader(),
        data: (meta) {
          final pageType = [
            if (meta.user > 0) RoundTablePageType.user,
            if (meta.upcoming > 0) RoundTablePageType.upcoming,
            RoundTablePageType.all,
          ];

          final categoriesViews = pageType
              .map((type) => CategoriesList(
                    type: type,
                    key: ValueKey<RoundTablePageType>(type),
                  ))
              .toList();

          return Column(
            children: [
              BaseAppBar(),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _TabHeader(
                            heading: _getTabHeader(pageType[activeTab.value])),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                          child: categoriesViews[activeTab.value],
                        ),
                        Expanded(
                          child: PageView.builder(
                            scrollDirection: Axis.vertical,
                            controller: _pageController,
                            itemCount: pageType.length,
                            itemBuilder: (context, index) =>
                                RoundTablesPage(type: pageType[index]),
                          ),
                        ),
                      ],
                    ),
                    if (pageType.length > 1)
                      _PageIndicator(
                        length: pageType.length,
                        selected: activeTab.value,
                      )
                  ],
                ),
              ),
            ],
          );
        },
        error: (error, st) => Container(),
      ),
    );
  }

  String _getTabHeader(RoundTablePageType type) {
    switch (type) {
      case RoundTablePageType.all:
        return "Explore RoundTables";
      case RoundTablePageType.user:
        return "My Tables";
      case RoundTablePageType.upcoming:
        return "Upcoming Tables";
      default:
        return "";
    }
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
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
          vertical: AppInsets.med, horizontal: AppInsets.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(heading, style: headingStyle),
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
