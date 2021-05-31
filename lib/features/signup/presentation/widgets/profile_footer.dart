import 'package:flutter/material.dart';
import 'package:worknetwork/core/widgets/base/base_container/base_container.dart';

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
    return BaseContainer(
      disableAnimation: true,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              if (onSkip != null)
                FlatButton(
                  onPressed: onSkip,
                  child: const Text('skip for now'),
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
      ),
    );
  }
}
