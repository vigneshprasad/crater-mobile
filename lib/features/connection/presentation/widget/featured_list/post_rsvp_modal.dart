import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/upcoming_stream_list.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/creator_grid.dart';

class PostRSVPModal extends HookWidget {
  final String creatorName;
  const PostRSVPModal({
    Key? key,
    required this.creatorName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final slideNumber = useState(1);

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
