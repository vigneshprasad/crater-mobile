import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/analytics/anlytics_events.dart';
import 'package:worknetwork/core/widgets/base/base_network_image/base_network_image.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/creator_list_state.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/utils/navigation_helpers/navigate_post_auth.dart';

class CreatorFollowCard extends HookConsumerWidget {
  late OverlayEntry? overlayEntry;

  final CreatorRow item;
  final String? authUserPk;
  late WidgetRef ref;

  late ValueNotifier<bool> isFollowing;

  CreatorFollowCard({
    Key? key,
    required this.item,
    this.authUserPk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;
    final headingStyle = Theme.of(context).textTheme.subtitle2;

    isFollowing = useState(item.isFollowing);
    final creator = item.creator;

    return InkWell(
      onTap: () => AutoRouter.of(context).push(
        ProfileScreenRoute(
          userId: creator.user,
          createrId: creator.id,
          allowEdit: authUserPk == creator.profileDetail?.pk,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: SizedBox(
              width: 100,
              height: 100,
              child: BaseNetworkImage(
                imageUrl: creator.profileDetail?.photo,
                defaultImage: AppImageAssets.defaultAvatar,
                imagebuilder: (context, imageProvider) => Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppInsets.xl),
          Expanded(
            child: Text(
              creator.profileDetail?.name ?? '',
              style: headingStyle,
              maxLines: 2,
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(
            height: AppInsets.xl,
          ),
          SizedBox(
            width: 100,
            height: 30,
            child: isFollowing.value
                ? Center(
                    child: Text(
                      'Following',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  )
                : BaseLargeButton(
                    text: 'Follow',
                    onPressed: () => onFollow(context),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> onFollow(BuildContext context) async {
    if (isFollowing.value == true) {
      return;
    }

    overlayEntry = buildLoaderOverlay();
    Overlay.of(context)?.insert(overlayEntry!);

    final response = await ref
        .read(creatorStateProvider('').notifier)
        .followCreator(item.creator.id, context);

    response.fold(
      (failure) {
        overlayEntry?.remove();
        Fluttertoast.showToast(msg: failure.message.toString());
      },
      (request) {
        overlayEntry?.remove();
        isFollowing.value = !isFollowing.value;

        final analytics = ref.read(analyticsProvider);
        analytics.trackEvent(
          eventName: AnalyticsEvents.followCreator,
          properties: {},
        );
      },
    );
  }
}
