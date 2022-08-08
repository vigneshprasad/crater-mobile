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
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/creator_grid_state.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/utils/navigation_helpers/navigate_post_auth.dart';

class CreatorGrid extends HookConsumerWidget {
  final String creatorName;
  final VoidCallback? onNext;
  late WidgetRef ref;

  CreatorGrid({required this.creatorName, this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;
    final user = ref.read(authStateProvider.notifier).getUser();
    final _controller = useScrollController();
    _controller.addListener(() {
      // reached End of scroll
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        ref
            .read(creatorGridStateProvider('').notifier)
            .getNextPageProfileList('');
      }
    });
    final connectionState = ref.watch(creatorGridStateProvider(''));
    return connectionState.when(
      loading: () => Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      error: (err, st) => Center(
        child: err == null ? Container() : Text(err.toString()),
      ),
      data: (creators) {
        return Stack(
          children: [
            Container(
              color: Theme.of(context).canvasColor,
              child: ListView.builder(
                controller: _controller,
                itemCount: creators.length,
                padding: const EdgeInsets.fromLTRB(20, 180, 20, 100),
                itemBuilder: (context, index) => CreatorGridCard(
                  item: creators[index],
                  authUserPk: user?.pk,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: Theme.of(context).canvasColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Wrap(
                  runSpacing: 12,
                  children: [
                    Text(
                      "Don't miss out",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      'We will notify you prior to the stream with $creatorName. You can also follow other creators to get notified when they are live on Crater.',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      'Discover creators',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Theme.of(context).canvasColor,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: SafeArea(
                    child: Center(
                      child: BaseLargeButton(
                        onPressed: onNext,
                        text: 'Next',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CreatorGridCard extends HookConsumerWidget {
  late OverlayEntry? overlayEntry;

  final CreatorGridRow item;
  final String? authUserPk;
  late WidgetRef ref;

  late ValueNotifier<bool> isFollowing;

  CreatorGridCard({
    Key? key,
    required this.item,
    this.authUserPk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;
    final headingStyle = Theme.of(context).textTheme.subtitle2;

    isFollowing = useState(item.isFollowing);
    final creator = item.webinar.hostDetail?.creatorDetail;

    return InkWell(
      onTap: () => AutoRouter.of(context).push(
        ProfileScreenRoute(
          userId: creator?.user ?? '',
          createrId: creator?.id,
          allowEdit: authUserPk == creator?.profileDetail?.pk,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipOval(
              child: SizedBox(
                width: 50,
                height: 50,
                child: BaseNetworkImage(
                  imageUrl: creator?.profileDetail?.photo,
                  defaultImage: AppImageAssets.defaultAvatar,
                  imagebuilder: (context, imageProvider) => Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppInsets.xl),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    creator?.profileDetail?.name ?? '',
                    style: headingStyle,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: AppInsets.sm,
                  ),
                  Text(
                    'Upcoming: ${item.webinar.topicDetail?.name ?? ''}',
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: AppInsets.xl,
            ),
            SizedBox(
              // width: 100,
              // height: 40,
              child: isFollowing.value
                  ? Center(
                      child: Text(
                        'Following',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    )
                  : ElevatedButton(
                      child: Text('Follow'),
                      onPressed: () => onFollow(context),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onFollow(BuildContext context) async {
    if (isFollowing.value == true) {
      return;
    }

    overlayEntry = buildLoaderOverlay();
    Overlay.of(context)?.insert(overlayEntry!);

    final creatorId = item.webinar.hostDetail?.creatorDetail?.id;

    if (creatorId == null) {
      return;
    }

    final response = await ref
        .read(creatorGridStateProvider('').notifier)
        .followCreator(creatorId, context);

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
