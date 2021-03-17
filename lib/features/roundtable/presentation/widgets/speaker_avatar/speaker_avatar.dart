import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/core/widgets/base/base_network_image/base_network_image.dart';

import '../../../domain/entity/rtc_user_entity/rtc_user_entity.dart';

const kItemWidth = 76.00;

class SpeakerAvatar extends HookWidget {
  final RtcUser user;
  final bool isLive;

  const SpeakerAvatar({
    Key key,
    @required this.user,
    @required this.isLive,
  }) : super(key: key);

  Future<void> _hideVoiceIndicator(
      AnimationController controller, ValueNotifier<bool> visible) async {
    try {
      await controller.reverse().orCancel;
      visible.value = false;
    } catch (error) {
      // print(error);
    }
  }

  Future<void> _showVoiceIndicator(
      AnimationController controller, ValueNotifier<bool> visible) async {
    try {
      visible.value = true;
      await controller.forward().orCancel;
    } catch (error) {
      // print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ticker = useSingleTickerProvider();
    final _animationController = useAnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: ticker,
    );
    final opacity = isLive
        ? user.online
            ? 1.0
            : 0.4
        : 1.0;
    final showVoiceActivity = useState(false);
    useEffect(() {
      if (user.online) {
        if (user.volume < 15) {
          _hideVoiceIndicator(_animationController, showVoiceActivity);
        } else {
          _showVoiceIndicator(_animationController, showVoiceActivity);
        }
      } else {
        showVoiceActivity.value = false;
      }
      return;
    }, [user]);
    return Opacity(
      opacity: opacity,
      child: Column(
        children: [
          SizedBox(
            width: kItemWidth,
            height: kItemWidth,
            child: Stack(
              fit: StackFit.expand,
              overflow: Overflow.visible,
              children: [
                if (showVoiceActivity.value)
                  Align(
                    child: _AnimatedAudioInteraction(
                        controller: _animationController),
                  ),
                Align(
                  child: BaseNetworkImage(
                    imageUrl: user.userInfo.photo,
                    defaultImage: AppImageAssets.defaultAvatar,
                    imagebuilder: (context, imageProvider) => CircleAvatar(
                      radius: 30,
                      backgroundImage: imageProvider,
                    ),
                  ),
                ),
                if (isLive && user.online)
                  Positioned(
                    top: 44,
                    right: 0,
                    child: _MicrophoneIcon(micEnabled: !user.muted),
                  ),
              ],
            ),
          ),
          SizedBox(
            width: kItemWidth,
            child: Text(
              user.userInfo.name,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedAudioInteraction extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> opacity;
  final Animation<double> size;

  _AnimatedAudioInteraction({
    this.controller,
  })  : opacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: const Interval(0.0, 0.250, curve: Curves.easeIn),
        )),
        size = Tween<double>(begin: 64.00, end: 72.00).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.250, 1.00, curve: Curves.bounceInOut),
          ),
        );

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: opacity.value,
          child: Container(
            width: size.value,
            height: size.value,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: primaryColor, width: 3.0),
            ),
          ),
        );
      },
    );
  }
}

class _MicrophoneIcon extends StatelessWidget {
  final bool micEnabled;

  const _MicrophoneIcon({
    Key key,
    this.micEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = micEnabled ? Colors.green : Colors.red;
    final icon = micEnabled ? Icons.mic : Icons.mic_off;
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.white,
          size: 14.0,
        ),
      ),
    );
  }
}
