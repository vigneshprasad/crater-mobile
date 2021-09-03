import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/features/meeting/data/repository/meeting_respository_impl.dart';
import 'package:worknetwork/features/meeting/presentation/widgets/meeting_request_confirm_sheet.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/theme.dart';
import '../../../../core/widgets/base/base_large_icon_button/base_large_icon_button.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../utils/app_localizations.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../data/models/meeting_interest_model.dart';
import '../../data/models/meeting_objective_model.dart';
import '../../data/models/meeting_participant_model.dart';
import '../../data/models/meeting_request_model.dart';
import '../../domain/entity/meeting_request_entity.dart';
import 'meeting_request_details_screen_state.dart';

class MeetingRequestDetailScreen extends HookWidget {
  final int meetingId;

  const MeetingRequestDetailScreen({
    Key? key,
    required this.meetingId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final requestState = useProvider(meetingRequestStateProvider(meetingId));

    return Scaffold(
      appBar: BaseAppBar(),
      body: requestState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(
          child: Text(err.toString()),
        ),
        data: (meetingRequest) {
          final user = BlocProvider.of<AuthBloc>(context).state.user;
          final isRequester = meetingRequest.requestedBy == user!.pk;
          return SingleChildScrollView(
            child: Column(
              children: [
                if (meetingRequest.status != null)
                  _buildStatusHeader(context, isRequester),
                _buildContent(context, meetingRequest)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, MeetingRequest meetingRequest) {
    final participant = meetingRequest.participantDetail;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppInsets.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, meetingRequest),
          const SizedBox(height: AppInsets.l),
          const Divider(),
          if (meetingRequest.status != MeetingRequestStatus.declined ||
              (meetingRequest.isPast ?? false))
            ..._buildMeetingInfo(context, meetingRequest),
          const Divider(),
          const SizedBox(height: AppInsets.l),
          ..._buildIntro(context, participant!),
          ..._buildObjectives(context, participant.objectives ?? []),
          ..._buildInterests(context, participant.interests ?? []),
          const SizedBox(height: AppInsets.xl),
        ],
      ),
    );
  }

  Widget _buildStatusHeader(BuildContext context, bool isRequester) {
    if (isRequester) {
      final textStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
            color: Colors.white,
          );
      return Container(
        padding: const EdgeInsets.symmetric(vertical: AppInsets.med),
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Text(
            'You have requested the meeting.',
            style: textStyle,
          ),
        ),
      );
    } else {
      final textStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
            color: Colors.white,
          );
      return Container(
        padding: const EdgeInsets.symmetric(vertical: AppInsets.med),
        color: Colors.orange,
        child: Center(
          child: Text(
            'You have the meeting request',
            style: textStyle,
          ),
        ),
      );
    }
  }

  List<Widget> _buildMeetingInfo(
      BuildContext context, MeetingRequest meetingRequest) {
    final user = BlocProvider.of<AuthBloc>(context).state.user;
    List<Widget> buttons = [];
    final dateFormat = DateFormat('• hh:mm a, EEEE, d MMMM\n');
    final timeSlots =
        meetingRequest.timeSlots?.map((e) => dateFormat.format(e)).join('');
    final meetingLabel = 'The meeting is requested at: \n$timeSlots';

    final labelStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: 15,
        );

    if (meetingRequest.status == MeetingRequestStatus.pendingApproval) {
      if (meetingRequest.requestedTo == user!.pk) {
        buttons = [
          BaseLargeIconButton(
            icon: Icons.check,
            text: "Accept",
            onPressed: () {
              _acceptMeetingRequest(context, meetingRequest);
            },
          ),
          const VerticalDivider(
            endIndent: AppInsets.xl,
            indent: AppInsets.xl,
          ),
          BaseLargeIconButton(
            icon: Icons.clear,
            text: "Decline",
            onPressed: () {
              _onPressCancelMeeting(context, meetingRequest);
            },
          ),
        ];
      }
    }

    return [
      const SizedBox(height: AppInsets.l),
      Text(
        meetingLabel,
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

  void _acceptMeetingRequest(
      BuildContext context, MeetingRequest meetingRequest) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return MeetingRequestConfirmSheet(
          meeting: meetingRequest,
        );
      },
    ).then((value) {
      if (value != null && value == true) {
        AutoRouter.of(context).pop();
      }
    });
  }

  OverlayEntry _buildLoaderOverlay() {
    return OverlayEntry(
      builder: (context) {
        return Container(
          color: Theme.of(context).backgroundColor.withOpacity(0.8),
          child: _Loader(),
        );
      },
    );
  }

  Future<void> _declineMeetingRequest(
      BuildContext context, MeetingRequest meeting) async {
    final overlay = _buildLoaderOverlay();
    Overlay.of(context)?.insert(overlay);

    final response = await context
        .read(meetingRepositoryProvider)
        .postDeclineMeetingRequest(meeting.id!);

    response.fold(
      (failure) {
        overlay.remove();
        Fluttertoast.showToast(msg: failure.toString());
      },
      (optin) async {
        overlay.remove();

        // final popupManager = context.read(popupManagerProvider);
        // await popupManager.showPopup(PopupType.conversationOptIn, context);

        Navigator.of(context).pop(true);
      },
    );
  }

  Widget _buildHeader(BuildContext context, MeetingRequest meetingRequest) {
    final labelStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
          fontSize: 14,
        );
    final label = (meetingRequest.isPast ?? false)
        ? AppLocalizations.of(context)
            ?.translate("meeting_detail:past_name_label")
        : AppLocalizations.of(context)
            ?.translate('meeting_detail:upcoming_name_label');
    final nameStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: 20,
        );

    final participant = meetingRequest.participantDetail;
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
              _buildStatusIndicator(context, meetingRequest),
            ],
          ),
        ),
        const Spacer(),
        _buildImage(participant?.photo)
      ],
    );
  }

  void _onPressCancelMeeting(
      BuildContext context, MeetingRequest meetingRequest) {
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
                _declineMeetingRequest(context, meetingRequest);
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

  Widget _buildStatusIndicator(
      BuildContext context, MeetingRequest meetingRequest) {
    String text = '';
    var style = Theme.of(context).textTheme.bodyText2?.copyWith(
          fontSize: 14,
        );
    switch (meetingRequest.status) {
      case MeetingRequestStatus.confirmed:
        text = 'Meeting Confirmed';
        style = style?.copyWith(
          color: Colors.green,
        );
        break;
      case MeetingRequestStatus.declined:
        text = 'Meeting Declined';
        style = style?.copyWith(
          color: Colors.red,
        );
        break;
      case MeetingRequestStatus.pendingApproval:
        text = 'Pending Approval';
        style = style?.copyWith(
          color: Colors.yellow[600],
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

  Widget _buildImage(String? photo) {
    if (photo != null) {
      return CachedNetworkImage(
        imageUrl: photo,
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

  List<Widget> _buildIntro(
      BuildContext context, MeetingParticipantModel participant) {
    final introLabel = 'About ${participant.name}';
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
        participant.introduction ?? '',
        style: introStyle,
      ),
    ];
  }

  List<Widget> _buildObjectives(
      BuildContext context, List<MeetingObjectiveModel> objectives) {
    const introLabel = "Objectives";
    final labelStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: 16,
        );
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

  List<Widget> _buildInterests(
      BuildContext context, List<MeetingInterestModel> interests) {
    const introLabel = "Looking to meet:";
    final labelStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: 16,
        );
    if (interests.isEmpty) {
      return [];
    }

    return [
      const SizedBox(height: AppInsets.xxl),
      Text(
        introLabel,
        style: labelStyle,
      ),
      const SizedBox(height: AppInsets.med),
      ...interests
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

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
