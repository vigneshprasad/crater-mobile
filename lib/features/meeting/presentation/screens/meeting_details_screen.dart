import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/features/meeting/presentation/screens/dyte_meeting_screen.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/theme.dart';
import '../../../../core/config_reader/config_reader.dart';
import '../../../../core/custom_tabs/custom_tabs.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/widgets/base/base_bottom_sheet_route/base_bottom_sheet_route.dart';
import '../../../../core/widgets/base/base_large_icon_button/base_large_icon_button.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../utils/app_localizations.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../data/models/meeting_model.dart';
import '../../data/models/meeting_rsvp_model.dart';
import '../../domain/entity/meeting_entity.dart';
import '../../domain/entity/meeting_participant_entity.dart';
import '../bloc/meeting_bloc.dart';
import '../widgets/reschedule_request_sheet.dart';

class MeetingDetailScreen extends StatefulWidget {
  final int meetingId;

  const MeetingDetailScreen({
    Key? key,
    required this.meetingId,
  }) : super(key: key);

  @override
  _MeetingDetailScreenState createState() => _MeetingDetailScreenState();
}

class _MeetingDetailScreenState extends State<MeetingDetailScreen> {
  late MeetingBloc _bloc;
  Meeting? meeting;
  late bool loading;
  late MeetingParticipant? participant;
  late bool loadingInfo;

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
    final userRsvp = meeting != null
        ? meeting!.participants
            ?.where((element) => element != participant)
            .first
        : null;
    return BlocListener<MeetingBloc, MeetingState>(
      listener: _blocListener,
      child: Scaffold(
        appBar: BaseAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (loading || loadingInfo) const LinearProgressIndicator(),
              if (userRsvp != null) _buildStatusHeader(userRsvp.rsvp?.status),
              if (!loadingInfo) _buildContent(context)
            ],
          ),
        ),
      ),
    );
  }

  void _blocListener(BuildContext context, MeetingState state) {
    final user = BlocProvider.of<AuthBloc>(context).state.user;
    if (state is RetrieveMeetingLoaded) {
      final _participant = state.meeting?.participants
          ?.where((element) => element.pk != user?.pk)
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
    } else if (state is PostMeetingRecheduleRsvpError) {
      final failure = state.error as ServerFailure?;
      final json = jsonDecode(failure?.message as String? ?? '');
      if (json['non_field_errors'] != null) {
        Fluttertoast.showToast(
          msg: "Meeting cannot be resheduled. Please contact support for help.",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Theme.of(context).errorColor,
        );
      }
      Navigator.pop(context);
    }
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppInsets.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: AppInsets.l),
          const Divider(),
          if (meeting?.status != MeetingStatus.cancelled ||
              (meeting?.isPast ?? false))
            ..._buildMeetingInfo(context),
          if (meeting?.status == MeetingStatus.cancelled &&
              !(meeting?.isPast ?? false))
            _buildCancelledMeetingReschedule(context),
          const Divider(),
          const SizedBox(height: AppInsets.l),
          if (participant?.name != null && participant?.introduction != null)
            ..._buildIntro(context),
          ..._buildObjectives(context),
          ..._buildInterests(context),
          const SizedBox(height: AppInsets.xl),
        ],
      ),
    );
  }

  Widget _buildStatusHeader(MeetingRsvpStatus? userRsvpStatus) {
    if (userRsvpStatus == MeetingRsvpStatus.reschedule) {
      final textStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
            color: Colors.white,
          );
      return Container(
        padding: const EdgeInsets.symmetric(vertical: AppInsets.med),
        color: Colors.orange,
        child: Center(
          child: Text(
            'You have requested a reschedule.',
            style: textStyle,
          ),
        ),
      );
    } else if (userRsvpStatus == MeetingRsvpStatus.attending) {
      final textStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
            color: Colors.white,
          );
      return Container(
        padding: const EdgeInsets.symmetric(vertical: AppInsets.med),
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Text(
            'You are attending this meeting',
            style: textStyle,
          ),
        ),
      );
    }
    return Container();
  }

  List<Widget> _buildMeetingInfo(BuildContext context) {
    final user = BlocProvider.of<AuthBloc>(context).state.user;
    List<Widget> buttons = [];
    final dateFormat = DateFormat('hh:mm a, EEEE, d MMMM.');
    String? meetingLabel;
    if (meeting?.status == MeetingStatus.rescheduled) {
      meetingLabel = AppLocalizations.of(context)
          ?.translate("meeting_details:reschedule_request_label");
    } else {
      meetingLabel = meeting?.isPast ?? false
          ? 'Your meeting was scheduled at ${dateFormat.format(meeting!.start!)}'
          : 'Your meeting is scheduled at ${dateFormat.format(meeting!.start!)}';
    }

    final labelStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: 15,
        );
    final userRsvp =
        meeting?.participants?.where((element) => element != participant).first;
    if (meeting?.isPast ?? false) {
      final feedbackText = AppLocalizations.of(context)
          ?.translate("meeting_detail:share_feedback");
      buttons = [
        OutlinedButton(
          onPressed: () {
            final link = ConfigReader.getMeetingFeedbackTypeformLink();
            final feedbackLink =
                "$link#meeting_id=${meeting!.pk}&email=${user!.email}";
            KiwiContainer().resolve<CustomTabs>().openLink(feedbackLink);
          },
          child: Text(feedbackText!),
        ),
      ];
    } else if (meeting?.status == MeetingStatus.pending) {
      if (userRsvp?.rsvp?.status == MeetingRsvpStatus.pending) {
        buttons = [
          BaseLargeIconButton(
            icon: Icons.check,
            text: "Confirm",
            onPressed: () {
              _postMeetingStatusRequest(MeetingRsvpStatus.attending);
            },
          ),
          const VerticalDivider(
            endIndent: AppInsets.xl,
            indent: AppInsets.xl,
          ),
          BaseLargeIconButton(
            icon: Icons.clear,
            text: "Cancel",
            onPressed: () {
              _onPressCancelMeeting(context);
            },
          ),
          const VerticalDivider(
            endIndent: AppInsets.xl,
            indent: AppInsets.xl,
          ),
          BaseLargeIconButton(
            icon: Icons.restore,
            text: "Reschedule",
            onPressed: () {
              _onPressReschedule(context);
            },
          ),
        ];
      } else if (userRsvp?.rsvp?.status == MeetingRsvpStatus.attending) {
        buttons = [
          BaseLargeIconButton(
            icon: Icons.duo,
            text: "Join call",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      DyteMeetingScreen(meetingId: widget.meetingId)));
              return;
              if (meeting?.link != null) {
                KiwiContainer().resolve<CustomTabs>().openLink(meeting!.link!);
              }
            },
          ),
          const VerticalDivider(
            endIndent: AppInsets.xl,
            indent: AppInsets.xl,
          ),
          BaseLargeIconButton(
            icon: Icons.clear,
            text: "Cancel",
            onPressed: () {
              _onPressCancelMeeting(context);
            },
          ),
          const VerticalDivider(
            endIndent: AppInsets.xl,
            indent: AppInsets.xl,
          ),
          BaseLargeIconButton(
            icon: Icons.restore,
            text: "Reschedule",
            onPressed: () {
              _onPressReschedule(context);
            },
          ),
        ];
      }
    } else if (meeting?.status == MeetingStatus.confirmed) {
      buttons = [
        BaseLargeIconButton(
          icon: Icons.duo,
          text: "Join call",
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    DyteMeetingScreen(meetingId: widget.meetingId)));
            return;
            if (meeting?.link != null) {
              KiwiContainer().resolve<CustomTabs>().openLink(meeting!.link!);
            }
          },
        ),
        const VerticalDivider(
          endIndent: AppInsets.xl,
          indent: AppInsets.xl,
        ),
        BaseLargeIconButton(
          icon: Icons.clear,
          text: "Cancel",
          onPressed: () {
            _onPressCancelMeeting(context);
          },
        ),
        const VerticalDivider(
          endIndent: AppInsets.xl,
          indent: AppInsets.xl,
        ),
        BaseLargeIconButton(
          icon: Icons.restore,
          text: "Reschedule",
          onPressed: () {
            _onPressReschedule(context);
          },
        ),
      ];
    } else if (meeting?.status == MeetingStatus.rescheduled) {
      final otherUser =
          meeting?.participants?.where((element) => element != userRsvp).first;
      if (otherUser?.rsvp?.status == MeetingRsvpStatus.reschedule) {
        buttons = [
          // BaseLargeIconButton(
          //   icon: Icons.calendar_today,
          //   text: "Pick a slot",
          //   onPressed: () {
          //     showModalBottomSheet(
          //       context: context,
          //       builder: (context) {
          //         return RescheduleConfirmSheet(
          //           meeting: meeting!,
          //         );
          //       },
          //     ).then((value) {
          //       if (value != null && value == true) {
          //         AutoRouter.of(context).pop();
          //       }
          //     });
          //   },
          // ),
          // const SizedBox(width: AppInsets.med),
          // const VerticalDivider(
          //   endIndent: AppInsets.xl,
          //   indent: AppInsets.xl,
          // ),
          // const SizedBox(width: AppInsets.med),
          BaseLargeIconButton(
            icon: Icons.clear,
            text: "Cancel",
            onPressed: () {
              _onPressCancelMeeting(context);
            },
          )
        ];
      }
    }

    /// Remove actions if user has rescheduled meeting.
    if (userRsvp?.rsvp?.status == MeetingRsvpStatus.reschedule) {
      return [];
    }
    return [
      const SizedBox(height: AppInsets.l),
      Text(
        meetingLabel!,
        style: labelStyle,
      ),
      const SizedBox(height: AppInsets.l),
      SizedBox(
        height: 78,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...buttons,
          ],
        ),
      ),
      const SizedBox(height: AppInsets.l),
    ];
  }

  Widget _buildCancelledMeetingReschedule(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppInsets.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)
                    ?.translate("meeting_details:reschedule_question") ??
                '',
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () {
              _onPressReschedule(context);
            },
            child: Text(AppLocalizations.of(context)
                    ?.translate("meeting_details:reschedule") ??
                ''),
          ),
        ],
      ),
    );
  }

  void _postMeetingStatusRequest(MeetingRsvpStatus status) {
    _bloc.add(
        PostMeetingRsvpStatusStarted(meetingId: meeting!.pk!, status: status));
    setState(() {
      loading = true;
    });
  }

  Widget _buildHeader(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
          fontSize: 14,
        );
    final label = (meeting?.isPast ?? false)
        ? AppLocalizations.of(context)
            ?.translate("meeting_detail:past_name_label")
        : AppLocalizations.of(context)
            ?.translate('meeting_detail:upcoming_name_label');
    final nameStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
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
                label!,
                style: labelStyle,
              ),
              const SizedBox(height: AppInsets.sm),
              Text(
                participant?.name ?? '',
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

  void _onPressReschedule(BuildContext context) {
    Navigator.push(
      context,
      BaseBottomSheetRoute(
        initialHeightRatio: 0.6,
        maxScrollRatio: 0.6,
        child: RescheduleRequestSheet(
          meeting: meeting!,
        ),
      ),
    ).then((value) {
      _bloc.add(RetrieveMeetingDetailStarted(meetingId: widget.meetingId));
      setState(() {
        loadingInfo = true;
      });
    });
  }

  void _onPressCancelMeeting(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(AppLocalizations.of(context)
                  ?.translate("meetings_details:cancel_alert_title") ??
              ''),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                AppLocalizations.of(context)
                        ?.translate("alert:dismiss")
                        ?.toUpperCase() ??
                    '',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                _postMeetingStatusRequest(MeetingRsvpStatus.notAttending);
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)
                      ?.translate("meeting:cancel_meeting")
                      ?.toUpperCase() ??
                  ''),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatusIndicator(BuildContext context) {
    String text = '';
    var style = Theme.of(context).textTheme.bodyText2?.copyWith(
          fontSize: 14,
        );
    switch (meeting?.status) {
      case MeetingStatus.confirmed:
        text = 'Meeting Confirmed';
        style = style?.copyWith(
          color: Colors.green,
        );
        break;
      case MeetingStatus.cancelled:
        text = 'Meeting Cancelled';
        style = style?.copyWith(
          color: Colors.red,
        );
        break;
      case MeetingStatus.pending:
        text = 'RSVP Pending';
        style = style?.copyWith(
          color: Colors.yellow[600],
        );
        break;
      case MeetingStatus.rescheduled:
        text = 'Reschedule Requested';
        style = style?.copyWith(
          color: Colors.orange,
        );
        break;

      case null:
        text = '';
    }
    return Text(
      text,
      style: style,
    );
  }

  Widget _buildImage() {
    if (participant?.photo != null) {
      return CachedNetworkImage(
        imageUrl: participant!.photo!,
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
    final introLabel = 'About ${participant?.name}';
    final labelStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: 16,
        );
    final introStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
          fontSize: 14,
          height: 1.4,
        );
    return [
      Text(
        introLabel,
        style: labelStyle,
      ),
      const SizedBox(height: AppInsets.med),
      Text(
        participant?.introduction ?? '',
        style: introStyle,
      ),
    ];
  }

  List<Widget> _buildObjectives(BuildContext context) {
    const introLabel = "Objectives";
    final labelStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: 16,
        );
    if (participant?.objectives?.isEmpty ?? true) {
      return [];
    }

    return [
      const SizedBox(height: AppInsets.xxl),
      Text(
        introLabel,
        style: labelStyle,
      ),
      const SizedBox(height: AppInsets.med),
      ...participant!.objectives!
          .map((objective) => _ListItem(
                text: objective.name ?? '',
              ))
          .toList(),
    ];
  }

  List<Widget> _buildInterests(BuildContext context) {
    const introLabel = "Looking to meet:";
    final labelStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: 16,
        );
    if (participant?.interests?.isEmpty ?? true) {
      return [];
    }

    return [
      const SizedBox(height: AppInsets.xxl),
      Text(
        introLabel,
        style: labelStyle,
      ),
      const SizedBox(height: AppInsets.med),
      ...participant!.interests!
          .map((interest) => _ListItem(
                text: interest.name ?? '',
              ))
          .toList(),
    ];
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
