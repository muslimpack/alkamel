import 'package:alkamel/src/features/home/data/models/hadith_ruling_enum.dart';
import 'package:hive/hive.dart';

class SearchRepo {
  final Box box;

  SearchRepo(this.box);

  static const String searchRulingFiltersKey = "searchRulingFilters";
  List<HadithRulingEnum> get searchRulingFilters {
    final data = box.get(searchRulingFiltersKey) as String?;
    if (data == null) return HadithRulingEnum.values;
    try {
      final splitted = data.split(",").map(
            (id) => HadithRulingEnum.values
                .where((r) => r.id.toString() == id)
                .first,
          );

      return splitted.toList();
    } catch (e) {
      return HadithRulingEnum.values;
    }
  }

  Future setSearchRulingFilters(
    List<HadithRulingEnum> rulingSearchFilters,
  ) async {
    return box.put(
      searchRulingFiltersKey,
      rulingSearchFilters.map((x) => x.id).join(","),
    );
  }
}
