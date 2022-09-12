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
    final headingStyle = Theme.of(context).textTheme.headline6;
    final subHeadingStyle = Theme.of(context).textTheme.bodyText2;
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: headingStyle,
          ),
          const SizedBox(height: 12),
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
