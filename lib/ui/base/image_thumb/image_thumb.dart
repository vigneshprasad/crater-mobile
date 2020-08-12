import 'package:flutter/material.dart';

class ImageThumb extends StatelessWidget {
  final ImageProvider image;
  final VoidCallback onClosePress;

  const ImageThumb({
    Key key,
    @required this.image,
    @required this.onClosePress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 120,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: -2,
          top: -2,
          child: CloseButton(
            onPressed: onClosePress,
          ),
        )
      ],
    );
  }
}

class CloseButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CloseButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final splashColor = Theme.of(context).primaryColorDark;
    return RawMaterialButton(
      fillColor: primaryColor,
      splashColor: splashColor,
      highlightElevation: 1,
      constraints: const BoxConstraints(
        minHeight: 24,
        minWidth: 24,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      onPressed: onPressed,
      child: const Icon(
        Icons.close,
        size: 14,
        color: Colors.white,
      ),
    );
  }
}
