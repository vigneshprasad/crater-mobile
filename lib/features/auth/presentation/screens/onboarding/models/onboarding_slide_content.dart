import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum OnboardingSlideButtonType {
  next,
  start1on1Conversation,
  startGroupConversation,
  joinConversation,
  dismiss,
  invite,
  feedback,
}

class OnboardingSlideButton {
  final String title;
  final OnboardingSlideButtonType type;

  const OnboardingSlideButton({required this.title, required this.type});
}

const _defaultButtons = [
  OnboardingSlideButton(title: 'Next', type: OnboardingSlideButtonType.next)
];

class OnboardingSlideContent extends Equatable {
  final String heading;
  final String subHeading;
  final AssetImage image;
  final List<OnboardingSlideButton> buttons;

  const OnboardingSlideContent({
    required this.heading,
    required this.subHeading,
    required this.image,
    this.buttons = _defaultButtons,
  });

  @override
  List<Object> get props => [
        heading,
        subHeading,
        image,
      ];
}
