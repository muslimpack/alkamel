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
    final String hadithText = hadith.hadith;

    final int heightFactor = hadithText.length ~/ 2500;

    final int imageHeight = 1080 * max(1, heightFactor);
    final int imageWidth =
        (1080 + (heightFactor > 1 ? (imageHeight / 2) : 0)).toInt();

    appPrint("$imageHeight $imageWidth");
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
                      minFontSize: 15,
                      hadithText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 80,
                        fontFamily: "djadli_sarkha",
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
