import 'package:flutter/material.dart';

class DotBar extends StatelessWidget {
  final int length;
  final int activeIndex;
  final Color? dotColor;
  const DotBar({
    super.key,
    required this.length,
    required this.activeIndex,
    this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => Dot(
          index: index,
          isActive: index == activeIndex,
          color: dotColor,
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final int index;
  final bool isActive;
  final Color? color;
  const Dot({
    super.key,
    required this.index,
    required this.isActive,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final Color dotColor = color ?? Theme.of(context).colorScheme.primary;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 10,
      width: isActive ? 25 : 10,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: dotColor,
      ),
    );
  }
}
