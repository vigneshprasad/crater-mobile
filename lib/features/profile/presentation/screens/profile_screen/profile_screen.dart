import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/custom_tabs/custom_tabs.dart';
import '../../../../../core/widgets/base/base_container/base_container.dart';
import '../../../../../routes.gr.dart';
import '../../../../meeting/domain/entity/meeting_interest_entity.dart';
import '../../../../meeting/domain/entity/meeting_objective_entity.dart';
import '../../../domain/entity/profile_entity/profile_entity.dart';
import 'profile_screen_state.dart';

class ProfileScreen extends HookWidget {
  final String userId;
  final bool allowEdit;

  const ProfileScreen(
    @PathParam('userId') this.userId, {
    @PathParam('allowEdit') this.allowEdit,
  });

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 0,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 200, maxWidth: 300);
    return textPainter.size;
  }

  Widget _appBar(BuildContext context, Profile profile) {
    final size =
        _textSize(profile.introduction, Theme.of(context).textTheme.bodyText1);

    return SliverAppBar(
      expandedHeight: size.height,
      flexibleSpace: _ProfileBody(profile),
      pinned: true,
      actions: [
        if (allowEdit != null && allowEdit)
          BaseContainer(
            radius: 30,
            child: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => ExtendedNavigator.of(context)
                    .push(Routes.profileBasicScreen(editMode: true))),
          ),
      ],
      bottom: const TabBar(
        tabs: [
          Tab(text: 'Snapshot'),
          Tab(text: 'Inerests'),
          Tab(text: 'Connections'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileState = useProvider(getProfileNotifierProvider(userId).state);

    return profileState.when(
      data: (state) => Scaffold(
        body: DefaultTabController(
            length: 3,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                _appBar(context, state.profile),
              ],
              body: TabBarView(children: [
                _SnapShot(state.profile, state.objectives),
                _Interests(state.interests),
                _UserConnections(state.connections),
              ]),
            )),
      ),
      loading: () => SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: const [
              LinearProgressIndicator(),
            ],
          ),
        ),
      ),
      error: (error, stackTrace) => Container(color: Colors.red),
    );
  }
}

class _ProfileBody extends HookWidget {
  final Profile profile;

  const _ProfileBody(this.profile);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 80.0, left: 20, right: 20),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    BaseContainer(
                      disableAnimation: true,
                      radius: 20,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        // height: 150,
                        child: Column(
                          children: [
                            if (profile.introduction != null ||
                                profile.generatedIntroduction != null)
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (profile.generatedIntroduction != null)
                                      Text(
                                        profile.generatedIntroduction,
                                      ),
                                    Text(
                                      profile.introduction,
                                    )
                                  ]),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Spacer(),
                                if (profile.linkedIn != null)
                                  _buildLinkedInButton(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Center(
                        child: BaseContainer(
                      radius: 50,
                      child: _buildImage(),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      profile.name,
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    final String photo = profile.photo;
    if (photo != null) {
      return CachedNetworkImage(
        imageUrl: photo,
        imageBuilder: (context, imageProvider) {
          return Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          );
        },
      );
    } else {
      return Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          image: const DecorationImage(
              image: AppImageAssets.defaultAvatar, fit: BoxFit.cover),
        ),
      );
    }
  }

  Widget _buildLinkedInButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RawMaterialButton(
        constraints: const BoxConstraints(
          minWidth: 40,
        ),
        fillColor: AppTheme.linkedInColor,
        padding: const EdgeInsets.symmetric(
          vertical: AppInsets.sm,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () =>
            KiwiContainer().resolve<CustomTabs>().openLink(profile.linkedIn),
        child: SvgPicture.asset(
          AppSvgAssets.linkedinFilled,
          height: 30.0,
        ),
      ),
    );
  }
}

class _ConnectionProfile extends HookWidget {
  final String photoUrl;
  final double size;

  const _ConnectionProfile({
    this.photoUrl,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    if (photoUrl != null) {
      return CachedNetworkImage(
        imageUrl: photoUrl,
        width: size,
        height: size,
        imageBuilder: (context, imageProvider) {
          return Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          );
        },
      );
    } else {
      return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          image: const DecorationImage(
              image: AppImageAssets.defaultAvatar, fit: BoxFit.cover),
        ),
      );
    }
  }
}

class _SnapShot extends HookWidget {
  final Profile profile;
  final List<MeetingObjective> objectives;

  const _SnapShot(this.profile, this.objectives);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headline6,
          ),
          if (profile.tag.isNotEmpty)
            Text(
              profile.tag[0].name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          _Objectives(objectives)
        ],
      ),
    );
  }
}

class _Objectives extends HookWidget {
  final List<MeetingObjective> objectives;

  const _Objectives(this.objectives);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._buildObjectives(context),
      ],
    );
  }

  List<Widget> _buildObjectives(BuildContext context) {
    const introLabel = "Objectives";
    final labelStyle = Theme.of(context)
        .textTheme
        .subtitle1
        .copyWith(fontWeight: FontWeight.bold);
    if (objectives.isEmpty) {
      return [];
    }

    return [
      const SizedBox(height: AppInsets.xxl),
      Text(
        introLabel,
        style: labelStyle,
      ),
      const SizedBox(height: AppInsets.med),
      ...objectives
          .map((objective) => _ListItem(
                text: objective.name,
              ))
          .toList(),
    ];
  }
}

class _Interests extends HookWidget {
  final List<MeetingInterest> interests;

  const _Interests(this.interests);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildInterests(context),
        ],
      ),
    );
  }

  List<Widget> _buildInterests(BuildContext context) {
    const introLabel = "Interests";
    final labelStyle = Theme.of(context).textTheme.headline6;
    if (interests.isEmpty) {
      return [];
    }

    final width = MediaQuery.of(context).size.width / 2 - 30;

    return [
      const SizedBox(height: AppInsets.xxl),
      Text(
        introLabel,
        style: labelStyle,
      ),
      const SizedBox(
        height: AppInsets.xxl,
        width: double.infinity,
      ),
      Wrap(
        spacing: 20,
        runSpacing: 20,
        // crossAxisCount: 2,
        // childAspectRatio: 4,
        // mainAxisSpacing: 20,
        // crossAxisSpacing: 20,
        // physics: const NeverScrollableScrollPhysics(),
        children: interests
            .map((interest) => _ChipItem(
                  text: interest.name,
                  width: width,
                ))
            .toList(),
      )
    ];
  }
}

class _UserConnections extends HookWidget {
  final List<Profile> connections;

  const _UserConnections(this.connections);

  @override
  Widget build(BuildContext context) {
    if (connections.isEmpty) {
      return Container();
    }

    const itemsInRow = 4;
    final itemWidth = MediaQuery.of(context).size.width / itemsInRow - 10;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Wrap(
        children: connections
            .map((user) => SizedBox(
                  width: itemWidth,
                  child: InkWell(
                    onTap: () => ExtendedNavigator.of(context).push(
                        Routes.profileScreen(
                            userId: user.uuid, allowEdit: false)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          _ConnectionProfile(
                            photoUrl: user.photo,
                            size: 70,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            user.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 13),
                          )
                        ],
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final String text;

  const _ListItem({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 14,
          height: 1.4,
          color: Colors.grey[700],
        );
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppInsets.med),
        Text(
          text,
          style: textStyle,
        )
      ],
    );
  }
}

class _ChipItem extends StatelessWidget {
  final String text;
  final double width;

  const _ChipItem({Key key, @required this.text, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1;
    return Container(
        width: width,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              color: Colors.white,
            )),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
        ));
  }
}
