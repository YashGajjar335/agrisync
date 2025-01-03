import 'package:flutter/material.dart';

class AnimatedToggleButton extends StatelessWidget {
  final bool currIndex;
  final Widget icon1;
  final Widget icon2;
  const AnimatedToggleButton(
      {super.key,
      required this.currIndex,
      required this.icon1,
      required this.icon2});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, anim) => RotationTransition(
        turns: child.key != const ValueKey('icon1')
            ? Tween<double>(begin: 0.75, end: 1).animate(anim)
            : Tween<double>(begin: 0.75, end: 1).animate(anim),
        child: FadeTransition(opacity: anim, child: child),
      ),
      child: currIndex
          ? SizedBox(
              height: 30,
              width: 30,
              key: const ValueKey('icon1'),
              child: icon1,
            )
          : SizedBox(
              height: 30,
              width: 30,
              key: const ValueKey('icon2'),
              child: icon2,
            ),
    );
  }
}
