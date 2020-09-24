import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';

import '../../domain/entity/article_entity.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({
    Key key,
    @required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 180,
        child: InkWell(
          onTap: () {
            _launchUrl(context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImagePreview(context),
              _buildContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview(BuildContext context) {
    final image = article.picture != null
        ? CachedNetworkImageProvider(article.picture) as ImageProvider
        : AppImageAssets.articleDefault;
    return Container(
      height: 96,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.bodyText1;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppInsets.l, vertical: AppInsets.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: titleStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const Spacer(),
            _Tag(
              tag: article.tag,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(BuildContext context) async {
    try {
      await launch(
        article.websiteUrl,
        option: CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (error) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(error.toString());
    }
  }
}

class _Tag extends StatelessWidget {
  final String tag;

  const _Tag({
    Key key,
    @required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tagStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).primaryColor,
        );
    return Container(
      padding: const EdgeInsets.all(AppInsets.sm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          width: 2,
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Text(tag, style: tagStyle),
    );
  }
}
