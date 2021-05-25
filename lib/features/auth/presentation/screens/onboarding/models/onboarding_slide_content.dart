import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OnboardingSlideContent extends Equatable {
  final String heading;
  final String subHeading;
  final AssetImage image;

  const OnboardingSlideContent({
    @required this.heading,
    @required this.subHeading,
    @required this.image,
  });

  @override
  List<Object> get props => [
        heading,
        subHeading,
        image,
      ];
}
