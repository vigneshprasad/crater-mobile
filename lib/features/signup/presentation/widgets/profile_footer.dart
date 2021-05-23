import 'package:flutter/material.dart';
import '../../../../ui/base/base_large_button/base_large_button.dart';
import '../../../../utils/app_localizations.dart';

class ProfileFooter extends StatelessWidget {
  final VoidCallback onSkip;
  final VoidCallback onSave;

  const ProfileFooter({
    Key key,
    @required this.onSave,
    this.onSkip,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final next = AppLocalizations.of(context).translate("next");
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            if (onSkip != null)
              FlatButton(
                child: Text('skip for now'),
                onPressed: onSkip,
              ),
            const Spacer(),
            SizedBox(
              width: 120,
              child: BaseLargeButton(
                text: next,
                onPressed: onSave,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
