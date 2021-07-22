import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/theme.dart';
import '../../../../core/widgets/success_popup/success_popup.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../utils/app_localizations.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../points/presentation/bloc/points_bloc.dart';
import '../../domain/entity/package_entity.dart';
import '../bloc/rewards_bloc.dart';
import '../widgets/discount_slider.dart';
import '../widgets/quantity_picker.dart';
import '../widgets/redeem_button.dart';

class PackagePurchaseScreen extends StatefulWidget {
  final Package package;

  const PackagePurchaseScreen({
    Key? key,
    required this.package,
  }) : super(key: key);

  @override
  _PackagePurchaseScreenState createState() => _PackagePurchaseScreenState();
}

class _PackagePurchaseScreenState extends State<PackagePurchaseScreen> {
  late StreamSubscription<RewardsState> _subscription;
  late RewardsBloc _bloc;
  late int _quantity;
  late double _maxDiscount;
  late int _discount;
  late double _maxPoints;
  late double _amount;

  @override
  void initState() {
    BlocProvider.of<PointsBloc>(context).add(const GetUserPointsStarted());
    _quantity = 1;
    _maxDiscount = (widget.package.maxDiscount! * _quantity).toDouble();
    _maxPoints = (widget.package.maxDiscountPoints! * _quantity).toDouble();
    _discount = 0;
    _amount = _getAmount();
    _bloc = BlocProvider.of<RewardsBloc>(context);
    _subscription = _bloc.stream.listen(_rewardsBlocListener);
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _rewardsBlocListener(RewardsState state) {
    if (state is RewardsPostPackageRequestLoaded) {
      final successText =
          AppLocalizations.of(context)?.translate('rewards:succes_text');
      final successDesc =
          AppLocalizations.of(context)?.translate('rewards:success_desc');
      final buttonText = AppLocalizations.of(context)?.translate("got_it");
      Navigator.of(context)
          .push(
            SuccessPopup(
                title: successText!,
                message: successDesc!,
                buttonTitle: buttonText!,
                iconAsset: AppImageAssets.packageSuccess,
                onButtonClicked: () {
                  Navigator.of(context).pop(true);
                }),
          )
          .then((value) => AutoRouter.of(context).popUntilRoot());
    }
  }

  double _getAmount() {
    return (widget.package.maxPrice! * _quantity -
            _discount * widget.package.pointsConversion!)
        .toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final purchaseLabel =
        AppLocalizations.of(context)?.translate("rewards:purchase");
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: BaseAppBar(
          appBarActionColor: Colors.white,
        ),
        body: BlocConsumer<PointsBloc, PointsState>(
          listener: (context, state) {},
          builder: (context, state) {
            final header = AppLocalizations.of(context)
                ?.translate("rewards:purchase_header_label");
            final headerStyle = Theme.of(context).textTheme.subtitle2?.copyWith(
                  color: Colors.white,
                );
            final pointsStyle = Theme.of(context).textTheme.headline5?.copyWith(
                  color: Colors.white,
                );
            return Column(
              children: [
                Container(
                  height: 160,
                  color: Colors.grey[900],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          header!,
                          style: headerStyle,
                        ),
                        const SizedBox(height: AppInsets.med),
                        Text(
                          state.points.toString(),
                          style: pointsStyle,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.white,
                    child: Column(
                      children: [
                        _buildHeader(context),
                        _buildPriceView(context),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppInsets.med),
                          child: DiscountSlider(
                            maxUserPoints: state.points,
                            value: _discount.toDouble(),
                            maxDiscount: _maxDiscount,
                            maxPoints: _maxPoints,
                            onChanged: (value) {
                              setState(() {
                                _discount = value.toInt();
                                _amount = _getAmount();
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: AppPadding.l),
                        RedeemButton(
                          buttonTheme: ButtonThemeData(
                            buttonColor: Colors.grey[900],
                            splashColor: Colors.grey[100],
                            highlightColor: Colors.grey[100],
                            focusColor: Colors.grey[100],
                            textTheme: ButtonTextTheme.primary,
                          ),
                          onPressed: () {
                            final user =
                                BlocProvider.of<AuthBloc>(context).state.user;
                            _bloc.add(
                              RewardsPostPackageRequestStarted(
                                quantity: _quantity,
                                pointsApplied: _discount,
                                package: widget.package.pk!,
                                requestedBy: user!.pk!,
                              ),
                            );
                          },
                          child: Text(purchaseLabel!),
                        ),
                        const SizedBox(height: AppPadding.l),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final providerNameStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
          color: Colors.grey[800],
        );
    final packageNameStyle = Theme.of(context).textTheme.headline6?.copyWith(
          fontSize: 17,
          color: Colors.grey[800],
        );
    final priceStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
          fontSize: 14,
          color: Colors.grey[600],
        );
    final currency = NumberFormat.currency(
      symbol: '₹',
      decimalDigits: 0,
      locale: 'en-in',
    );
    final maxPrice = currency.format(widget.package.maxPrice);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppInsets.xl,
        vertical: AppInsets.xxl,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.package.provider!.name!,
                  style: providerNameStyle,
                ),
                const SizedBox(height: AppInsets.sm),
                Text(
                  widget.package.title!,
                  style: packageNameStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppInsets.med),
                Text(
                  maxPrice,
                  style: priceStyle,
                ),
              ],
            ),
          ),
          QuantityPicker(
            value: _quantity,
            onChange: (value) {
              setState(() {
                _quantity = value;
                _amount = _getAmount();
              });
            },
          )
        ],
      ),
    );
  }

  Widget _buildPriceView(BuildContext context) {
    final currency = NumberFormat.currency(
      symbol: '₹',
      decimalDigits: 0,
      locale: 'en-in',
    );

    final priceDisplay = currency.format(_amount);
    final amountLabel =
        AppLocalizations.of(context)?.translate("rewards:amount_label");
    final priceStyle = Theme.of(context).textTheme.headline6?.copyWith(
          fontSize: 24,
        );
    final labelStyle = Theme.of(context).textTheme.subtitle2?.copyWith(
          color: Colors.grey[400],
        );

    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            priceDisplay,
            style: priceStyle,
          ),
          const SizedBox(height: AppInsets.med),
          Text(
            amountLabel!,
            style: labelStyle,
          ),
        ],
      ),
    );
  }
}
