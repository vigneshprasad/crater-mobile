import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../constants/theme.dart';
import '../../../constants/work_net_icons_icons.dart';
import '../../../core/widgets/base/base_container/base_container.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Color color;
  final double? elevation;
  final Color? appBarActionColor;

  @override
  final Size preferredSize;

  // ignore: prefer_const_constructors_in_immutables
  BaseAppBar({
    Key? key,
    this.title,
    this.actions,
    this.color = Colors.transparent,
    this.elevation,
    this.appBarActionColor,
  })  : preferredSize = AppTheme.appBarHeight,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasback = Navigator.of(context).canPop();
    final hasDrawer = Scaffold.of(context).hasDrawer;
    final double width = MediaQuery.of(context).size.width;
    final titleWidth = MediaQuery.of(context).size.width * 0.4;
    return SafeArea(
      child: SizedBox(
        height: AppTheme.appBarHeight.height,
        width: width,
        child: Material(
          elevation: elevation ?? 0,
          color: color,
          child: Row(
            children: <Widget>[
              if (hasDrawer)
                getDrawerButton(context)
              else if (hasback)
                getBackButton(context)
              else
                const SizedBox(
                  width: AppPadding.l,
                ),
              if (title != null)
                SizedBox(
                  width: titleWidth,
                  child: title,
                ),
              if (title == null) const Spacer(),
              if (actions != null && actions!.isNotEmpty)
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions!,
                  ),
                ),
              const SizedBox(width: AppInsets.l),
            ],
          ),
        ),
      ),
    );
  }

  Widget getDrawerButton(BuildContext context) {
    final color = appBarActionColor ??
        Theme.of(context).appBarTheme.actionsIconTheme?.color;
    return IconButton(
      icon: const Icon(WorkNetIcons.menu),
      color: color,
      onPressed: () => Scaffold.of(context).openDrawer(),
    );
  }

  Widget getBackButton(BuildContext context) {
    final color = appBarActionColor ??
        Theme.of(context).appBarTheme.actionsIconTheme?.color;
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;
    final IconData icon = useCloseButton ? Icons.close : Icons.arrow_back_ios;
    return IconButton(
      icon: Icon(icon),
      color: color,
      onPressed: () => AutoRouter.of(context).pop(),
    );
  }
}
