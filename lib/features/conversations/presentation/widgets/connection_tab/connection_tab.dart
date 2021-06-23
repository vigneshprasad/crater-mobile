import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/widgets/base/base_network_image/base_network_image.dart';
import 'package:worknetwork/features/auth/domain/entity/user_tag_entity.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/connection_tab/connection_tab_state.dart';
import 'package:worknetwork/features/profile/domain/entity/profile_entity/profile_entity.dart';

import '../../../../../routes.gr.dart';

class ConnectionTab extends HookWidget {
  UserTag allTag = UserTag(name: 'All');
  UserTag selectedTag;

  @override
  Widget build(BuildContext context) {
    final topicsState = useProvider(connectionStateProvider.state);
    final tagsState = useProvider(tagStateProvider.state);
    return RefreshIndicator(
      displacement: 96.00,
      onRefresh: () {
        final futures = [
          context
              .read(connectionStateProvider)
              .getProfileList(selectedTag?.pk?.toString() ?? ''),
          context.read(tagStateProvider).getTagList(),
        ];

        return Future.wait(futures);
      },
      child: Column(
        children: [
          tagsState.when(
            loading: () => Container(),
            error: (err, st) => Container(
              height: 200,
              width: 200,
              color: Colors.red,
            ),
            data: (tags) {
              selectedTag = selectedTag ?? allTag;
              tags = [allTag] + tags;
              return SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tags.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: FilterChip(
                        selected: selectedTag?.name == tags[index].name,
                        label: Text(tags[index].name),
                        onSelected: (value) {
                          selectedTag = tags[index];
                          context
                              .read(connectionStateProvider)
                              .getProfileList(selectedTag.pk?.toString() ?? '');
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
          topicsState.when(
            loading: () => const CircularProgressIndicator(),
            error: (err, st) => Container(
              height: 200,
              width: 200,
              color: Colors.red,
            ),
            data: (profiles) => Expanded(
              child: ListView.builder(
                itemCount: profiles.length,
                itemBuilder: (BuildContext context, int index) {
                  return _Connection(
                    user: profiles[index],
                    authUserPk: "1",
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Connection extends StatelessWidget {
  final Profile user;
  final String authUserPk;
  const _Connection({
    Key key,
    @required this.user,
    this.authUserPk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final description = user.introduction ?? user.generatedIntroduction ?? '';
    final headingStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 16,
        );
    final bodyStyle = Theme.of(context).textTheme.bodyText2;
    return InkWell(
      onTap: () => ExtendedNavigator.of(context).push(
        Routes.profileScreen(
            userId: user.uuid, allowEdit: authUserPk == user.pk),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            BaseNetworkImage(
              imageUrl: user.photo,
              defaultImage: AppImageAssets.defaultAvatar,
              imagebuilder: (context, imageProvider) => CircleAvatar(
                backgroundImage: imageProvider,
                radius: 36,
              ),
            ),
            const SizedBox(width: AppInsets.xl),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name, style: headingStyle),
                  const SizedBox(height: AppInsets.sm),
                  Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: bodyStyle,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
