import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LiveTime extends StatelessWidget {
  const LiveTime({
    Key? key,
    this.date,
  }) : super(key: key);

  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('d MMM @ H:mm');
    var dateString = '';
    if (date != null) {
      dateString = format.format(date!);
    }
    return Positioned(
      left: 10,
      top: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Text(
              'Live On',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
            const SizedBox(width: 8),
            Text(
              dateString,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
