import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/meeting/domain/entity/meeting_interest_entity.dart';

class InterestList extends HookWidget {
  final List<MeetingInterest> interests;

  const InterestList(this.interests);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._buildInterests(context),
      ],
    );
  }

  List<Widget> _buildInterests(BuildContext context) {
    const introLabel = "Interests";
    final labelStyle = Theme.of(context).textTheme.subtitle1;
    if (interests.isEmpty) {
      return [];
    }

    final width = MediaQuery.of(context).size.width / 2 - 30;

    return [
      const SizedBox(height: AppInsets.xxl),
      Text(
        introLabel,
        style: labelStyle,
      ),
      const SizedBox(
        height: AppInsets.xxl,
        width: double.infinity,
      ),
      Wrap(
        spacing: 20,
        runSpacing: 20,
        // crossAxisCount: 2,
        // childAspectRatio: 4,
        // mainAxisSpacing: 20,
        // crossAxisSpacing: 20,
        // physics: const NeverScrollableScrollPhysics(),
        children: interests
            .map((interest) => _ChipItem(
                  text: interest.name ?? '',
                  width: width,
                ))
            .toList(),
      )
    ];
  }
}

class _ChipItem extends StatelessWidget {
  final String text;
  final double? width;

  const _ChipItem({Key? key, required this.text, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1;
    return Container(
        width: width,
        // height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              color: Colors.white,
            )),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
        ));
  }
}
