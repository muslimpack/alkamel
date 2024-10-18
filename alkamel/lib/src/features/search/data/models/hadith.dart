import 'package:alkamel/src/core/extensions/string_extension.dart';
import 'package:alkamel/src/features/home/data/models/hadith_ruling_enum.dart';
import 'package:alkamel/src/features/search/domain/entities/hadith_entity.dart';

class Hadith extends HadithEntity {
  const Hadith({
    required super.id,
    required super.srcBookId,
    required super.narrator,
    required super.narratorReference,
    required super.rank,
    required super.ruling,
    required super.hadith,
  });

  factory Hadith.fromMap(Map<String, dynamic> map) {
    return Hadith(
      id: map['id'] as int,
      srcBookId: map['srcBookId'] as int,
      narrator: map['narrator'] as String? ?? "",
      narratorReference:
          (map['narratorReference'] as String? ?? "").removeBrackets(),
      rank: (map['rank'] as String).removeBrackets(),
      ruling: HadithRulingEnum.fromString(map['ruling'] as String),
      hadith: map['hadith'] as String,
    );
  }
}
