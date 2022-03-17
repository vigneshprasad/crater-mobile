import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/widgets/base/base_network_image/base_network_image.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/utils/navigation_helpers/navigate_post_auth.dart';

import '../../../../../routes.gr.dart';
import 'featured_list_state.dart';

class FeaturedList extends HookWidget {

  final Axis scrollDirection;
  final bool showFollow;

  const FeaturedList({this.scrollDirection = Axis.vertical, this.showFollow = false});

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthBloc>(context).state.profile;
    final _controller = useScrollController();
    _controller.addListener(() {
      // reached End of scroll
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        context
            .read(featuredConnectionStateProvider('').notifier)
            .getNextPageProfileList('');
      }
    });
    final connectionState = useProvider(featuredConnectionStateProvider(''));
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: connectionState.when(
        loading: () => Center(
            child: CircularProgressIndicator(
          color: Theme.of(context).accentColor,
        )),
        error: (err, st) => Center(
          child: err == null ? Container() : Text(err.toString()),
        ),
        // data: (creators) => ListView.separated(
        //   separatorBuilder: (context, index) => const SizedBox(width: 20),
        //   scrollDirection: Axis.horizontal,
        //   itemCount: creators.length,
        //   controller: _controller,
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   itemBuilder: (BuildContext context, int index) {
            // return CreatorCard(
            //   creator: creators[index],
            //   authUserPk: user?.pk, //TODO: pass auth user pk.
            //   showConnect: false,
            // );
        //   },
        // ),
        data: (creators) => GridView.builder(
            controller: _controller,
            itemCount: creators.length,
            scrollDirection: scrollDirection,
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 40),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: scrollDirection == Axis.horizontal ? 1 : 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio:  (scrollDirection == Axis.horizontal ? 1.2 : 0.65) + (showFollow ? 0.3 : 0),
            ),
            itemBuilder: (context, index) => CreatorCard(
              creator: creators[index],
              authUserPk: user?.pk,
              showConnect: showFollow,
              isFollowing: creators[index].isFollower ?? false,
            )
      ),)
    );
  }
}

class CreatorCard extends HookWidget {

  late OverlayEntry? overlayEntry;

  final Creator creator;
  final int? authUserPk;
  final bool showConnect;

  bool isFollowing;

  CreatorCard({
    Key? key,
    required this.creator,
    this.authUserPk,
    required this.showConnect,
    required this.isFollowing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.subtitle2;

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
          SizedBox(
            width: 100,
            height: 120,
            child: BaseNetworkImage(
              imageUrl: creator.profileDetail?.photo,
              defaultImage: AppImageAssets.defaultAvatar,
              imagebuilder: (context, imageProvider) => Image(
                image: imageProvider,
                fit: BoxFit.cover,
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
          const SizedBox(height: AppInsets.xl,),
          if(showConnect)
            SizedBox(
              width: 100,
              height: 30,
              child: BaseLargeButton(
                    enabled: !isFollowing,
                    text: isFollowing ? 'Following' : 'Follow',
                    onPressed: () => onFollow(context),
              ),
            ),
          // const SizedBox(height: AppInsets.sm),
          // Text(
          //   '${followerFormat(creator.numberOfSubscribers ?? 0)} Followers',
          //   overflow: TextOverflow.ellipsis,
          //   style: bodyStyle,
          // ),
        ],
      ),
    );
  }

  Future<void> onFollow(BuildContext context) async {

    if (isFollowing) {
      return;
    }

    final loginStatus = await manageLoginPopup(context);
    if (loginStatus==false) {
      return;
    }

    overlayEntry = buildLoaderOverlay();
    Overlay.of(context)?.insert(overlayEntry!);

    final response = await context
        .read(featuredConnectionStateProvider('').notifier)
        .followCreator(creator.id, context);

    response.fold(
      (failure) {
        overlayEntry?.remove();
        Fluttertoast.showToast(msg: failure.message.toString());
      },
      (request) {
        overlayEntry?.remove();
        isFollowing = !isFollowing;
      },
    );
  }
}

String followerFormat(int num) {
  if (num > 999 && num < 99999) {
    return "${(num / 1000).toStringAsFixed(1)}K";
  } else if (num > 99999 && num < 999999) {
    return "${(num / 1000).toStringAsFixed(0)}K";
  } else if (num > 999999 && num < 999999999) {
    return "${(num / 1000000).toStringAsFixed(1)}M";
  } else if (num > 999999999) {
    return "${(num / 1000000000).toStringAsFixed(1)}B";
  } else {
    return num.toString();
  }
}
