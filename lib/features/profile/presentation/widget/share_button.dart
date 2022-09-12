import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/core/features/share_manager/share_manager.dart';

class ShareButton extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shareManager = ref.watch(shareManagerProvider);
    return IconButton(
      icon: SvgPicture.asset(
        AppSvgAssets.share,
        height: 24,
      ),
      onPressed: () => shareManager.share(context),
    );
  }
}
