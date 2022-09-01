import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';

enum GridItemType {
  title,
  live,
  upcoming,
  featured,
  past,
  loader,
  series,
}

class UpcomingGridItem extends Equatable {
  final Webinar? conversation;
  final String? title;
  final Icon? icon;
  final String? color;
  final GridItemType type;
  final bool? rsvped;

  const UpcomingGridItem({
    this.conversation,
    this.title,
    this.icon,
    this.color,
    required this.type,
    this.rsvped,
  });

  @override
  List<Object?> get props => [conversation?.id];
}
