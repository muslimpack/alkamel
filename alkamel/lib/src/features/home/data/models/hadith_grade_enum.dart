import 'package:flutter/material.dart';

enum HadithGradeEnum {
  authentic(Colors.green, ["صحيح", "صحيح لغيره", "حسن", "حسن لغيره"]),
  weak(Colors.yellow, ["ضعيف", "مرسل صحيح", "مرسل حسن", "مرسل ضعيف"]),
  abandoned(Colors.orange, ["ضعيف جدا", "مرسل ضعيف جدا"]),
  fabricated(Colors.red, ["مكذوب"]),
  ;

  const HadithGradeEnum(this.color, this.dbNames);
  final List<String> dbNames;
  final Color color;
}
