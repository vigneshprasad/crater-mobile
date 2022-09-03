import 'dart:async';

import 'package:flutter/material.dart';
import 'package:worknetwork/core/color/color.dart';

class TimerProgressBar extends StatefulWidget {
  Function() onComplete;

  TimerProgressBar({
    Key? key,
    required this.onComplete,
  }) : super(key: key);

  @override
  State<TimerProgressBar> createState() => _TimerProgressBarState();
}

class _TimerProgressBarState extends State<TimerProgressBar> {
  late Timer _timer;
  double width = 0.0;
  double progress = 0.0;
  double duration = 3;
  late double maxWidth;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const step = 100;
    final delta = duration / (100.0 / step);
    const oneSec = Duration(milliseconds: step);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (progress >= 100.0) {
        timer.cancel();
        widget.onComplete();
      } else {
        progress += delta;
        setState(() {
          width = progress * maxWidth / 100.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white24,
      child: Row(
        children: [
          AnimatedContainer(
            height: 8,
            width: width,
            color: HexColor.fromHex('#FA5B5B'),
            duration: Duration(milliseconds: 100),
          ),
        ],
      ),
    );
  }
}
