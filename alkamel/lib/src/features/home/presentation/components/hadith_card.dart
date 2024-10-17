// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:alkamel/src/core/shared/text_highlighter.dart';
import 'package:alkamel/src/features/home/data/models/hadith_grade_enum.dart';
import 'package:alkamel/src/features/search/data/models/hadith.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HadithCard extends StatelessWidget {
  final Hadith hadith;
  final EdgeInsetsGeometry? margin;
  final String? searchedText;
  const HadithCard({
    super.key,
    required this.hadith,
    this.searchedText,
    this.margin = const EdgeInsets.symmetric(vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    final HadithGradeEnum hadithGradeEnum =
        HadithGradeEnum.getFromString(hadith.grade);

    return Card(
      margin: margin,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: hadithGradeEnum.color.withOpacity(.3),
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
                      hadith.rawy +
                          (hadith.rawyReference.isNotEmpty
                              ? "(${hadith.rawyReference})"
                              : ""),
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
                  searchedText: searchedText,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const Divider(),
              Text(
                "المرتبة: ${hadith.grade}  |  الحكم: [${hadithGradeEnum.title}]",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: hadithGradeEnum.color,
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
  final String? searchedText;
  final TextStyle? style;
  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.searchedText,
  });

  @override
  State<ResponsiveText> createState() => _ResponsiveTextState();
}

class _ResponsiveTextState extends State<ResponsiveText> {
  late bool expanded;
  bool isLong = true;
  final int length = 280;

  @override
  void initState() {
    isLong = widget.text.length > length;
    expanded = !isLong;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// bodyText
    final bodyText = expanded
        ? widget.text
        : widget.text.substring(0, min(widget.text.length, length));

    final bodyTextSpan = HighlightText(
      text: bodyText,
      textToHighlight: widget.searchedText ?? "",
      highlightStyle: widget.style?.copyWith(
        color: Theme.of(context).colorScheme.primary,
      ),
      style: widget.style,
    ).textSpan();

    /// show more
    final bool showMoreText = !expanded && widget.text.length > length;

    final moreTextSpan = TextSpan(
      text: " ...المزيد",
      style: const TextStyle(color: Colors.blue),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          setState(() {
            expanded = true;
          });
        },
    );

    ///
    final textWidget = Text.rich(
      TextSpan(
        children: [
          bodyTextSpan,
          if (showMoreText) moreTextSpan,
        ],
      ),
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
