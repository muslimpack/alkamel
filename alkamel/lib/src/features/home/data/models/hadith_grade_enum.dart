import 'package:flutter/material.dart';

///   والحديث الصحيح مراتبه هي (صحيح، صحيح لغيره، حسن، حسن لغيره)
///   والحديث الضعيف (ضعيف، مرسل صحيح، مرسل حسن، مرسل ضعيف)
///   والحديث المتروك (ضعيف جدا، مرسل ضعيف جدا)
///   والحديث المكذوب (مكذوب)

enum HadithGradeEnum {
  athar(
    title: "أثر",
    color: Colors.green,
    lookupWords: [],
    lookupOrder: 4,
  ),

  authentic(
    title: "صحيح",
    color: Colors.green,
    lookupWords: ["صحيح", "حسن"],
    lookupOrder: 3,
  ),
  weak(
    title: "ضعيف",
    color: Colors.yellow,
    lookupWords: ["ضعيف", "مرسل"],
    lookupOrder: 2,
  ),
  abandoned(
    title: "متروك",
    color: Colors.orange,
    lookupWords: ["ضعيف جد"],
    lookupOrder: 1,
  ),
  fabricated(
    title: "مكذوب",
    color: Colors.red,
    lookupWords: ["مكذوب"],
    lookupOrder: 0,
  ),
  ;

  const HadithGradeEnum({
    required this.title,
    required this.color,
    required this.lookupWords,
    required this.lookupOrder,
  });

  static HadithGradeEnum getFromString(String gradeText) {
    HadithGradeEnum? hadithGradeEnum;
    for (final grade in HadithGradeEnum.values.reversed) {
      if (hadithGradeEnum != null) break;
      for (final dbG in grade.lookupWords) {
        if (gradeText.contains(dbG)) {
          hadithGradeEnum = grade;
          break;
        }
      }
    }

    return hadithGradeEnum ?? HadithGradeEnum.athar;
  }

  static HadithGradeEnum fromString(String rulingText) {
    return HadithGradeEnum.values.where((e) => e.title == rulingText).first;
  }

  final List<String> lookupWords;
  final String title;
  final Color color;
  final int lookupOrder;
}
