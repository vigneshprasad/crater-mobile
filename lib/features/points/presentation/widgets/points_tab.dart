import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/theme.dart';
import '../../../../constants/work_net_icons_icons.dart';
import '../../../../routes.gr.dart';
import '../../../../utils/app_localizations.dart';
import '../bloc/points_bloc.dart';

class PointsTab extends StatefulWidget {
  const PointsTab({
    Key key,
  }) : super(key: key);

  @override
  _PointsTabState createState() => _PointsTabState();
}

class _PointsTabState extends State<PointsTab> {
  PointsBloc _bloc;
  int points;
  double moneyValue;

  @override
  void initState() {
    points = 0;
    moneyValue = 0.0;
    _bloc = BlocProvider.of<PointsBloc>(context);
    _bloc.add(const GetUserPointsStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final descStyle = Theme.of(context).textTheme.bodyText2;
    final recognizer = TapGestureRecognizer()
      ..onTap = () {
        AutoRouter.of(context).push(Routes.pointsFaqScreen);
      };
    final pointsDescText =
        AppLocalizations.of(context).translate("rewards:tab_desc");
    return BlocListener<PointsBloc, PointsState>(
      listener: (context, state) {
        if (state is PointsValueUpdateRecieved) {
          setState(() {
            points = state.points;
            moneyValue = state.moneyValue;
          });
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                const SizedBox(height: AppInsets.l),
                _buildPointsRow(context),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppInsets.xl,
                    vertical: AppInsets.sm,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: descStyle,
                      children: [
                        TextSpan(
                          text: pointsDescText,
                        ),
                        TextSpan(
                          text: 'Learn More',
                          recognizer: recognizer,
                          style: descStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Flexible(
                  child: Opacity(
                    opacity: 0.3,
                    child: Image(
                      fit: BoxFit.contain,
                      image: AppImageAssets.rewardsTrophy,
                    ),
                  ),
                ),
                const SizedBox(height: 72),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPointsRow(BuildContext context) {
    final equalsStyle = Theme.of(context).textTheme.subtitle2.copyWith(
          fontSize: 16,
        );
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppInsets.xxl,
        vertical: AppInsets.l,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _PointsBadge(
            label: points.toString(),
          ),
          Container(
            height: 28,
            width: 28,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '=',
                style: equalsStyle,
              ),
            ),
          ),
          _MoneyBadge(
            label: moneyValue,
          )
        ],
      ),
    );
  }
}

class _PointsBadge extends StatelessWidget {
  final String label;

  const _PointsBadge({
    Key key,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.subtitle1.copyWith(
          fontSize: 18,
        );
    const badgeSize = 30.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: badgeSize,
          height: badgeSize,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            WorkNetIcons.starfill,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: AppInsets.med),
        Text(
          label,
          style: labelStyle,
        ),
      ],
    );
  }
}

class _MoneyBadge extends StatelessWidget {
  final double label;

  const _MoneyBadge({Key key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(
      symbol: '',
      decimalDigits: 0,
      locale: 'en-in',
    );
    final labelStyle = Theme.of(context).textTheme.subtitle1.copyWith(
          fontSize: 18,
        );
    final symbolStyle = Theme.of(context).textTheme.subtitle1.copyWith(
          color: Colors.yellow[900],
        );
    const badgeSize = 30.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: badgeSize,
          height: badgeSize,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.yellow[900], width: 2),
            color: Colors.yellow[600],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '₹',
              style: symbolStyle,
            ),
          ),
        ),
        const SizedBox(width: AppInsets.med),
        Text(
          currency.format(label),
          style: labelStyle,
        ),
      ],
    );
  }
}
