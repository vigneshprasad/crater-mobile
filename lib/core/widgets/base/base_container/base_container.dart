import 'package:flutter/material.dart';

class BaseContainer extends StatefulWidget {
  final Widget child;
  final double radius;
  final Color color;

  const BaseContainer({Key key, this.child, this.radius = 8, this.color})
      : super(key: key);

  @override
  _BaseContainerState createState() => _BaseContainerState();
}

class _BaseContainerState extends State<BaseContainer> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).backgroundColor;
    return Listener(
        onPointerDown: _onPointerDown,
        onPointerUp: _onPointerUp,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
              boxShadow: _isPressed
                  ? null
                  : [
                      const BoxShadow(
                          color: Colors.black38,
                          offset: Offset(5.0, 5.0),
                          blurRadius: 5.0,
                          spreadRadius: 1.0),
                      const BoxShadow(
                          color: Colors.white10,
                          offset: Offset(-5.0, -5.0),
                          blurRadius: 5.0,
                          spreadRadius: 1.0),
                    ]),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(widget.radius))),
            child: widget.child,
          ),
        ));
  }
}
