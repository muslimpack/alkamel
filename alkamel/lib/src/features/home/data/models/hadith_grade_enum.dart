import 'package:flutter/material.dart';

enum HadithGradeEnum {
  authentic(
    "صحيح",
    Colors.green,
    ["صحيح", "صحيح لغيره", "حسن", "حسن لغيره"],
  ),
  weak(
    "ضعيف",
    Colors.yellow,
    ["ضعيف", "مرسل صحيح", "مرسل حسن", "مرسل ضعيف"],
  ),
  abandoned(
    "متروك",
    Colors.orange,
    ["ضعيف جدا", "مرسل ضعيف جدا"],
  ),
  fabricated(
    "مكذوب",
    Colors.red,
    ["مكذوب"],
  ),
  ;

  const HadithGradeEnum(this.title, this.color, this.dbNames);
  final List<String> dbNames;
  final String title;
  final Color color;
}
