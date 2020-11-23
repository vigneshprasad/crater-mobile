import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/theme.dart';
import '../../../../core/color/color.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../utils/app_localizations.dart';
import '../../domain/entity/package_entity.dart';
import '../bloc/rewards_bloc.dart';
import '../widgets/redeem_button.dart';
import 'package_detail_modal.dart';

class PackageDetailScreen extends StatefulWidget {
  final int packageId;

  const PackageDetailScreen({
    Key key,
    @required this.packageId,
  }) : super(key: key);

  @override
  _PackageDetailScreenState createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen> {
  Package package;
  RewardsBloc _bloc;
  bool isDark;

  @override
  void initState() {
    isDark = true;
    _bloc = BlocProvider.of<RewardsBloc>(context);
    _bloc.add(RewardsGetPackageStarted(packageId: widget.packageId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appActionBarColor = isDark ? Colors.white : Colors.grey[900];
    return BlocListener<RewardsBloc, RewardsState>(
      listener: (context, state) {
        if (state is RewardsGetPackageLoaded) {
          setState(() {
            package = state.package;
            isDark = state.package.isDark;
          });
        }
      },
      child: Theme(
        data: isDark ? AppTheme.darkTheme : Theme.of(context),
        child: Builder(
          builder: (context) {
            if (package == null) {
              return Container();
            }
            return Scaffold(
              appBar: BaseAppBar(
                appBarActionColor: appActionBarColor,
              ),
              backgroundColor: HexColor.fromHex(package.color),
              body: _buildContent(context),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.headline6;
    final descStyle = Theme.of(context).textTheme.bodyText2;
    final providerNameStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 16,
        );
    final redeemText = AppLocalizations.of(context).translate("rewards:redeem");

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CachedNetworkImage(
          imageUrl: package.coverImage,
          imageBuilder: (context, imageProvider) {
            return Image(
              height: MediaQuery.of(context).size.height * 0.4,
              image: imageProvider,
              fit: BoxFit.contain,
            );
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppInsets.xxl,
              vertical: AppInsets.xl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: package.provider.logo,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppInsets.med),
                Text(
                  package.provider.name,
                  style: providerNameStyle,
                ),
                const SizedBox(height: AppInsets.l),
                Text(
                  package.title,
                  style: headingStyle,
                ),
                const SizedBox(height: AppInsets.xl),
                Text(
                  package.shortDesc,
                  style: descStyle,
                ),
                Expanded(
                  child: Container(),
                ),
                Center(
                  child: RedeemButton(
                    buttonTheme: ButtonThemeData(
                      buttonColor: Colors.white,
                      splashColor: Colors.grey[100],
                      highlightColor: Colors.grey[100],
                      focusColor: Colors.grey[100],
                      textTheme: ButtonTextTheme.primary,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        PackageDetailModal(
                          package: package,
                        ),
                      );
                    },
                    child: Text(redeemText),
                  ),
                ),
                const SizedBox(height: AppInsets.xl)
              ],
            ),
          ),
        )
      ],
    );
  }
}
