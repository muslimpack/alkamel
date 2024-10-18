// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alkamel/src/features/home/data/models/hadith_grade_enum.dart';
import 'package:equatable/equatable.dart';

class HadithEntity extends Equatable {
  final int id;
  final int srcBookId;
  final String narrator;
  final String narratorReference;
  final String rank;
  final HadithGradeEnum ruling;
  final String hadith;

  const HadithEntity({
    required this.id,
    required this.srcBookId,
    required this.narrator,
    required this.narratorReference,
    required this.rank,
    required this.ruling,
    required this.hadith,
  });

  @override
  List<Object> get props {
    return [
      id,
      srcBookId,
      narrator,
      narratorReference,
      rank,
      ruling,
      hadith,
    ];
  }
}
