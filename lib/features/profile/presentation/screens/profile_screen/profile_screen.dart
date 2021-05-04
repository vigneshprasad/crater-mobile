import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/features/profile/data/services/profile_api_services/profile_api_service.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../constants/work_net_icons_icons.dart';
import '../../../../../core/custom_tabs/custom_tabs.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/base/base_app_bar/base_app_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    final profileState = useProvider(getProfileNotifierProvider(userId).state);

    const fabHeroTag = Object();
    return Scaffold(
        appBar: BaseAppBar(),
        extendBodyBehindAppBar: true,
        body: profileState.when(
          data: (state) => Scaffold(
              floatingActionButton: allowEdit != null && allowEdit
                  ? FloatingActionButton(
                      heroTag: fabHeroTag,
                      onPressed: () => ExtendedNavigator.of(context)
                          .push(Routes.profileIntroScreen(editMode: true)),
                      child: const Icon(WorkNetIcons.newpost),
                    )
                  : FloatingActionButton(
                      heroTag: fabHeroTag,
                      onPressed: () => ExtendedNavigator.of(context).push(
                        Routes.chatScreen,
                        arguments: ChatScreenArguments(recieverId: userId),
                      ),
                      child: const Icon(WorkNetIcons.message),
                    ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
                child: SafeArea(
                  child: Column(
                    children: [
                      _ProfileBody(state.profile),
                      if (state.interests != null && state.objectives != null)
                        _MeetingPreferenceInfo(
                            state.interests, state.objectives),
                      _UserConnections(state.connections),
                    ],
                  ),
                ),
              )),
          loading: () => Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const LinearProgressIndicator(),
                ],
              ),
            ),
          ),
          error: (error, stackTrace) => Container(color: Colors.red),
        ));
  }
}

class _ProfileBody extends HookWidget {
  final Profile profile;

  const _ProfileBody(this.profile);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildImage(),
        ),
        Text(
          profile.name,
          style: Theme.of(context).textTheme.headline6,
        ),
        if (profile.tag.isNotEmpty)
          Text(
            profile.tag[0].name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        if (profile.linkedIn != null) _buildLinkedInButton(),
        if (profile.introduction != null)
          SizedBox(
            width: double.infinity,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'About me:',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              if (profile.generatedIntroduction != null)
                Text(
                  profile.generatedIntroduction,
                ),
              Text(
                profile.introduction,
              )
            ]),
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
          image: const DecorationImage(image: AppImageAssets.defaultAvatar),
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
          image: const DecorationImage(image: AppImageAssets.defaultAvatar),
        ),
      );
    }
  }
}

class _MeetingPreferenceInfo extends HookWidget {
  final List<MeetingInterest> interests;
  final List<MeetingObjective> objectives;

  const _MeetingPreferenceInfo(this.interests, this.objectives);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._buildObjectives(context),
        ..._buildInterests(context),
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

  List<Widget> _buildInterests(BuildContext context) {
    const introLabel = "Looking to meet:";
    final labelStyle = Theme.of(context)
        .textTheme
        .subtitle1
        .copyWith(fontWeight: FontWeight.bold);
    if (interests.isEmpty) {
      return [];
    }

    return [
      const SizedBox(height: AppInsets.xxl),
      Text(
        introLabel,
        style: labelStyle,
      ),
      const SizedBox(
        height: AppInsets.med,
        width: double.infinity,
      ),
      Wrap(
        spacing: 12,
        children: interests
            .map((interest) => _ChipItem(
                  text: interest.name,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._buildConnections(context),
      ],
    );
  }

  List<Widget> _buildConnections(BuildContext context) {
    const introLabel = "Connections:";
    final labelStyle = Theme.of(context)
        .textTheme
        .subtitle1
        .copyWith(fontWeight: FontWeight.bold);
    if (connections.isEmpty) {
      return [];
    }

    const showMaxConnections = 5;
    final width =
        MediaQuery.of(context).size.width / showMaxConnections - AppInsets.xxl;

    return [
      const SizedBox(height: AppInsets.xxl),
      Text(
        introLabel,
        style: labelStyle,
      ),
      const SizedBox(
        height: AppInsets.med,
        width: double.infinity,
      ),
      Wrap(
        spacing: 12,
        children: connections
            .take(showMaxConnections)
            .map((user) => InkWell(
                  onTap: () => ExtendedNavigator.of(context).push(
                      Routes.profileScreen(userId: user.pk, allowEdit: false)),
                  child: SizedBox(
                    width: width,
                    child: Column(
                      children: [
                        _ConnectionProfile(
                          photoUrl: user.photo,
                          size: width,
                        ),
                        Text(
                          user.name,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ))
            .toList(),
      )
    ];
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

  const _ChipItem({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1;
    return Chip(
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide()),
        label: Text(
          text,
          style: textStyle,
        ));
  }
}
