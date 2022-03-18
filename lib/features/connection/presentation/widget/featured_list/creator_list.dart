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
        data: (creators) => GridView.builder(
            controller: _controller,
            itemCount: creators.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 40),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio:  1.6,
            ),
            itemBuilder: (context, index) => CreatorFollowCard(
              creator: creators[index],
              authUserPk: user?.pk,
              isFollowing: creators[index].isFollower ?? false,
            )
      ),)
    );
  }
}

class CreatorFollowCard extends HookWidget {

  late OverlayEntry? overlayEntry;

  final Creator creator;
  final int? authUserPk;

  bool isFollowing;

  CreatorFollowCard({
    Key? key,
    required this.creator,
    this.authUserPk,
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
          const SizedBox(height: AppInsets.xl,),
            SizedBox(
              width: 100,
              height: 30,
              child: isFollowing ? Text('Following', style: Theme.of(context).textTheme.caption,) : BaseLargeButton(
                    text: 'Follow',
                    onPressed: () => onFollow(context),
              ),
            ),
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
