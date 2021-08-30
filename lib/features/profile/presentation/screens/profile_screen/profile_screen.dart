import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/features/websocket/presentation/bloc/websocket_bloc.dart';
import 'package:worknetwork/core/local_storage/local_storage.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';

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
    @PathParam('allowEdit') required this.allowEdit,
  });

  Size _textSize(String text, TextStyle style, BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 100,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 200, maxWidth: maxWidth - 100);
    return textPainter.size;
  }

  Widget _appBar(BuildContext context, Profile profile) {
    final size = _textSize(profile.introduction ?? '',
        Theme.of(context).textTheme.bodyText1!, context);

    return SliverAppBar(
      expandedHeight: size.height + 350,
      flexibleSpace: FlexibleSpaceBar(background: _ProfileBody(profile)),
      pinned: true,
      elevation: 0.5,
      shadowColor: Colors.grey,
      forceElevated: true,
      actions: [
        if (allowEdit)
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: BaseContainer(
              radius: 30,
              child: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => AutoRouter.of(context)
                      .push(ProfileBasicScreenRoute(editMode: true))),
            ),
          ),
        const SizedBox(
          width: 20,
        )
      ],
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: const TabBar(
            tabs: [
              Tab(text: 'Snapshot'),
              Tab(text: 'Interests'),
              Tab(text: 'Connections'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileState = useProvider(getProfileNotifierProvider(userId));

    return profileState.when(
      data: (state) => Scaffold(
        body: DefaultTabController(
            length: 3,
            child: SafeArea(
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  _appBar(context, state.profile),
                ],
                body: TabBarView(children: [
                  _SnapShot(
                    profile: state.profile,
                    objectives: state.objectives,
                    meta: state.meta,
                    showLogout: allowEdit,
                  ),
                  _Interests(state.interests),
                  _UserConnections(state.connections!),
                ]),
              ),
            )),
      ),
      loading: () => Scaffold(
        appBar: BaseAppBar(),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: const [
                LinearProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
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
                      radius: AppInsets.l,
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
                                        profile.generatedIntroduction!,
                                      ),
                                    if (profile.introduction != null)
                                      Text(
                                        profile.introduction!,
                                      )
                                  ]),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Spacer(),
                                if (profile.linkedIn != null)
                                  _buildLinkedInButton()
                                else
                                  const SizedBox(height: 50),
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
                      profile.name!,
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
    final photo = profile.photo;
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
            KiwiContainer().resolve<CustomTabs>().openLink(profile.linkedIn!),
        child: SvgPicture.asset(
          AppSvgAssets.linkedinFilled,
          height: 30.0,
        ),
      ),
    );
  }
}

class _ConnectionProfile extends HookWidget {
  final String? photoUrl;
  final double size;

  const _ConnectionProfile({
    this.photoUrl,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    if (photoUrl != null) {
      return CachedNetworkImage(
        imageUrl: photoUrl!,
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
  final Profile? profile;
  final List<MeetingObjective> objectives;
  final Map<String, String>? meta;
  final bool showLogout;

  const _SnapShot({
    this.profile,
    required this.objectives,
    this.meta,
    required this.showLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppInsets.l),
          if (meta?.isNotEmpty ?? false)
            Column(
                children: meta!.entries
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text(e.key),
                              ),
                              Text(
                                e.value,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ))
                    .toList()),
          _Objectives(objectives),
          const Spacer(),
          if (showLogout)
            Center(
              child: BaseLargeButton(
                text: 'Logout',
                onPressed: () => _handleLogout(context),
              ),
            )
        ],
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    BlocProvider.of<WebsocketBloc>(context).add(const WebSocketCloseStarted());
    await KiwiContainer().resolve<Analytics>().reset();
    await KiwiContainer().resolve<LocalStorage>().deleteStorage();
    await KiwiContainer().resolve<LocalStorage>().initStorage();
    AutoRouter.of(context).pushAndPopUntil(const WelcomeScreenRoute(),
        predicate: (route) => false);
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
        ?.copyWith(fontWeight: FontWeight.bold);
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
                text: objective.name ?? '',
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
                  text: interest.name ?? '',
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
    final itemWidth = MediaQuery.of(context).size.width / itemsInRow - 18;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 20,
        children: connections
            .map((user) => SizedBox(
                  width: itemWidth,
                  child: InkWell(
                    onTap: () => AutoRouter.of(context).push(ProfileScreenRoute(
                        userId: user.uuid!, allowEdit: false)),
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
                            user.name!,
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
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
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
  final double? width;

  const _ChipItem({Key? key, required this.text, this.width}) : super(key: key);

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
