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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: backgroundColor?.withOpacity(backgroundColorOpacity) ??
                  Colors.transparent,
              width: 7,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                hadith.rawy + hadith.rawyReference,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  hadith.hadith,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const Divider(),
              Text(hadith.grade),
            ],
          ),
        ),
      ),
    );
  }
}
