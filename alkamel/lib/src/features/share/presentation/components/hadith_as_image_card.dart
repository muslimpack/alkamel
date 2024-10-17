// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:alkamel/src/core/functions/print.dart';
import 'package:alkamel/src/features/search/data/models/hadith.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HadithAsImageCard extends StatelessWidget {
  final Hadith hadith;
  const HadithAsImageCard({
    super.key,
    required this.hadith,
  });

  @override
  Widget build(BuildContext context) {
    const int standardImageSize = 1080;
    const int charLengthPer1080 = 1500;
    // ignore: unused_local_variable
    const goldenRatio = 1.618;

    final String hadithText = hadith.hadith;

    final double heightFactor = hadithText.length / charLengthPer1080;

    final int imageSize = (standardImageSize * max(1, heightFactor)).toInt();
    final int imageHeight = imageSize;
    final int imageWidth = imageSize;

    appPrint("WIdth: $imageWidth | Height: $imageHeight");

    const imageBackgroundColor = Color(0xff313B47);
    const secondaryColor = Color(0xfff2dc5d);

    return Container(
      color: imageBackgroundColor,
      width: imageWidth.toDouble(),
      height: imageHeight.toDouble(),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: .04,
            child: Image.asset(
              "assets/images/grid.png",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                focalRadius: 200,
                colors: [
                  imageBackgroundColor,
                  Colors.transparent,
                ],
                radius: 1,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(40).copyWith(top: 60, bottom: 60),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.11),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(250),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  hadith.rawy +
                      (hadith.rawyReference.isNotEmpty
                          ? "(${hadith.rawyReference})"
                          : ""),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    color: secondaryColor,
                    fontFamily: "alhadari-medium",
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Center(
                    child: AutoSizeText(
                      maxFontSize: 80,
                      minFontSize: 30,
                      hadithText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 80,
                        fontFamily: "djadli_sarkha",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Text(
                    "المرتبة: ${hadith.grade}\nالحكم: [${hadith.gradeEnum.title}]",
                    style: const TextStyle(
                      fontSize: 30,
                      color: secondaryColor,
                      fontFamily: "alhadari-medium",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                "assets/images/app_icon.png",
                height: 70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
