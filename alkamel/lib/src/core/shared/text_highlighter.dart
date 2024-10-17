// https://stackoverflow.com/a/59280491/11318150

import 'package:flutter/material.dart';

class HighlightText extends StatelessWidget {
  final String text;
  final String textToHighlight;
  final TextStyle? style;
  final TextStyle? highlightStyle;
  final bool ignoreCase;
  final bool ignoreArabicTashkel;

  const HighlightText({
    super.key,
    required this.text,
    required this.textToHighlight,
    this.style,
    this.highlightStyle,
    this.ignoreCase = true,
    this.ignoreArabicTashkel = true,
  });

  HighlightText.byColor({
    super.key,
    required this.text,
    required this.textToHighlight,
    this.style,
    required Color highlightColor,
    this.ignoreCase = true,
    this.ignoreArabicTashkel = true,
  }) : highlightStyle = style?.copyWith(color: highlightColor);

  List<TextSpan> _highlightOccurrences({
    required String source,
    required String query,
  }) {
    if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(
          TextSpan(
            text: source.substring(lastMatchEnd, match.start),
          ),
        );
      }

      children.add(
        TextSpan(
          text: source.substring(match.start, match.end),
          style: highlightStyle,
        ),
      );

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(
          TextSpan(
            text: source.substring(match.end, source.length),
          ),
        );
      }

      lastMatchEnd = match.end;
    }
    return children;
  }

  List<TextSpan> spans() {
    return _highlightOccurrences(
      source: text,
      query: textToHighlight,
    );
  }

  TextSpan textSpan() {
    return TextSpan(
      children: _highlightOccurrences(
        source: text,
        query: textToHighlight,
      ),
      style: style,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _highlightOccurrences(
          source: text,
          query: textToHighlight,
        ),
        style: style,
      ),
    );
  }
}
