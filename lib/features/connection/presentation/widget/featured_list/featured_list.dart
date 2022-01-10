import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/widgets/base/base_network_image/base_network_image.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';

import '../../../../../routes.gr.dart';
import 'featured_list_state.dart';

class FeaturedList extends HookWidget {
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
      height: 220,
      child: connectionState.when(
        loading: () => Center(
            child: CircularProgressIndicator(
          color: Theme.of(context).accentColor,
        )),
        error: (err, st) => Center(
          child: err == null ? Container() : Text(err.toString()),
        ),
        data: (creators) => ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(width: 20),
          scrollDirection: Axis.horizontal,
          itemCount: creators.length,
          controller: _controller,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (BuildContext context, int index) {
            return CreatorCard(
              creator: creators[index],
              authUserPk: user?.pk, //TODO: pass auth user pk.
              showConnect: false,
            );
          },
        ),
      ),
    );
  }
}

class CreatorCard extends StatelessWidget {
  final Creator creator;
  final int? authUserPk;
  final bool showConnect;
  const CreatorCard({
    Key? key,
    required this.creator,
    this.authUserPk,
    required this.showConnect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.subtitle1;
    final bodyStyle = Theme.of(context).textTheme.caption;
    return InkWell(
      onTap: () => AutoRouter.of(context).push(
        ProfileScreenRoute(
            userId: creator.user,
            createrId: creator.id,
            allowEdit: authUserPk == creator.profileDetail?.pk),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 140,
                height: 180,
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
              Text(
                creator.profileDetail?.name ?? '',
                style: headingStyle,
                maxLines: 2,
              ),
              // const SizedBox(height: AppInsets.sm),
              // Text(
              //   '${followerFormat(creator.numberOfSubscribers ?? 0)} Followers',
              //   overflow: TextOverflow.ellipsis,
              //   style: bodyStyle,
              // ),
            ],
          ),
        ],
      ),
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
