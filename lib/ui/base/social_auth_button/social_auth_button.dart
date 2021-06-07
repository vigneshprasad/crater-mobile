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
  final bool isSignUp;

  const SocialAuthButton(
      {Key key,
      @required this.provider,
      this.onPressed,
      this.isLarge = false,
      this.isSignUp = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _child;
    Color _buttonColor;
    Color _textColor = Colors.white;
    final _iconSize = isLarge ? 24.0 : 20.0;

    if (provider == SocialAuthProviders.google) {
      _child = SvgPicture.asset(
        AppSvgAssets.googleColored,
        height: _iconSize,
      );
      _buttonColor = Theme.of(context).backgroundColor;
    }

    if (provider == SocialAuthProviders.linkedin) {
      _child = SvgPicture.asset(
        AppSvgAssets.linkedinFilled,
        height: _iconSize,
      );

      _buttonColor = Theme.of(context).backgroundColor;
    }

    if (provider == SocialAuthProviders.facebook) {
      _child = SvgPicture.asset(
        AppSvgAssets.facebook,
        color: AppTheme.facebookColor,
        height: _iconSize,
      );

      _buttonColor = Theme.of(context).backgroundColor;
    }

    if (provider == SocialAuthProviders.apple) {
      _child = SvgPicture.asset(
        AppSvgAssets.apple,
        color: Colors.white,
        height: _iconSize,
      );
      _buttonColor = Theme.of(context).backgroundColor;
      _textColor = Colors.white;
    }

    if (provider == SocialAuthProviders.email) {
      _child = Icon(
        Icons.email,
        color: Colors.white,
        size: _iconSize,
      );
      _buttonColor = Theme.of(context).backgroundColor;
      _textColor = Colors.white;
    }

    if (isLarge) {
      final name = _nameForProvider(provider, isSignUp);
      _child = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        child: Align(
          alignment: Alignment.centerLeft,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _child,
            const SizedBox(height: 16),
            Text(
              name,
              style: TextStyle(color: _textColor, fontSize: 17),
            ),
            // const Spacer()
          ]),
        ),
      );
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

  String _nameForProvider(SocialAuthProviders provider, bool isSignUp) {
    switch (provider) {
      case SocialAuthProviders.linkedin:
        return "LinkedIn";
        break;
      case SocialAuthProviders.apple:
        return isSignUp ? "Sign up with Apple" : "Sign in with Apple";
        break;
      case SocialAuthProviders.facebook:
        return "Facebook";
        break;
      case SocialAuthProviders.google:
        return "Google";
        break;
      case SocialAuthProviders.email:
        return "Email";
        break;
      default:
        return "";
    }
  }
}
