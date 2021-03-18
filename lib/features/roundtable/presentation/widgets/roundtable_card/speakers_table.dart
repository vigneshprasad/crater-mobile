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
    this.isLive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spacing = 20.0;
    final avatarSize = chairSize ?? 48.0;
    final width = (avatarSize * 4) + (spacing * 3);
    final height = (avatarSize * 3) + (spacing * 2);
    final emptyBox = SizedBox(width: avatarSize, height: avatarSize);
    final space = SizedBox(width: spacing, height: avatarSize);
    return Center(
      child: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue),
                  color: Colors.blue[50]),
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      emptyBox,
                      space,
                      SpeakerChair(
                        speaker: speakers.length > 2 ? speakers[2] : null,
                        position: SpeakerChairPosition.top,
                        avtarSize: avatarSize,
                        isLive: isLive,
                      ),
                      space,
                      SpeakerChair(
                        speaker: speakers.length > 4 ? speakers[4] : null,
                        position: SpeakerChairPosition.top,
                        avtarSize: avatarSize,
                        isLive: isLive,
                      ),
                      space,
                      emptyBox,
                    ],
                  ),
                  SizedBox(width: double.infinity, height: spacing),
                  Row(
                    children: [
                      SpeakerChair(
                        speaker: speakers.length > 0 ? speakers[0] : null,
                        position: SpeakerChairPosition.left,
                        avtarSize: avatarSize,
                        isLive: isLive,
                      ),
                      space,
                      emptyBox,
                      space,
                      emptyBox,
                      space,
                      SpeakerChair(
                        speaker: speakers.length > 1 ? speakers[1] : null,
                        position: SpeakerChairPosition.right,
                        avtarSize: avatarSize,
                        isLive: isLive,
                      ),
                    ],
                  ),
                  SizedBox(width: double.infinity, height: spacing),
                  Row(
                    children: [
                      emptyBox,
                      space,
                      SpeakerChair(
                        speaker: speakers.length > 3 ? speakers[3] : null,
                        position: SpeakerChairPosition.bottom,
                        avtarSize: avatarSize,
                        isLive: isLive,
                      ),
                      space,
                      SpeakerChair(
                        speaker: speakers.length > 5 ? speakers[5] : null,
                        position: SpeakerChairPosition.bottom,
                        avtarSize: avatarSize,
                        isLive: isLive,
                      ),
                      space,
                      emptyBox,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
