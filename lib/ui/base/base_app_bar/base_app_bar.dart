import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/constants/work_net_icons_icons.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget> actions;
  final Color color;
  final double elevation;

  @override
  final Size preferredSize;

  // ignore: prefer_const_constructors_in_immutables
  BaseAppBar({
    Key key,
    this.title,
    this.actions,
    this.color,
    this.elevation,
  })  : preferredSize = AppTheme.appBarHeight,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasback = Navigator.of(context).canPop();
    final hasDrawer = Scaffold.of(context).hasDrawer;
    final double width = MediaQuery.of(context).size.width;
    final statusbarTheme = SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: AppTheme.primaryLightStatusBar,
        statusBarBrightness: Brightness.dark);
    final titleWidth = MediaQuery.of(context).size.width * 0.6;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: statusbarTheme,
      child: SafeArea(
        child: SizedBox(
          height: AppTheme.appBarHeight.height,
          width: width,
          child: Material(
            elevation: elevation ?? 0,
            color: color ?? Colors.transparent,
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
                if (actions != null && actions.isNotEmpty)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: actions,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getDrawerButton(BuildContext context) {
    return IconButton(
      icon: const Icon(WorkNetIcons.menu),
      color: Colors.black87,
      onPressed: () => Scaffold.of(context).openDrawer(),
    );
  }

  Widget getBackButton(BuildContext context) {
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);
    final bool useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;
    final IconData icon = useCloseButton ? Icons.close : Icons.arrow_back;
    return IconButton(
      icon: Icon(icon),
      color: Colors.black87,
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
