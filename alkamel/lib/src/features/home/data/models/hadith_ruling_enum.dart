import 'package:flutter/material.dart';

///   والحديث الصحيح مراتبه هي (صحيح، صحيح لغيره، حسن، حسن لغيره)
///   والحديث الضعيف (ضعيف، مرسل صحيح، مرسل حسن، مرسل ضعيف)
///   والحديث المتروك (ضعيف جدا، مرسل ضعيف جدا)
///   والحديث المكذوب (مكذوب)

enum HadithRulingEnum {
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

  const HadithRulingEnum({
    required this.title,
    required this.color,
    required this.lookupWords,
    required this.lookupOrder,
  });

  static HadithRulingEnum fromString(String rulingText) {
    return HadithRulingEnum.values.where((e) => e.title == rulingText).first;
  }

  final List<String> lookupWords;
  final String title;
  final Color color;
  final int lookupOrder;
}
