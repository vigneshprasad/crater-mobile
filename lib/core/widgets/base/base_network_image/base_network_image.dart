import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BaseNetworkImage extends StatelessWidget {
  final String imageUrl;
  final ImageWidgetBuilder imagebuilder;
  final LoadingErrorWidgetBuilder errorBuilder;
  final LoadingErrorWidgetBuilder loadingBuilder;
  final ImageProvider defaultImage;

  const BaseNetworkImage({
    Key key,
    @required this.imageUrl,
    @required this.imagebuilder,
    @required this.defaultImage,
    this.errorBuilder,
    this.loadingBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: imagebuilder,
        errorWidget: errorBuilder,
      );
    } else {
      return imagebuilder(context, defaultImage);
    }
  }
}
