import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';

enum AuthProvider { google, facebook, linkedin }

class SocialAuthButton extends StatelessWidget {
  final AuthProvider provider;
  final VoidCallback onPressed;

  const SocialAuthButton({Key key, @required this.provider, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _child;
    Color _buttonColor;

    if (provider == AuthProvider.google) {
      _child = SvgPicture.asset(
        AppSvgAssets.googleColored,
        height: 24,
      );
      _buttonColor = Colors.white70;
    }

    if (provider == AuthProvider.linkedin) {
      _child = SvgPicture.asset(
        AppSvgAssets.linkedinFilled,
        height: 24,
      );

      _buttonColor = AppTheme.linkedInColor;
    }

    if (provider == AuthProvider.facebook) {
      _child = SvgPicture.asset(
        AppSvgAssets.facebook,
        color: Colors.white,
        height: 24,
      );

      _buttonColor = AppTheme.facebookColor;
    }

    return RaisedButton(
        color: _buttonColor,
        padding: const EdgeInsets.symmetric(
          vertical: AppInsets.l,
          horizontal: AppInsets.xl,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: onPressed,
        child: _child);
  }
}
