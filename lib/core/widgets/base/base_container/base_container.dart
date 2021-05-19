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
    Color color = widget.color ?? Theme.of(context).backgroundColor;
    return Listener(
        onPointerDown: _onPointerDown,
        onPointerUp: _onPointerUp,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          // clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: color,
              // gradient: LinearGradient(
              //     begin: Alignment(-1.0, -4.0),
              //     end: Alignment(1.0, 4.0),
              //     colors: [
              //       Theme.of(context).backgroundColor.mix(Colors.black, 0.3),
              //       Theme.of(context).backgroundColor.mix(Colors.white, 0.1),
              //     ]),
              // gradient: LinearGradient(
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight,
              //     colors: [
              //       _isPressed ? color : color.mix(Colors.black, .1),
              //       _isPressed ? color.mix(Colors.black, .05) : color,
              //       _isPressed ? color.mix(Colors.black, .05) : color,
              //       color.mix(Colors.white, _isPressed ? .1 : .2),
              //     ],
              //     stops: [
              //       0.0,
              //       .3,
              //       .6,
              //       1.0,
              //     ]),
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

class NeumorphicContainer extends StatefulWidget {
  final Widget child;
  final double bevel;
  final Offset blurOffset;
  final Color color;

  NeumorphicContainer({
    Key key,
    this.child,
    this.bevel = 10.0,
    this.color,
  })  : this.blurOffset = Offset(bevel / 2, bevel / 2),
        super(key: key);

  @override
  _NeumorphicContainerState createState() => _NeumorphicContainerState();
}

class _NeumorphicContainerState extends State<NeumorphicContainer> {
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
    final color = this.widget.color ?? Theme.of(context).backgroundColor;

    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.bevel * 10),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _isPressed ? color : color.mix(Colors.black, .1),
                _isPressed ? color.mix(Colors.black, .05) : color,
                _isPressed ? color.mix(Colors.black, .05) : color,
                color.mix(Colors.white, _isPressed ? .2 : .5),
              ],
              stops: [
                0.0,
                .3,
                .6,
                1.0,
              ]),
          boxShadow: _isPressed
              ? null
              : [
                  BoxShadow(
                    blurRadius: widget.bevel,
                    offset: -widget.blurOffset,
                    color: color.mix(Colors.white, .6),
                  ),
                  BoxShadow(
                    blurRadius: widget.bevel,
                    offset: widget.blurOffset,
                    color: color.mix(Colors.black, .3),
                  )
                ],
        ),
        child: widget.child,
      ),
    );
  }
}

extension ColorUtils on Color {
  Color mix(Color another, double amount) {
    return Color.lerp(this, another, amount);
  }
}
