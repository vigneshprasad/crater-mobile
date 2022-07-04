import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/upcoming_stream_list.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/creator_grid.dart';

class PostRSVPModal extends HookWidget {
  final String creatorName;
  final int slide;
  const PostRSVPModal({
    Key? key,
    required this.creatorName,
    required this.slide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final slideNumber = useState(slide);

    if (slideNumber.value == 1) {
      return CreatorGrid(
        creatorName: creatorName,
        onNext: () {
          slideNumber.value = 2;
        },
      );
    } else {
      return UpcomingStreamList();
    }
  }
}
