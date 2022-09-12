import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/core/color/color.dart';

class StreamTime extends StatelessWidget {
  final DateTime? start;

  const StreamTime({
    Key? key,
    this.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (start == null) {
      return Container();
    }

    final startDateFormat = DateFormat("d MMMM, yyyy");
    final startTimeFormat = DateFormat('hh:mm a');
    final localDate = start!.toLocal();
    return Row(
      children: [
        SvgPicture.asset(
          AppSvgAssets.cableTV,
          width: 18,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          startDateFormat.format(localDate),
          style: Theme.of(context).textTheme.subtitle2,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          startTimeFormat.format(localDate),
          style: Theme.of(context)
              .textTheme
              .subtitle2
              ?.copyWith(color: HexColor.fromHex('#D5BBFF')),
        ),
      ],
    );
  }
}
