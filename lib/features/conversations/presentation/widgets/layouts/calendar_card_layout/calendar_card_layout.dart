import 'package:flutter/material.dart';
import 'package:worknetwork/core/widgets/base/base_container/base_container.dart';

import '../../../../../../constants/theme.dart';

const kCardBorderRadius = 8.00;

class CalendarCardLayout extends StatelessWidget {
  final Widget heading;
  final Widget subHeading;
  final Widget child;
  final List<Widget> rows;
  final BoxBorder border;
  final Color background;
  final VoidCallback onPressed;
  final EdgeInsets padding;

  const CalendarCardLayout({
    Key key,
    @required this.child,
    this.heading,
    this.subHeading,
    this.rows,
    this.border,
    this.background,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(
      vertical: AppInsets.l,
      horizontal: AppInsets.xl,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 16.00,
          fontWeight: FontWeight.bold,
        );
    final subheadStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 14.00,
        );
    final _background = background ?? Theme.of(context).cardColor;

    return Padding(
      padding: const EdgeInsets.only(
        top: AppInsets.xxl,
        bottom: AppInsets.xxl,
        right: AppInsets.xl,
      ),
      child: BaseContainer(
        child: Material(
          color: _background,
          borderRadius:
              const BorderRadius.all(Radius.circular(kCardBorderRadius)),
          child: InkWell(
            onTap: onPressed,
            child: Container(
              decoration: BoxDecoration(
                border: border,
                borderRadius:
                    const BorderRadius.all(Radius.circular(kCardBorderRadius)),
              ),
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (heading != null)
                    DefaultTextStyle(style: titleStyle, child: heading),
                  if (heading != null) const SizedBox(height: AppInsets.sm),
                  if (subHeading != null)
                    DefaultTextStyle(style: subheadStyle, child: subHeading),
                  Container(
                    constraints: const BoxConstraints(minHeight: 32.00),
                    child: child,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
