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
    final secondaryElementsColor = hadith.ruling.color.withOpacity(.15);

    const mainTextStyle = TextStyle(
      fontSize: 150,
      fontFamily: "djadli_sarkha",
      color: Colors.white,
    );

    const secondaryTextStyle = TextStyle(
      fontSize: 30,
      color: secondaryColor,
      fontFamily: "alhadari-medium",
    );
    return Container(
      color: imageBackgroundColor,
      width: imageWidth.toDouble(),
      height: imageHeight.toDouble(),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/grid.png",
            fit: BoxFit.cover,
            color: secondaryElementsColor,
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
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
              border: Border.all(
                color: secondaryElementsColor,
                width: 5,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(255),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  hadith.narrator +
                      (hadith.narratorReference.isNotEmpty
                          ? "(${hadith.narratorReference})"
                          : ""),
                  textAlign: TextAlign.center,
                  style: secondaryTextStyle,
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Center(
                    child: AutoSizeText(
                      hadithText,
                      minFontSize: 30,
                      textAlign: TextAlign.center,
                      style: mainTextStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Text(
                    "المرتبة: ${hadith.rank}\nالحكم: [${hadith.ruling.title}]",
                    style: secondaryTextStyle,
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
                height: 80,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
