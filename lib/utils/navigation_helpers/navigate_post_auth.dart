import 'package:flutter/material.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/post_rsvp_modal.dart';

Future<void> manageRSVPPopup(
  BuildContext context,
  String creatorName, {
  int slide = 1,
}) async {
  await showModalBottomSheet(
    elevation: 10,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppBorderRadius.bottomSheetRadius),
          topRight: Radius.circular(AppBorderRadius.bottomSheetRadius),
        ),
        child: Container(
          height: 600,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
          ),
          child: PostRSVPModal(
            creatorName: creatorName,
            slide: slide,
          ),
        ),
      );
    },
  );
}
