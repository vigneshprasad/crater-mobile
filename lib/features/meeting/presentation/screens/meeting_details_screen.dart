import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/ui/base/base_icon_button/base_icon_button.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/theme.dart';
import '../../../../constants/work_net_icons_icons.dart';
import '../../../../core/custom_tabs/custom_tabs.dart';
import '../../../../core/widgets/base/base_large_icon_button/base_large_icon_button.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../utils/app_localizations.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../data/models/meeting_model.dart';
import '../../data/models/meeting_rsvp_model.dart';
import '../../domain/entity/meeting_entity.dart';
import '../../domain/entity/meeting_rsvp_entity.dart';
import '../bloc/meeting_bloc.dart';

class MeetingDetailScreen extends StatefulWidget {
  final int meetingId;

  const MeetingDetailScreen({
    Key key,
    @required this.meetingId,
  }) : super(key: key);

  @override
  _MeetingDetailScreenState createState() => _MeetingDetailScreenState();
}

class _MeetingDetailScreenState extends State<MeetingDetailScreen> {
  MeetingBloc _bloc;
  Meeting meeting;
  bool loading;
  MeetingRsvp participant;
  bool loadingInfo;

  @override
  void initState() {
    _bloc = BlocProvider.of<MeetingBloc>(context);
    _bloc.add(RetrieveMeetingDetailStarted(meetingId: widget.meetingId));
    loading = true;
    loadingInfo = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MeetingBloc, MeetingState>(
      listener: _blocListener,
      child: Scaffold(
        appBar: BaseAppBar(),
        body: Column(
          children: [
            if (loading || loadingInfo) const LinearProgressIndicator(),
            if (!loadingInfo) _buildContent(context)
          ],
        ),
        floatingActionButton: !loadingInfo
            ? FloatingActionButton(
                onPressed: () {
                  ExtendedNavigator.of(context).push(Routes.chatScreen,
                      arguments: ChatScreenArguments(
                          recieverId: participant.participant.pk));
                },
                child: const Icon(WorkNetIcons.message),
              )
            : null,
      ),
    );
  }

