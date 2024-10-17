import 'package:alkamel/src/core/extensions/string_extension.dart';
import 'package:alkamel/src/features/search/domain/entities/hadith_entity.dart';

class Hadith extends HadithEntity {
  const Hadith({
    required super.id,
    required super.number,
    required super.rawy,
    required super.rawyReference,
    required super.grade,
    required super.hadith,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'number': number,
      'rawy': rawy,
      'rawyRefrence': rawyReference,
      'grade': grade,
      'hadith': hadith,
    };
  }

  factory Hadith.fromMap(Map<String, dynamic> map) {
    return Hadith(
      id: map['id'] as int,
      number: map['number'] as int,
      rawy: map['rawy'] as String? ?? "",
      rawyReference: (map['rawyRefrence'] as String? ?? "").removeBrackets(),
      grade: (map['grade'] as String? ?? "").removeBrackets(),
      hadith: map['hadith'] as String,
    );
  }
}
