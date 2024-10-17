// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:alkamel/src/features/home/data/models/hadith_grade_enum.dart';
import 'package:alkamel/src/features/search/data/models/hadith.dart';
import 'package:flutter/material.dart';

class HadithCard extends StatelessWidget {
  final Hadith hadith;
  final EdgeInsetsGeometry? margin;
  const HadithCard({
    super.key,
    required this.hadith,
    this.margin = const EdgeInsets.symmetric(vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    HadithGradeEnum? hadithGradeEnum;
    for (final grade in HadithGradeEnum.values) {
      if (hadithGradeEnum != null) break;
      for (final dbG in grade.dbNames) {
        if (hadith.grade.contains(dbG)) {
          hadithGradeEnum = grade;
          break;
        }
      }
    }
    return Card(
      margin: margin,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color:
                  hadithGradeEnum?.color.withOpacity(.3) ?? Colors.transparent,
              width: 7,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      hadith.rawy + hadith.rawyReference,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ResponsiveText(
                  hadith.hadith,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const Divider(),
              Text(
                hadith.grade,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: hadithGradeEnum?.color,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResponsiveText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
  });

  @override
  State<ResponsiveText> createState() => _ResponsiveTextState();
}

class _ResponsiveTextState extends State<ResponsiveText> {
  late bool expanded;
  late bool isLong;
  final int length = 280;

  @override
  void initState() {
    isLong = widget.text.length > length;
    expanded = !isLong;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      expanded
          ? widget.text
          : "${widget.text.substring(
              0,
              min(widget.text.length, length),
            )}...المزيد",
    );

    if (isLong) {
      return GestureDetector(
        onTap: () {
          setState(() {
            expanded = !expanded;
          });
        },
        child: textWidget,
      );
    }

    return textWidget;
  }
}
