import 'package:alkamel/src/core/constants/constant.dart';

extension StringExtension on String {
  String get removeDiacritics {
    return replaceAll(
      RegExp(String.fromCharCodes(arabicDiacriticsChar)),
      "",
    );
  }

  String removeBrackets() {
    // Use RegExp to remove text inside parentheses along with the parentheses
    return replaceAll(RegExp(r'\(.*?\)'), '').trim();
  }
}
