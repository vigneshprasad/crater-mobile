import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:worknetwork/core/integrations/intercom/intercom_provider.dart';

class HelpButton extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final intercom = context.read(intercomProvider);
    return IconButton(
      icon: const Icon(
        Icons.help,
        color: Colors.white,
      ),
      onPressed: () => intercom.show(context),
    );
  }
}
