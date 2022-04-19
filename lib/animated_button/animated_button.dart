import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final Function() onPressed;
  final Widget child;

  const AnimatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _firstElement = true;

  final buttonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15), // <-- Radius
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _firstElement ? _widgetUser() : _widgetLoading(),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: ScaleTransition(
              child: child,
              scale: animation,
              alignment: Alignment.center,
            ),
          );
        },
      ),
    );
  }

  Widget _widgetLoading() {
    return ElevatedButton(
      key: const Key('__buttonLoading'),
      onPressed: () {
        setState(() {
          _firstElement = !_firstElement;
        });
      },
      style: buttonStyle,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'Loading...',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _widgetUser() {
    return ElevatedButton(
      key: const Key('__buttonUser'),
      onPressed: () {
        setState(() {
          _firstElement = !_firstElement;
        });

        widget.onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: widget.child,
      ),
      style: buttonStyle,
    );
  }
}
