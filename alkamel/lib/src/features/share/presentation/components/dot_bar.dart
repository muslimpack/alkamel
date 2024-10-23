import 'package:flutter/material.dart';

class DotBar extends StatelessWidget {
  final int length;
  final int activeIndex;
  const DotBar({
    super.key,
    required this.length,
    required this.activeIndex,
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
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final int index;
  final bool isActive;
  const Dot({
    super.key,
    required this.index,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 10,
      width: isActive ? 25 : 10,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
