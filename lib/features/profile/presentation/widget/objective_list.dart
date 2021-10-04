import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/meeting/domain/entity/meeting_objective_entity.dart';

class ObjectiveList extends HookWidget {
  final List<MeetingObjective> objectives;

  const ObjectiveList(this.objectives);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._buildObjectives(context),
      ],
    );
  }

  List<Widget> _buildObjectives(BuildContext context) {
    const introLabel = "Objectives";
    final labelStyle = Theme.of(context).textTheme.subtitle1;
    if (objectives.isEmpty) {
      return [];
    }

    return [
      const SizedBox(height: AppInsets.xxl),
      Text(
        introLabel,
        style: labelStyle,
      ),
      const SizedBox(height: AppInsets.med),
      ...objectives
          .map((objective) => _ListItem(
                text: objective.name ?? '',
              ))
          .toList(),
    ];
  }
}

class _ListItem extends StatelessWidget {
  final String text;

  const _ListItem({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
          fontSize: 14,
          height: 1.4,
          color: Colors.grey[700],
        );
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppInsets.med),
        Text(
          text,
          style: textStyle,
        )
      ],
    );
  }
}
