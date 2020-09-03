import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:url_launcher/url_launcher.dart' show launch;
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';
import 'package:worknetwork/features/community/domain/entity/post_entity.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/theme.dart';
import '../../../constants/work_net_icons_icons.dart';
import '../../../utils/parse_urls.dart';
import '../base_text/base_text.dart';
import '../base_text/base_text_expand.dart';
import 'post_card_actions.dart';

typedef PostItemFunc = void Function(int id);

class PostCard extends StatelessWidget {
  final User user;
  final Post post;
  final PostItemFunc onPostDelete;
  final PostItemFunc onLikePost;

  const PostCard({
    Key key,
    @required this.post,
    @required this.onPostDelete,
    @required this.user,
    @required this.onLikePost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final links = ParseUrls.getLinksList(post.message);
    return Card(
      elevation: 1,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getPostHeader(context),
          getPostContent(context),
          if (links.isNotEmpty) getPostLinkMeta(context, links[0]),
          const Divider(
            indent: AppInsets.xl,
            endIndent: AppInsets.xl,
          ),
          getPostActions(context),
        ],
      ),
    );
  }

  Widget getPostHeader(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.subtitle2;
    final subHeadStyle =
        Theme.of(context).textTheme.caption.apply(color: Colors.grey);
    final postCreatedTime = DateTime.parse(post.created);
    final createdFormater = DateFormat('MMM dd yyyy h:mm a');
    return Padding(
      padding: const EdgeInsets.all(AppInsets.xl),
      child: Row(
        children: <Widget>[
          if (post.creatorPhoto != null)
            CachedNetworkImage(
              imageUrl: post.creatorPhoto,
              placeholder: (context, url) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                width: 44,
                height: 44,
              ),
              imageBuilder: (context, imageProvider) => CircleAvatar(
                backgroundImage: imageProvider,
              ),
            ),
          if (post.creatorPhoto == null)
            const CircleAvatar(
              backgroundImage: AppImageAssets.defaultAvatar,
            ),
          const SizedBox(width: AppPadding.med),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BaseText(
                text: post.creatorName,
                style: headingStyle,
              ),
              const SizedBox(height: 2),
              BaseText(
                text: createdFormater.format(postCreatedTime),
                style: subHeadStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getPostContent(BuildContext context) {
    const basePadding = AppInsets.xl;
    final contentStyle = Theme.of(context).textTheme.bodyText2;
    return Padding(
      padding: const EdgeInsets.only(
          left: basePadding, bottom: basePadding, right: basePadding),
      child: BaseTextExpand(
        post.message,
        style: contentStyle,
      ),
    );
  }

  Widget getPostLinkMeta(BuildContext context, String link) {
    return FutureBuilder<http.Response>(
      future: http.get(link),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          final document = responseToDocument(snapshot.data);
          final data = MetadataParser.parse(document);
          if (isEmptyMetadata(data)) {
            return Container();
          }
          return Padding(
            padding: const EdgeInsets.only(
              left: AppInsets.med,
              right: AppInsets.med,
            ),
            child: Card(
              elevation: 1,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              color: Colors.grey[100],
              child: InkWell(
                highlightColor: Colors.grey[200],
                onTap: () {
                  if (snapshot.connectionState == ConnectionState.done) {
                    launch(link);
                  }
                },
                child: renderMetaData(data, context),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget renderMetaData(Metadata data, BuildContext context) {
    final headingStyle =
        Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.grey[800]);
    final bodyStyle =
        Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey[600]);
    const radius = Radius.circular(8);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (data.image != null)
          CachedNetworkImage(
            imageUrl: data.image,
            placeholder: (context, url) {
              return Lottie.asset(
                "assets/lottie/loading_dots.json",
                height: 64,
              );
            },
            imageBuilder: (context, imageProvider) {
              return Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: radius, topRight: radius),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppInsets.xl, vertical: AppInsets.xl),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: data.title,
                  style: headingStyle,
                ),
                const TextSpan(text: '\n\n'),
                TextSpan(
                  text: data.description,
                  style: bodyStyle,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getPostActions(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .button
        .copyWith(color: Colors.grey[400], fontSize: 16);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppInsets.med, vertical: AppInsets.sm),
      child: Row(
        children: <Widget>[
          PostCardActions(
            icon: Icon(
              WorkNetIcons.like,
              color: Colors.grey[500],
            ),
            label: Text(
              post.likes.toString(),
              style: textTheme,
            ),
            onPress: () {},
          ),
          PostCardActions(
            icon: Icon(
              WorkNetIcons.comment,
              color: Colors.grey[500],
            ),
            label: Text(
              post.comments.toString(),
              style: textTheme,
            ),
            onPress: () {},
          ),
          const Spacer(),
          if (user.pk == post.creator)
            PostCardActions(
              icon: Icon(
                WorkNetIcons.delete,
                color: Colors.grey[500],
              ),
              onPress: () => onPostDelete(post.pk),
            )
        ],
      ),
    );
  }

  bool isEmptyMetadata(Metadata data) {
    return data.image == null && data.title == null && data.description == null;
  }
}
