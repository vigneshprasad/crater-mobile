import 'package:flutter/material.dart';
import 'package:worknetwork/constants/theme.dart';

class RegisterMeetingButton extends MaterialButton {
  const RegisterMeetingButton({
    Key key,
    @required VoidCallback onPressed,
  }) : super(
          key: key,
          onPressed: onPressed,
        );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final buttonTheme = Theme.of(context).buttonTheme;
    return Material(
      color: Theme.of(context).primaryColor,
      elevation: buttonTheme.getElevation(this),
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onPressed,
        splashColor: buttonTheme.getSplashColor(this),
        focusColor: buttonTheme.getFocusColor(this),
        highlightColor: buttonTheme.getHighlightColor(this),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: AppInsets.l,
            horizontal: AppInsets.xxl,
          ),
          child: Text(
            "Opt In for Next Week",
            style: theme.textTheme.button.copyWith(
              color: buttonTheme.getTextColor(this),
            ),
          ),
        ),
      ),
    );
  }
}
