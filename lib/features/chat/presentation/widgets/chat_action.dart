import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/analytics/anlytics_events.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/core/widgets/base/base_network_image/base_network_image.dart';
import 'package:worknetwork/features/chat/data/models/chat_message_model.dart';
import 'package:worknetwork/features/chat/presentation/widgets/timer_progress_bar.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/creator_list_state.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/utils/navigation_helpers/navigate_post_auth.dart';

class ChatAction extends HookConsumerWidget {
  final ChatMessage message;
  final Creator creator;
  final bool isFollowing;

  late WidgetRef ref;

  ChatAction({
    required this.message,
    required this.creator,
    required this.isFollowing,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;

    final isComplete = useState(false);

    Widget widget = Container();
    Color bgColor = Colors.purple;

    if (message.action != 1 && message.action != 3) {
      return Container();
    }

    Future<void> followHost(BuildContext context) async {
      final userPK = creator.id;

      final response = await ref
          .read(creatorStateProvider('').notifier)
          .followCreator(userPK, context);

      response.fold(
        (failure) {
          // isFollowing.value = !isFollowing.value;
          // message.isFollowing = isFollowing.value;
          // Fluttertoast.showToast(msg: failure.message.toString());
        },
        (request) {
          // isFollowing.value = !isFollowing.value;
          // message.isFollowing = isFollowing.value;
          isComplete.value = true;
          final analytics = ref.read(analyticsProvider);
          analytics.trackEvent(
            eventName: AnalyticsEvents.followCreator,
            properties: {},
          );

          // Fluttertoast.showToast(msg: '');
        },
      );
    }

    Future<void> exploreStreams(BuildContext context) async {
      await manageRSVPPopup(context, '', slide: 2);
      isComplete.value = true;
    }

    Future<void> performAction(BuildContext context) async {
      switch (message.action) {
        case 1:
          await followHost(context);
          break;
        case 2:
          // await inviteFriends(context);
          break;
        case 3:
          await exploreStreams(context);
          break;
      }
    }

    if (message.action == 3) {
      final title = message.stream?.topicDetail?.description ??
          message.message ??
          'Join the stream';

      final startDateFormat = DateFormat('dd MMMM yyyy hh:mm a');
      final time = message.stream?.start?.toLocal() ?? DateTime.now();
      final date = startDateFormat.format(time);
      bgColor = HexColor.fromHex("#134D34");

      widget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SIMILAR STREAM',
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 4),
          Container(
            color: Colors.white,
            width: 65,
            height: 1,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SvgPicture.asset(
                AppSvgAssets.cableTV,
                width: 18,
              ),
              const SizedBox(width: 8),
              Text(
                date,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          const SizedBox(height: 20),
          BaseLargeButton(
            style: BaseLargeButtonStyle.secondary,
            text: 'Remind Me',
            icon: Icons.notifications_outlined,
            onPressed: () => performAction(context),
          ),
        ],
      );
    }

    if (message.action == 1) {
      final headingStyle = Theme.of(context).textTheme.subtitle2;
      final bodyStyle = Theme.of(context).textTheme.caption;

      final title = message.message ?? '';
      bgColor = HexColor.fromHex("#5F1DAB");
      widget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BaseNetworkImage(
                  imageUrl: creator.profileDetail?.photo,
                  defaultImage: AppImageAssets.defaultAvatar,
                  imagebuilder: (context, imageProvider) => CircleAvatar(
                    backgroundImage: imageProvider,
                    radius: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(creator.profileDetail?.name ?? '',
                          style: headingStyle),
                      Text(
                        '21 Streams',
                        overflow: TextOverflow.ellipsis,
                        style: bodyStyle,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 20),
          BaseLargeButton(
            style: BaseLargeButtonStyle.secondary,
            text: 'Follow',
            onPressed: () => performAction(context),
          )
        ],
      );
    }

    return isComplete.value
        ? Container()
        : Column(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 16,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/images/chat_action_bg.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: widget,
                      ),
                      Positioned(
                        bottom: 0,
                        child: TimerProgressBar(
                          onComplete: () {
                            return isComplete.value = true;
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
            ],
          );
  }
}
