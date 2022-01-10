import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants/theme.dart';
import '../../domain/entity/meeting_config_entity.dart';
import '../../domain/entity/meeting_interest_entity.dart';
import '../../domain/entity/meeting_objective_entity.dart';
import '../../domain/entity/time_slot_entity.dart';
import '../../domain/entity/user_meeting_preference_entity.dart';

class MeetingPreferencesCard extends StatelessWidget {
  final UserMeetingPreference preference;
  final List<MeetingObjective> objectives;
  final List<MeetingInterest> interests;
  final MeetingConfig meetingConfig;
  final VoidCallback onTapCard;

  const MeetingPreferencesCard({
    Key? key,
    required this.preference,
    required this.objectives,
    required this.interests,
    required this.meetingConfig,
    required this.onTapCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headinStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: 17,
        );
    final subheadStyle = Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(fontSize: 14, color: Colors.grey[500]);
    final startDate = DateTime.parse(meetingConfig.weekStartDate ?? '');
    final dateFormat = DateFormat("d MMMM");
    final subhead =
        "Update your preferences for the week of ${dateFormat.format(startDate)}.";
    return Card(
      child: InkWell(
        onTap: onTapCard,
        highlightColor: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppInsets.xxl, horizontal: AppInsets.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Meeting Preferences", style: headinStyle),
              const SizedBox(height: AppInsets.sm),
              Text(subhead, style: subheadStyle),
              const SizedBox(height: AppInsets.xl),
              const Divider(height: AppInsets.xl),
              const SizedBox(height: AppInsets.xl),
              _PreferenceItemDisplay(
                label: "Number of Meetings",
                child: Text(preference.numberOfMeetings.toString()),
              ),
              _PreferenceItemDisplay(
                label: "Available times?",
                child: Wrap(
                  children: _getSelectedTimeSlots().map(
                    (slot) {
                      const placeholderDate = "2020-01-01";
                      final timeFormatter = DateFormat("hh:mm a");
                      final startTime =
                          DateTime.parse("$placeholderDate ${slot.start}");
                      final endTime =
                          DateTime.parse("$placeholderDate ${slot.end}");
                      final label =
                          "${timeFormatter.format(startTime)} to ${timeFormatter.format(endTime)}";
                      return Container(
                        margin: const EdgeInsets.only(
                          right: AppInsets.med,
                          top: AppInsets.sm,
                          bottom: AppInsets.sm,
                        ),
                        child: Chip(
                          backgroundColor: Theme.of(context).primaryColor,
                          label: Text(label),
                          labelStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              _PreferenceItemDisplay(
                label: "Your Objective",
                child: Text(_getSelectedObjective().name ?? ''),
              ),
              _PreferenceItemDisplay(
                label: "Your Preferences",
                child: Wrap(
                  children: _getSelectedInterests().map((interest) {
                    return Container(
                      margin: const EdgeInsets.only(
                        right: AppInsets.med,
                        top: AppInsets.sm,
                        bottom: AppInsets.sm,
                      ),
                      child: Chip(
                        backgroundColor: Theme.of(context).primaryColor,
                        label: Text(interest.name ?? ''),
                        labelStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<TimeSlot> _getSelectedTimeSlots() {
    return meetingConfig.availableTimeSlots?.entries.fold(
          [],
          (previousValue, element) {
            for (final timeSlot in element.value) {
              if (preference.timeSlots?.contains(timeSlot.pk) ?? false) {
                previousValue?.add(timeSlot);
              }
            }
            return previousValue;
          },
        ) ??
        [];
  }

  MeetingObjective _getSelectedObjective() {
    return const MeetingObjective(
        icon: '', name: '', pk: 0, type: ObjectiveType.lookingFor);
  }

  List<MeetingInterest> _getSelectedInterests() {
    return interests.fold([], (previousValue, element) {
      if (preference.interests?.contains(element) ?? false) {
        previousValue.add(element);
      }
      return previousValue;
    });
  }
}

class _PreferenceItemDisplay extends StatelessWidget {
  final String? label;
  final Widget child;

  const _PreferenceItemDisplay({
    Key? key,
    required this.label,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyText1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: labelStyle,
          ),
        const SizedBox(height: AppInsets.med),
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          constraints: const BoxConstraints(minHeight: 44),
          padding: const EdgeInsets.symmetric(horizontal: AppInsets.l),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(AppBorderRadius.textInput),
          ),
          child: child,
        ),
        const SizedBox(height: AppInsets.l)
      ],
    );
  }
}
