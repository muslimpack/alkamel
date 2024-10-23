// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alkamel/src/core/functions/print.dart';
import 'package:alkamel/src/features/search/data/models/hadith.dart';
import 'package:alkamel/src/features/share/data/models/hadith_image_card_settings.dart';
import 'package:alkamel/src/features/share/presentation/components/dot_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HadithAsImageCard extends StatelessWidget {
  final Hadith hadith;
  final HadithImageCardSettings settings;
  final RangeValues? matnRange;
  final int splittedLength;
  final int splittedindex;
  const HadithAsImageCard({
    super.key,
    required this.hadith,
    required this.settings,
    this.matnRange,
    this.splittedLength = 0,
    this.splittedindex = 0,
  });

  String get hadithText {
    const String separator = "...";
    String hadithText = matnRange != null
        ? hadith.hadith.substring(
            matnRange!.start.toInt(),
            matnRange!.end.toInt(),
          )
        : hadith.hadith;

    if (splittedLength > 1) {
      if (splittedindex == 0) {
        hadithText += separator;
      } else if (splittedindex == splittedLength - 1) {
        hadithText = "$separator$hadithText";
      } else {
        hadithText = "$separator$hadithText$separator";
      }
    }

    return hadithText;
  }

  @override
  Widget build(BuildContext context) {
    appPrint(hadithText.length);

    const imageBackgroundColor = Color(0xff313B47);
    const secondaryColor = Color(0xfff2dc5d);
    final secondaryElementsColor = hadith.rulingEnum.color.withOpacity(.15);

    final mainTextStyle = TextStyle(
      fontSize: 150,
      fontFamily: settings.mainFontFamily,
      color: Colors.white,
    );

    final secondaryTextStyle = TextStyle(
      fontSize: 30,
      color: secondaryColor,
      fontFamily: settings.secondaryFontFamily,
    );
    return Container(
      color: imageBackgroundColor,
      width: settings.imageSize.width,
      height: settings.imageSize.height,
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
                          ? " (${hadith.narratorReference})"
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
                    "المرتبة: ${hadith.rank}\nالحكم: [${hadith.rulingEnum.title}]",
                    style: secondaryTextStyle,
                  ),
                ),
              ],
            ),
          ),
          if (splittedLength > 1)
            Padding(
              padding: const EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: DotBar(
                  activeIndex: splittedindex,
                  length: splittedLength,
                ),
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
