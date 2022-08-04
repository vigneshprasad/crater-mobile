import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/auth/presentation/screens/phone/phone_screen.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/post_rsvp_modal.dart';

Future<bool> manageLoginPopup(BuildContext context, WidgetRef ref) async {
  var user = ref.read(authStateProvider.notifier).getUser();
  if (user != null) {
    return true;
  }

  user = await showModalBottomSheet(
    elevation: 10,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Container(
        height: 600,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
        ),
        child: const PhoneScreen(state: 'popup'),
      );
    },
  );

  return user != null;
}

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
