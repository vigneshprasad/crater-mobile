import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/theme.dart';
import '../../../features/social_auth/domain/usecase/get_social_auth_token.dart';

enum AuthProvider { google, facebook, linkedin }

class SocialAuthButton extends StatelessWidget {
  final SocialAuthProviders provider;
  final bool isLarge;
  final VoidCallback onPressed;

  const SocialAuthButton(
      {Key key, @required this.provider, this.onPressed, this.isLarge = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _child;
    Color _buttonColor;
    Color _textColor = Colors.white;
    const _iconSize = 20.0;

    if (provider == SocialAuthProviders.google) {
      _child = SvgPicture.asset(
        AppSvgAssets.googleColored,
        height: _iconSize,
      );
      _textColor = Colors.white;
      _buttonColor = Colors.white;
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
        color: Colors.black,
        height: _iconSize,
      );
      _buttonColor = Colors.white;
      _textColor = Colors.black;
    }

    if (isLarge) {
      final name = _nameForProvider(provider);

      _child = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        child: Row(children: [
          _child,
          const SizedBox(width: 8),
          const Spacer(),
          Text(
            'Sign up with $name',
            style: TextStyle(color: _textColor, fontSize: 17),
          ),
          const Spacer()
        ]),
      );
    }

    return RawMaterialButton(
      constraints: BoxConstraints(
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

  String _nameForProvider(SocialAuthProviders provider) {
    switch (provider) {
      case SocialAuthProviders.linkedin:
        return "LinkedIn";
        break;
      case SocialAuthProviders.apple:
        return "Apple";
        break;
      case SocialAuthProviders.facebook:
        return "Facebook";
        break;
      case SocialAuthProviders.google:
        return "Google";
        break;
      default:
        return "";
    }
  }
}
