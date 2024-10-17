// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alkamel/src/features/home/data/models/hadith_grade_enum.dart';
import 'package:equatable/equatable.dart';

/// ID	numbers in book b4	rawy	texts_in_first_bracket	texts_in_second_bracket	hadith
/// id (int) | order (int) | narrators (string) | hadith (string) | collection (string) | reference (string) | grade (string) | note (string)

class HadithEntity extends Equatable {
  final int id;
  final int number;
  final String rawy;
  final String rawyReference;
  final String grade;
  final String hadith;

  HadithGradeEnum get gradeEnum => HadithGradeEnum.getFromString(grade);

  const HadithEntity({
    required this.id,
    required this.number,
    required this.rawy,
    required this.rawyReference,
    required this.grade,
    required this.hadith,
  });

  @override
  List<Object> get props {
    return [
      id,
      number,
      rawy,
      rawyReference,
      grade,
      hadith,
    ];
  }
}
