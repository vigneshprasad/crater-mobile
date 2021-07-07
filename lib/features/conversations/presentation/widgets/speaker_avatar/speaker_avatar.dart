import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../core/widgets/base/base_network_image/base_network_image.dart';
import '../../../domain/entity/rtc_user_entity/rtc_user_entity.dart';

class SpeakerAvatar extends HookWidget {
  final RtcUser user;
  final bool isLive;
  final double avtarSize;

  const SpeakerAvatar({
    Key key,
    @required this.user,
    @required this.isLive,
    this.avtarSize,
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

    return Column(
      children: [
        SizedBox(
          width: avtarSize,
          height: avtarSize,
          child: Stack(
            fit: StackFit.expand,
            overflow: Overflow.visible,
            children: [
              if (showVoiceActivity.value)
                _AnimatedAudioInteraction(controller: _animationController),
              Align(
                child: BaseNetworkImage(
                  imageUrl: user.userInfo.photo,
                  defaultImage: AppImageAssets.defaultAvatar,
                  imagebuilder: (context, imageProvider) => Container(
                    width: avtarSize,
                    height: avtarSize,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter: !isLive || !user.online
                              ? const ColorFilter.mode(
                                  Colors.grey,
                                  BlendMode.saturation,
                                )
                              : null),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              if (isLive && user.online)
                Positioned(
                  top: avtarSize - 20,
                  left: avtarSize - 20,
                  child: _MicrophoneIcon(micEnabled: !user.muted),
                ),
            ],
          ),
        ),
      ],
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
        size = Tween<double>(begin: 10.00, end: 20.00).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.250, 1.00, curve: Curves.bounceInOut),
          ),
        );
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Positioned(
        top: -size.value,
        left: -size.value,
        right: -size.value,
        bottom: -size.value,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Opacity(
              opacity: opacity.value,
              child: Container(
                // width: size.value,
                // height: size.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(0.3),
                ),
              ),
            );
          },
        ));
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
