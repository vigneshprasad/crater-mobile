import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/theme.dart';
import '../../../../utils/app_localizations.dart';
import '../../domain/entity/package_entity.dart';
import '../widgets/redeem_button.dart';

class PackageRequestSuccess extends ModalRoute<void> {
  final Package package;

  PackageRequestSuccess({@required this.package});

  @override
  Color get barrierColor => Colors.black.withOpacity(0.8);

  @override
  bool get barrierDismissible => false;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final successDesc =
        AppLocalizations.of(context).translate('rewards:success_desc');
    final successText =
        AppLocalizations.of(context).translate('rewards:succes_text');
    final successStyle = Theme.of(context).textTheme.subtitle2.copyWith(
          fontSize: 18,
        );
    final buttonText = AppLocalizations.of(context).translate("got_it");
    final descStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 15,
          color: Colors.grey[600],
        );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 96,
                        backgroundImage: AppImageAssets.packageSuccess,
                      ),
                      const SizedBox(height: AppInsets.l),
                      Text(
                        successText,
                        textAlign: TextAlign.center,
                        style: successStyle,
                      ),
                      const SizedBox(height: AppInsets.med),
                      Text(
                        successDesc,
                        textAlign: TextAlign.center,
                        style: descStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppInsets.xl),
                  child: RedeemButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(buttonText),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
