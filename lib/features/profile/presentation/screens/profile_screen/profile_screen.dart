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
import 'gradient_button.dart';
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
      expandedHeight: 240,
      flexibleSpace: FlexibleSpaceBar(
          background: _ProfileBody(
        profile: profile,
        showConnect: !allowEdit,
      )),
      pinned: true,
      floating: true,
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
        preferredSize: const Size(double.infinity, 30),
        child: SizedBox(
          height: 30,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                height: 30,
                color: Theme.of(context).scaffoldBackgroundColor,
                alignment: Alignment.bottomLeft,
                child: const TabBar(
                  tabs: [
                    Tab(text: 'About'),
                    Tab(text: 'Connections'),
                  ],
                ),
              ),
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
            length: 2,
            child: SafeArea(
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  _appBar(context, state.profile),
                ],
                body: TabBarView(children: [
                  _AboutTab(
                    profile: state.profile,
                    objectives: state.objectives,
                    interests: state.interests,
                    meta: state.meta,
                    showLogout: allowEdit,
                  ),
                  _ClubTab(state.connections!),
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
  final bool showConnect;

  const _ProfileBody({
    required this.profile,
    required this.showConnect,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        SizedBox(
          height: 150,
          child: Image.asset(
            'assets/images/img_drawer_image.png',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 50,
          left: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BaseContainer(
                radius: 40,
                child: _buildImage(profile, 40),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  profile.name!,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ],
          ),
        ),
        if (showConnect)
          Positioned(
              bottom: 64,
              right: 20,
              child: GradientButton(
                onPressed: () {},
                title: 'CONNECT',
              ))
      ],
    );
  }

  Widget _buildImage(Profile profile, double radius) {
    final photo = profile.photo;
    if (photo != null) {
      return CachedNetworkImage(
        imageUrl: photo,
        imageBuilder: (context, imageProvider) {
          return Container(
            height: radius * 2,
            width: radius * 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          );
        },
      );
    } else {
      return Container(
        height: radius * 2,
        width: radius * 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          image: const DecorationImage(
              image: AppImageAssets.defaultAvatar, fit: BoxFit.cover),
        ),
      );
    }
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

class _AboutTab extends HookWidget {
  final Profile profile;
  final List<MeetingObjective> objectives;
  final List<MeetingInterest> interests;
  final Map<String, String>? meta;
  final bool showLogout;

  const _AboutTab({
    required this.profile,
    required this.objectives,
    required this.interests,
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
          UnderlinedText('ABOUT'),
          const SizedBox(height: AppInsets.sm),
          if (profile.introduction != null ||
              profile.generatedIntroduction != null)
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (profile.generatedIntroduction != null)
                Text(
                  profile.generatedIntroduction!,
                ),
              if (profile.introduction != null)
                Text(
                  profile.introduction!,
                )
            ]),
          const SizedBox(height: AppInsets.xxl),
          if (meta?.isNotEmpty ?? false)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UnderlinedText('SNAPSHOT'),
                const SizedBox(height: AppInsets.l),
                Column(
                    children: meta!.entries
                        .map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      e.key,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  Text(
                                    e.value,
                                  ),
                                ],
                              ),
                            ))
                        .toList()),
              ],
            ),
          _Objectives(objectives),
          const SizedBox(height: AppInsets.xxl),
          _Interests(interests),
          const SizedBox(height: AppInsets.xxl),
          UnderlinedText('CONNECT'),
          const SizedBox(height: AppInsets.l),
          _buildLinkedInButton(),
          const SizedBox(height: AppInsets.xxl),
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

  Future<void> _handleLogout(BuildContext context) async {
    BlocProvider.of<WebsocketBloc>(context).add(const WebSocketCloseStarted());
    await KiwiContainer().resolve<Analytics>().reset();
    await KiwiContainer().resolve<LocalStorage>().deleteStorage();
    await KiwiContainer().resolve<LocalStorage>().initStorage();
    AutoRouter.of(context).pushAndPopUntil(const WelcomeScreenRoute(),
        predicate: (route) => false);
  }
}

class UnderlinedText extends StatelessWidget {
  final String text;
  const UnderlinedText(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        Container(
          width: 10,
          height: 2,
          color: Colors.white,
        )
      ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._buildInterests(context),
      ],
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

class _ClubTab extends HookWidget {
  final List<Profile> connections;

  const _ClubTab(this.connections);

  @override
  Widget build(BuildContext context) {
    if (connections.isEmpty) {
      return Container();
    }

    const itemsInRow = 4;
    final itemWidth = MediaQuery.of(context).size.width / itemsInRow - 18;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Ongoing Chats',
          //   style: Theme.of(context).textTheme.subtitle1,
          // ),
          // const SizedBox(height: AppInsets.xxl),
          // Row(
          //   children: [
          //     const SpeakersTable(
          //       speakers: [],
          //       chairSize: 36,
          //     ),
          //     // const SizedBox(width: AppInsets.xxl),
          //     MaterialButton(
          //       onPressed: () async {
          //         final value = await startConversation(context);
          //         if (value == null) {
          //           return;
          //         }
          //         // _tabController.animateTo(0);
          //         // _activeTopic.value = value;
          //       },
          //       child: BaseContainer(
          //         radius: 20,
          //         child: Container(
          //           width: 140,
          //           height: 100,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(20),
          //             color: Colors.black,
          //           ),
          //           child: const Icon(
          //             Icons.add,
          //             size: 40,
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          // const SizedBox(height: 80),
          Text(
            'Community Members',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(height: AppInsets.xxl),
          Wrap(
            spacing: 8,
            runSpacing: 20,
            children: connections
                .map((user) => SizedBox(
                      width: itemWidth,
                      child: InkWell(
                        onTap: () => AutoRouter.of(context).push(
                            ProfileScreenRoute(
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
        ],
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
        // height: 40,
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
