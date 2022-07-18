import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const ProfileHeader({
    Key? key,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.headline5?.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w500,
        );
    final subHeadingStyle = Theme.of(context).textTheme.headline6?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        );
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: headingStyle,
          ),
          const SizedBox(height: 20),
          if (subtitle != null)
            Text(
              subtitle!,
              style: subHeadingStyle,
            ),
        ],
      ),
    );
  }
}
