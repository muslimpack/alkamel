// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    const imageBackgroundColor = Color(0xff313B47);

    const secondaryColor = Color(0xfff2dc5d);
    return Container(
      color: imageBackgroundColor,
      width: 1080,
      height: 1080,
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
            margin: const EdgeInsets.all(40),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.11),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(200),
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
                      hadith.hadith,
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
                "assets/images/app_icon2.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
