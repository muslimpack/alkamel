// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alkamel/src/features/search/data/models/hadith.dart';
import 'package:flutter/material.dart';

class HadithCard extends StatelessWidget {
  final Hadith hadith;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final double backgroundColorOpacity;
  const HadithCard({
    super.key,
    required this.hadith,
    this.backgroundColor,
    this.backgroundColorOpacity = .25,
    this.margin = const EdgeInsets.symmetric(vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      color: backgroundColor?.withOpacity(backgroundColorOpacity),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(hadith.rawy + hadith.rawyReference),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(hadith.hadith),
            ),
            const Divider(),
            Text(hadith.grade),
          ],
        ),
      ),
    );
  }
}
