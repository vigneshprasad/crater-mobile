import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../constants/theme.dart';
import '../../../../constants/work_net_icons_icons.dart';
import '../bloc/points_bloc.dart';

class PointsBadge extends StatefulWidget {
  @override
  _PointsBadgeState createState() => _PointsBadgeState();
}

class _PointsBadgeState extends State<PointsBadge> {
  final _pointsBloc = KiwiContainer().resolve<PointsBloc>();

  @override
  void initState() {
    _pointsBloc.add(const GetUserPointsStarted());
    super.initState();
  }

  @override
  void dispose() {
    _pointsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
        );
    const borderRadius = 24.00;
    return BlocProvider.value(
      value: _pointsBloc,
      child: BlocConsumer<PointsBloc, PointsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Material(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(borderRadius),
            child: InkWell(
              highlightColor: Theme.of(context).primaryColor.withOpacity(0.2),
              splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(borderRadius),
              onTap: _updatePoints,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(color: Colors.grey[300]!, width: 2),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppInsets.l,
                  vertical: AppInsets.sm,
                ),
                child: Row(
                  children: [
                    Icon(
                      WorkNetIcons.starfill,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: AppInsets.sm),
                    Text(state.points.toString(), style: labelStyle),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _updatePoints() {
    _pointsBloc.add(const GetUserPointsStarted());
  }
}
