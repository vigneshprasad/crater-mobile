import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worknetwork/constants/theme.dart';

enum AuthProvider { google, facebook, linkedin }

class SocialAuthButton extends StatelessWidget {
  final AuthProvider provider;
  final VoidCallback onPressed;

  const SocialAuthButton({Key key, @required this.provider, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (provider == AuthProvider.google) {
      child = SvgPicture.asset(
        'assets/svg/google.svg',
        width: 24,
      );
    }

    return RaisedButton(
        color: Colors.white70,
        padding: const EdgeInsets.all(AppInsets.xl),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: onPressed,
        child: child);
  }
}
