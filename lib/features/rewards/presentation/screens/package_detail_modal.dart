import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';

import '../../../../constants/theme.dart';
import '../../../../routes.gr.dart';
import '../../../../utils/app_localizations.dart';
import '../../domain/entity/package_entity.dart';
import '../widgets/redeem_button.dart';

class PackageDetailModal extends ModalRoute<void> {
  final Package package;

  PackageDetailModal({
    @required this.package,
  });

  @override
  Color get barrierColor => Colors.black.withOpacity(0.4);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    final tween = Tween(begin: begin, end: end);
    final offsetAnimation = animation.drive(tween);
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: offsetAnimation,
        child: child,
      ),
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return SafeArea(
      child: NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          final _navigator = ExtendedNavigator.of(context);
          if (notification.extent <= 0.25 && _navigator.canPop()) {
            _navigator.popUntilPath(Routes.packageDetailScreen);
            return true;
          }
          return false;
        },
        child: _PackageDetailView(
          package: package,
        ),
      ),
    );
  }
}

class _PackageDetailView extends StatelessWidget {
  final Package package;

  const _PackageDetailView({
    Key key,
    @required this.package,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkoutButtonText =
        AppLocalizations.of(context).translate("rewards:checkout_button");
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildSheet(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 96,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0.4),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Center(
              child: RedeemButton(
                buttonTheme: ButtonThemeData(
                  buttonColor: Colors.grey[900],
                  splashColor: Colors.grey[100],
                  highlightColor: Colors.grey[100],
                  focusColor: Colors.grey[100],
                  textTheme: ButtonTextTheme.primary,
                ),
                onPressed: () {
                  ExtendedNavigator.of(context).popAndPush(
                    Routes.packagePurchaseScreen,
                    arguments: PackagePurchaseScreenArguments(package: package),
                  );
                },
                child: Text(checkoutButtonText),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSheet() => DraggableScrollableSheet(
        initialChildSize: 0.7,
        builder: (context, scrollController) {
          final primaryColor = Theme.of(context).primaryColor;
          return Material(
            color: Colors.white,
            child: CustomScrollView(
              controller: scrollController,
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _ModalAppBar(
                    package: package,
                    onPressedClose: () {
                      ExtendedNavigator.of(context).pop();
                    },
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Html(
                        data: package.longDesc,
                        style: {
                          'html': Style(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppInsets.xl),
                          ),
                          'div': Style(
                            color: Colors.grey[600],
                          ),
                          'p': Style(
                            margin: const EdgeInsets.all(0),
                            padding: const EdgeInsets.symmetric(
                              vertical: AppInsets.med,
                            ),
                          ),
                          'p.label': Style(
                            fontSize: FontSize.large,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[700],
                          ),
                          'p.body': Style(
                            fontSize: const FontSize(15),
                          ),
                          'li': Style(
                            fontSize: const FontSize(15),
                          ),
                        },
                        customRender: {
                          'li': (
                            RenderContext context,
                            Widget parsedChild,
                            Map<String, String> attributes,
                            dom.Element element,
                          ) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(bottom: AppInsets.sm),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 5,
                                    width: 5,
                                    margin: const EdgeInsets.only(
                                      top: 7,
                                      right: AppInsets.med,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Flexible(
                                    child: parsedChild,
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 96)
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
}

class _ModalAppBar extends SliverPersistentHeaderDelegate {
  final Package package;
  final VoidCallback onPressedClose;

  _ModalAppBar({
    @required this.onPressedClose,
    @required this.package,
  });

  @override
  double get minExtent => 136;

  @override
  double get maxExtent => 136;

  @override
  bool shouldRebuild(_ModalAppBar oldDelegate) {
    return false;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: Material(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  onPressed: onPressedClose,
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey[600],
                  ),
                )
              ],
            ),
            _buildPackageInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageInfo(BuildContext context) {
    final providerNameStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 14,
          color: Colors.grey[500],
        );
    final packageNameStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 17,
          color: Colors.grey[700],
        );
    final currency = NumberFormat.currency(
      symbol: '₹',
      decimalDigits: 0,
      locale: 'en-in',
    );
    final discountedPrice =
        currency.format(package.maxPrice - package.maxDiscount);
    final maxPrice = currency.format(package.maxPrice);
    final priceStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 14,
        );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppInsets.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            package.provider.name,
            style: providerNameStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppInsets.sm),
          Text(
            package.title,
            style: packageNameStyle,
          ),
          const SizedBox(height: AppInsets.med),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$discountedPrice   ',
                  style: priceStyle,
                ),
                TextSpan(
                  text: maxPrice,
                  style: priceStyle.copyWith(
                    color: Colors.grey[500],
                    decoration: TextDecoration.lineThrough,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: AppInsets.xl),
          const Divider()
        ],
      ),
    );
  }
}
