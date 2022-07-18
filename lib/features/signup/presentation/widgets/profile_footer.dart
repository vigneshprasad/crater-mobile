import 'package:flutter/material.dart';

import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/utils/app_localizations.dart';

class ProfileFooter extends StatelessWidget {
  final VoidCallback? onSkip;
  final VoidCallback onSave;

  const ProfileFooter({
    Key? key,
    required this.onSave,
    this.onSkip,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final next = AppLocalizations.of(context)?.translate("next");
    return Container(
      color: Theme.of(context).dialogBackgroundColor,
      child: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
            child: Row(
              children: [
                if (onSkip != null)
                  SizedBox(
                    width: 130,
                    child: BaseLargeButton(
                      text: 'Skip for now',
                      onPressed: onSkip,
                      outlined: true,
                    ),
                  ),
                const Spacer(),
                SizedBox(
                  width: 130,
                  child: BaseLargeButton(
                    text: next,
                    onPressed: onSave,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
