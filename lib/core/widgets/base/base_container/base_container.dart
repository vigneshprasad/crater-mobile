import 'package:flutter/material.dart';

class BaseContainer extends StatefulWidget {
  final Widget? child;
  final double radius;
  final Color? color;
  final bool disableAnimation;

  const BaseContainer({
    Key? key,
    this.child,
    this.radius = 8,
    this.color,
    this.disableAnimation = false,
  }) : super(key: key);

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
    return widget.disableAnimation == false
        ? Listener(
            onPointerDown: _onPointerDown,
            onPointerUp: _onPointerUp,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                  color: color,
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.radius)),
                  boxShadow: _isPressed
                      ? null
                      : [
                          const BoxShadow(
                              color: Colors.black38,
                              offset: Offset(5.0, 5.0),
                              blurRadius: 5.0,
                              spreadRadius: 1.0),
                          BoxShadow(
                              color: Colors.white10.withAlpha(15),
                              offset: const Offset(-5.0, -5.0),
                              blurRadius: 5.0,
                              spreadRadius: 1.0),
                        ]),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(widget.radius))),
                child: widget.child,
              ),
            ))
        : Container(
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
                boxShadow: [
                  const BoxShadow(
                      color: Colors.black38,
                      offset: Offset(5.0, 5.0),
                      blurRadius: 5.0,
                      spreadRadius: 1.0),
                  BoxShadow(
                      color: Colors.white10.withAlpha(15),
                      offset: const Offset(-5.0, -5.0),
                      blurRadius: 5.0,
                      spreadRadius: 1.0),
                ]),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.radius))),
              child: widget.child,
            ),
          );
  }
}
