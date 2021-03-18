import 'package:flutter/material.dart';
import 'speaker_chair.dart';

class SpeakersTable extends StatelessWidget {
  final List speakers;
  final double chairSize;
  final bool isLive;

  const SpeakersTable({
    Key key,
    @required this.speakers,
    this.chairSize,
    this.isLive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const spacing = 20.0;
    const rows = 3;
    const cols = 4;

    final avatarSize = chairSize ?? 48.0;
    final tableWidth = (avatarSize * cols) + (spacing * (cols - 1));
    final tableHeight = (avatarSize * rows) + (spacing * (rows - 1));
    const spaceBetweenChairs = SizedBox(width: spacing, height: spacing);
    final primaryColor = Theme.of(context).primaryColor;

    return Center(
      child: SizedBox(
        height: tableHeight,
        width: tableWidth,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: primaryColor),
                  color: Colors.blue[50]),
            ),
            Column(
              children: [
                Row(
                  children: [
                    const Spacer(),
                    SpeakerChair(
                      speaker: speakers.length > 2 ? speakers[2] : null,
                      position: SpeakerChairPosition.top,
                      avtarSize: avatarSize,
                      isLive: isLive,
                    ),
                    spaceBetweenChairs,
                    SpeakerChair(
                      speaker: speakers.length > 4 ? speakers[4] : null,
                      position: SpeakerChairPosition.top,
                      avtarSize: avatarSize,
                      isLive: isLive,
                    ),
                    const Spacer(),
                  ],
                ),
                spaceBetweenChairs,
                Row(
                  children: [
                    SpeakerChair(
                      speaker: speakers.isNotEmpty ? speakers[0] : null,
                      position: SpeakerChairPosition.left,
                      avtarSize: avatarSize,
                      isLive: isLive,
                    ),
                    const Spacer(),
                    SpeakerChair(
                      speaker: speakers.length > 1 ? speakers[1] : null,
                      position: SpeakerChairPosition.right,
                      avtarSize: avatarSize,
                      isLive: isLive,
                    ),
                  ],
                ),
                spaceBetweenChairs,
                Row(
                  children: [
                    const Spacer(),
                    SpeakerChair(
                      speaker: speakers.length > 3 ? speakers[3] : null,
                      position: SpeakerChairPosition.bottom,
                      avtarSize: avatarSize,
                      isLive: isLive,
                    ),
                    spaceBetweenChairs,
                    SpeakerChair(
                      speaker: speakers.length > 5 ? speakers[5] : null,
                      position: SpeakerChairPosition.bottom,
                      avtarSize: avatarSize,
                      isLive: isLive,
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
