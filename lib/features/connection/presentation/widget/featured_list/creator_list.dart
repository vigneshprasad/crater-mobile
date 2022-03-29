import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/analytics/anlytics_events.dart';
import 'package:worknetwork/core/widgets/base/base_network_image/base_network_image.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/utils/navigation_helpers/navigate_post_auth.dart';

import '../../../../../routes.gr.dart';
import 'creator_list_state.dart';
import 'featured_list_state.dart';

class CreatorList extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthBloc>(context).state.profile;
    final _controller = useScrollController();
    _controller.addListener(() {
      // reached End of scroll
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        context
            .read(creatorStateProvider('').notifier)
            .getNextPageProfileList('');
      }
    });
    final connectionState = useProvider(creatorStateProvider(''));
    return SizedBox(
        height: 400,
        child: connectionState.when(
          loading: () => SizedBox(
            child: Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).accentColor,
            )),
          ),
          error: (err, st) => Center(
            child: err == null ? Container() : Text(err.toString()),
          ),
          data: (items) => Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Text(
                  'Creators to follow',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(
                height: 250,
                width: double.infinity,
                child: GridView.builder(
                  controller: _controller,
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 40),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1.6,
                  ),
                  itemBuilder: (context, index) => CreatorFollowCard(
                    item: items[index],
                    authUserPk: user?.pk,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class CreatorFollowCard extends HookWidget {
  late OverlayEntry? overlayEntry;

  final CreatorRow item;
  final int? authUserPk;

  late ValueNotifier<bool> isFollowing;

  CreatorFollowCard({
    Key? key,
    required this.item,
    this.authUserPk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.subtitle2;

    isFollowing = useState(item.isFollowing);
    final creator = item.creator;

    return InkWell(
      onTap: () => AutoRouter.of(context).push(
        ProfileScreenRoute(
            userId: creator.user,
            createrId: creator.id,
            allowEdit: authUserPk == creator.profileDetail?.pk),
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
                ? Text(
                    'Following',
                    style: Theme.of(context).textTheme.caption,
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

    final loginStatus = await manageLoginPopup(context);
    if (loginStatus == false) {
      return;
    }

    overlayEntry = buildLoaderOverlay();
    Overlay.of(context)?.insert(overlayEntry!);

    final response = await context
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

        final analytics = KiwiContainer().resolve<Analytics>();
        analytics.trackEvent(
            eventName: AnalyticsEvents.followCreator, properties: {});
      },
    );
  }
}
