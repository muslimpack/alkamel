// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alkamel/src/features/home/presentation/components/hadith_card_popup_menu.dart';
import 'package:alkamel/src/features/home/presentation/components/responsive_text.dart';
import 'package:alkamel/src/features/search/data/models/hadith.dart';
import 'package:flutter/material.dart';

class HadithCard extends StatelessWidget {
  final Hadith hadith;
  final EdgeInsetsGeometry? margin;
  final String? searchedText;
  const HadithCard({
    super.key,
    required this.hadith,
    this.searchedText,
    this.margin = const EdgeInsets.symmetric(vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: hadith.gradeEnum.color.withOpacity(.3),
              width: 7,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      hadith.rawy +
                          (hadith.rawyReference.isNotEmpty
                              ? "(${hadith.rawyReference})"
                              : ""),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  HadithCardPopupMenu(hadith: hadith),
                ],
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ResponsiveText(
                  hadith.hadith,
                  searchedText: searchedText,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const Divider(),
              Text(
                "المرتبة: ${hadith.grade}  |  الحكم: [${hadith.gradeEnum.title}]",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: hadith.gradeEnum.color,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
