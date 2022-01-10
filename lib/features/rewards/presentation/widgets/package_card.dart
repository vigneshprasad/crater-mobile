import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../constants/theme.dart';
import '../../../../core/color/color.dart';
import '../../../../routes.gr.dart';
import '../../domain/entity/package_entity.dart';

class PackageCard extends StatelessWidget {
  final Package package;

  const PackageCard({
    Key? key,
    required this.package,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: package.isDark! ? AppTheme.darkTheme : Theme.of(context),
      child: Builder(
        builder: (context) {
          final headingStyle = Theme.of(context).textTheme.headline6?.copyWith(
                fontSize: 20,
              );
          final descStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
                height: 1.4,
              );
          final borderRadius = BorderRadius.circular(12);

          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            child: Material(
              type: MaterialType.card,
              borderRadius: borderRadius,
              color: HexColor.fromHex(package.color!),
              child: InkWell(
                onTap: () => _onTapCard(context),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: AppInsets.xl,
                    right: AppInsets.xl,
                    top: AppInsets.xxl,
                    bottom: AppInsets.xxl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(package.title!, style: headingStyle),
                      const SizedBox(height: AppInsets.l),
                      Text(package.shortDesc!, style: descStyle),
                      const SizedBox(height: 32),
                      _buildImage(context),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: package.listImage!,
      imageBuilder: (context, imageProvider) => Center(
        child: Image(
          image: imageProvider,
          width: MediaQuery.of(context).size.width * 0.8,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _onTapCard(BuildContext context) {
    AutoRouter.of(context).push(
      PackageDetailScreenRoute(packageId: package.pk!),
    );
  }
}