  void _blocListener(BuildContext context, MeetingState state) {
    final user = BlocProvider.of<AuthBloc>(context).state.user;
    if (state is RetrieveMeetingLoaded) {
      final _participant = state.meeting.rsvps
          .where((element) => element.participant.pk != user.pk)
          .first;
      setState(() {
        loadingInfo = false;
        loading = false;
        meeting = state.meeting;
        participant = _participant;
      });
    } else if (state is PostMeetingRsvpStatusLoaded) {
      setState(() {
        loadingInfo = true;
        _bloc.add(RetrieveMeetingDetailStarted(meetingId: widget.meetingId));
      });
    } else if (state is PostMeetingRsvpStatusError) {
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(msg: "Update Status failed");
    }
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppInsets.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: AppInsets.l),
            const Divider(),
            if (meeting.status != MeetingStatus.cancelled || meeting.isPast)
              ..._buildMeetingInfo(context),
            const Divider(),
            const SizedBox(height: AppInsets.l),
            ..._buildIntro(context),
            ..._buildObjectives(context),
            ..._buildInterests(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMeetingInfo(BuildContext context) {
    List<Widget> buttons = [];
    final dateFormat = DateFormat('hh:mm a, EEEE, d MMMM');
    final meetingLabel = meeting.isPast
        ? 'Your meeting was scheduled at ${dateFormat.format(meeting.start)}'
        : 'Your meeting is scheduled at ${dateFormat.format(meeting.start)}';
    final labelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 15,
        );
    if (meeting.isPast) {
      buttons = [
        OutlineButton(
          child: Text("Share Feedback"),
          onPressed: () {},
        ),
      ];
    } else if (meeting.status == MeetingStatus.pending) {
      final userRsvp =
          meeting.rsvps.where((element) => element != participant).first;
      if (userRsvp.status == MeetingRsvpStatus.pending) {
        buttons = [
          BaseLargeIconButton(
            icon: Icons.check,
            text: "Confirm",
            onPressed: () {
              _postMeetingStatusRequest(MeetingRsvpStatus.attending);
            },
          ),
          const SizedBox(width: AppInsets.med),
          const SizedBox(width: AppInsets.med),
          BaseLargeIconButton(
            icon: Icons.clear,
            text: "Cancel",
            onPressed: () {
              _postMeetingStatusRequest(MeetingRsvpStatus.notAttending);
            },
          )
        ];
      } else if (userRsvp.status == MeetingRsvpStatus.attending) {
        buttons = [
          BaseLargeIconButton(
            icon: Icons.videocam,
            text: "Join call",
            onPressed: () {
              KiwiContainer().resolve<CustomTabs>().openLink(meeting.link);
            },
          ),
          const SizedBox(width: AppInsets.med),
          const SizedBox(width: AppInsets.med),
          BaseLargeIconButton(
            icon: Icons.clear,
            text: "Cancel",
            onPressed: () {
              _postMeetingStatusRequest(MeetingRsvpStatus.notAttending);
            },
          )
        ];
      }
    } else if (meeting.status == MeetingStatus.confirmed) {
      buttons = [
        BaseLargeIconButton(
          icon: Icons.videocam,
          text: "Join call",
          onPressed: () {
            KiwiContainer().resolve<CustomTabs>().openLink(meeting.link);
          },
        ),
        const SizedBox(width: AppInsets.med),
        const SizedBox(width: AppInsets.med),
        BaseLargeIconButton(
          icon: Icons.clear,
          text: "Cancel",
          onPressed: () {
            _postMeetingStatusRequest(MeetingRsvpStatus.notAttending);
          },
        )
      ];
    }
    return [
      const SizedBox(height: AppInsets.l),
      Text(
        meetingLabel,
        style: labelStyle,
      ),
      const SizedBox(height: AppInsets.l),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...buttons,
        ],
      ),
      const SizedBox(height: AppInsets.l),
    ];
  }

  void _postMeetingStatusRequest(MeetingRsvpStatus status) {
    _bloc.add(
        PostMeetingRsvpStatusStarted(meetingId: meeting.pk, status: status));
    setState(() {
      loading = true;
    });
  }

  Widget _buildHeader(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 14,
          color: Colors.grey[600],
        );
    final label = meeting.isPast
        ? AppLocalizations.of(context)
            .translate("meeting_detail:past_name_label")
        : AppLocalizations.of(context)
            .translate('meeting_detail:upcoming_name_label');
    final nameStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 20,
        );
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppInsets.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: labelStyle,
              ),
              const SizedBox(height: AppInsets.sm),
              Text(
                participant.participant.name,
                style: nameStyle,
              ),
              const SizedBox(height: AppInsets.sm),
              _buildStatusIndicator(context),
            ],
          ),
        ),
        const Spacer(),
        _buildImage()
      ],
    );
  }

  Widget _buildStatusIndicator(BuildContext context) {
    String text;
    TextStyle style = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 14,
        );
    switch (meeting.status) {
      case MeetingStatus.confirmed:
        text = 'Meeting Confirmed';
        style = style.copyWith(
          color: Colors.green,
        );
        break;
      case MeetingStatus.cancelled:
        text = 'Meeting Cancelled';
        style = style.copyWith(
          color: Colors.red,
        );
        break;
      case MeetingStatus.pending:
        text = 'RSVP Pending';
        style = style.copyWith(
          color: Colors.yellow[600],
        );
        break;
      case MeetingStatus.rescheduled:
        text = 'Meeting rescheduled';
        style = style.copyWith(
          color: Colors.orange,
        );
        break;
    }
    return Text(
      text,
      style: style,
    );
  }

  Widget _buildImage() {
    if (participant.participant.photo != null) {
      return CachedNetworkImage(
        imageUrl: participant.participant.photo,
        imageBuilder: (context, imageProvider) {
          return Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(image: imageProvider),
            ),
          );
        },
      );
    } else {
      return Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: const DecorationImage(image: AppImageAssets.defaultAvatar),
        ),
      );
    }
  }

  List<Widget> _buildIntro(BuildContext context) {
    final introLabel = 'About ${participant.participant.name}';
    final labelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 16,
        );
    final introStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 14,
          height: 1.4,
          color: Colors.grey[700],
        );
    return [
      Text(
        introLabel,
        style: labelStyle,
      ),
      const SizedBox(height: AppInsets.med),
      Text(
        participant.participant.introduction,
        style: introStyle,
      ),
    ];
  }

  List<Widget> _buildObjectives(BuildContext context) {
    const introLabel = "Objectives";
    final labelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 16,
        );
    if (participant.objectives.isEmpty) {
      return [];
    }

    return [
      const SizedBox(height: AppInsets.xxl),
      Text(
        introLabel,
        style: labelStyle,
      ),
      const SizedBox(height: AppInsets.med),
      ...participant.objectives
          .map((objective) => _ListItem(
                text: objective.name,
              ))
          .toList(),
    ];
  }

  List<Widget> _buildInterests(BuildContext context) {
    const introLabel = "Looking to meet:";
    final labelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 16,
        );
    if (participant.interests.isEmpty) {
      return [];
    }

    return [
      const SizedBox(height: AppInsets.xxl),
      Text(
        introLabel,
        style: labelStyle,
      ),
      const SizedBox(height: AppInsets.med),
      ...participant.interests
          .map((interest) => _ListItem(
                text: interest.name,
              ))
          .toList(),
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
