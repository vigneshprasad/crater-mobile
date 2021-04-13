import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/constants/theme.dart';

class CalendarCardLayout extends StatelessWidget {
  final String heading;
  final String subHeading;
  final Widget child;
  final List<Widget> rows;

  const CalendarCardLayout({
    Key key,
    @required this.child,
    this.heading,
    this.subHeading,
    this.rows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 16.00,
        );

    const background = Color(0xFFCDDAFD);
    return Padding(
      padding: const EdgeInsets.only(
        top: AppInsets.xl,
        right: AppInsets.xl,
      ),
      child: Material(
        color: background,
        borderRadius: const BorderRadius.all(Radius.circular(8.00)),
        child: Container(
          padding: const EdgeInsets.all(AppInsets.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (heading != null) Text(heading, style: titleStyle),
              if (subHeading != null) Text(subHeading, style: titleStyle),
              Container(
                constraints: BoxConstraints(minHeight: 32.00),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
