import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/theme.dart';
import '../../../features/article/domain/entity/article_entity.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        splashColor: Colors.grey[200],
        onTap: () {
          _launchURL(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppInsets.xl),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(width: AppInsets.xl),
              _buildCardInfo(context),
              _buildImagePreview(context),
              const SizedBox(width: AppInsets.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardInfo(BuildContext context) {
    final headingStyle =
        Theme.of(context).textTheme.headline6?.copyWith(fontSize: 18);
    final bodyStyle = Theme.of(context).textTheme.bodyText2;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            article.title!,
            style: headingStyle,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppInsets.sm),
          Text(article.websiteTag!, style: bodyStyle),
          const SizedBox(height: AppInsets.med),
          Taglabel(label: article.tag ?? ''),
        ],
      ),
    );
  }

  Future<void> _launchURL(BuildContext context) async {
    try {
      if (article.websiteUrl == null) return;
      await launch(
        article.websiteUrl!,
        option: CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          // animation: CustomTabsSystemAnimation.slideIn(),
          extraCustomTabs: const <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }

  Widget _buildImagePreview(BuildContext context) {
    final image = article.picture;
    const defaultImage = AppImageAssets.articleDefault;
    if (image != null) {
      return CachedNetworkImage(
        imageUrl: image,
        errorWidget: (context, url, error) {
          return const _ImageThumbnail(
            image: defaultImage,
          );
        },
        imageBuilder: (context, imageProvider) {
          return _ImageThumbnail(image: imageProvider);
        },
      );
    } else {
      return const _ImageThumbnail(
        image: defaultImage,
      );
    }
  }
}

class _ImageThumbnail extends StatelessWidget {
  final ImageProvider<Object> image;

  const _ImageThumbnail({
    Key? key,
    required this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 74,
      height: 74,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: image),
      ),
    );
  }
}

class Taglabel extends StatelessWidget {
  final String label;

  const Taglabel({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          color: Colors.white,
          fontSize: 13,
        );
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(
          vertical: AppInsets.sm, horizontal: AppInsets.med),
      child: Text(label, style: labelStyle),
    );
  }
}
