import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/theme.dart';
import '../../../features/social_auth/domain/usecase/get_social_auth_token.dart';

enum AuthProvider { google, facebook, linkedin }

class SocialAuthButton extends StatelessWidget {
  final SocialAuthProviders provider;
  final VoidCallback onPressed;

  const SocialAuthButton({Key key, @required this.provider, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _child;
    Color _buttonColor;
    const _iconSize = 20.0;

    if (provider == SocialAuthProviders.google) {
      _child = SvgPicture.asset(
        AppSvgAssets.googleColored,
        height: _iconSize,
      );
      _buttonColor = Colors.white70;
    }

    if (provider == SocialAuthProviders.linkedin) {
      _child = SvgPicture.asset(
        AppSvgAssets.linkedinFilled,
        height: _iconSize,
      );

      _buttonColor = AppTheme.linkedInColor;
    }

    if (provider == SocialAuthProviders.facebook) {
      _child = SvgPicture.asset(
        AppSvgAssets.facebook,
        color: Colors.white,
        height: _iconSize,
      );

      _buttonColor = AppTheme.facebookColor;
    }

    if (provider == SocialAuthProviders.apple) {
      _child = SvgPicture.asset(
        AppSvgAssets.apple,
        color: Colors.white,
        height: _iconSize,
      );
      _buttonColor = Colors.grey[900];
    }

    return RawMaterialButton(
      constraints: const BoxConstraints(
        minWidth: 72,
      ),
      fillColor: _buttonColor,
      padding: const EdgeInsets.symmetric(
        vertical: AppInsets.l,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: onPressed,
      child: _child,
    );
  }
}
