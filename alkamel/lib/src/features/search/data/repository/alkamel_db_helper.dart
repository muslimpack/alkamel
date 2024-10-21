import 'dart:async';

import 'package:alkamel/src/core/utils/db_helper.dart';
import 'package:alkamel/src/features/home/data/models/hadith_ruling_enum.dart';
import 'package:alkamel/src/features/search/data/models/hadith.dart';
import 'package:alkamel/src/features/search/data/models/search_header.dart';
import 'package:alkamel/src/features/search/data/models/search_result_info.dart';
import 'package:alkamel/src/features/search/data/models/search_type.dart';
import 'package:sqflite/sqflite.dart';

class AlkamelDbHelper {
  /* ************* Variables ************* */

  static const String dbName = "alkamel.db";
  static const int dbVersion = 1;

  /* ************* Singleton Constructor ************* */

  static AlkamelDbHelper? _instance;
  static Database? _database;
  static late final DBHelper _dbHelper;

  factory AlkamelDbHelper() {
    _dbHelper = DBHelper(dbName: dbName, dbVersion: dbVersion);
    _instance ??= AlkamelDbHelper._createInstance();
    return _instance!;
  }

  AlkamelDbHelper._createInstance();

  Future<Database> get database async {
    _database ??= await _dbHelper.initDatabase();
    return _database!;
  }

  Future<void> init() async {
    // Ensure the database is initialized
    await database;
  }

  /* ************* | ************* */

  Future<List<Hadith>> getAll() async {
    final Database db = await database;

    ///TODO |  ORDER BY `order` ASC
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM hadith');

    return List.generate(maps.length, (i) {
      return Hadith.fromMap(maps[i]);
    });
  }

  Future<Hadith?> getHadithById(int id) async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FRMO hadith where id = ?', [id]);

    return List.generate(maps.length, (i) {
      return Hadith.fromMap(maps[i]);
    }).firstOrNull;
  }

  Future<List<Hadith>> searchByHadithText(String hadithText) async {
    if (hadithText.isEmpty) return [];

    final Database db = await database;

    ///TODO |  ORDER BY `order` ASC
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT * FROM hadith WHERE hadith LIKE ?',
      ['%$hadithText%'],
    );

    return List.generate(maps.length, (i) {
      return Hadith.fromMap(maps[i]);
    });
  }

  Future<SearchResultInfo> searchByHadithTextWithFiltersInfo(
    String hadithText, {
    required List<HadithRulingEnum> ruling,
  }) async {
    if (hadithText.isEmpty || ruling.isEmpty) return SearchResultInfo.empty();

    final Database db = await database;

    final rulingString = ruling
        .map((e) => e.title)
        .map((word) => "ruling LIKE '%$word%'")
        .join(' OR ');

    final sqlFiltered =
        'SELECT ${SearchHeader.query} FROM hadith WHERE hadith LIKE ? AND ($rulingString)';

    final sqlTotal =
        'SELECT ${SearchHeader.query} FROM hadith WHERE hadith LIKE ?';

    final List<Map<String, dynamic>> totalMaps =
        await db.rawQuery(sqlTotal, ['%$hadithText%']);

    final List<Map<String, dynamic>> filteredMap =
        await db.rawQuery(sqlFiltered, ['%$hadithText%']);

    final total = SearchHeader.fromMap(totalMaps.first);
    final filtered = SearchHeader.fromMap(filteredMap.first);

    return SearchResultInfo(total: total, filtered: filtered);
  }

  Future<List<Hadith>> searchByHadithTextWithFilters(
    String searchText, {
    required List<HadithRulingEnum> ruling,
    required SearchType searchType,
    required int limit, // Number of items per page
    required int offset, // Offset to start fetching items from
  }) async {
    if (searchText.isEmpty || ruling.isEmpty) return [];

    final Database db = await database;

    final List<String> splittedSearchWords = searchText.trim().split(' ');

    // Build the ruling filter string
    final rulingString = ruling
        .map((e) => e.title)
        .map((word) => "ruling LIKE '%$word%'")
        .join(' OR ');

    final String sqlString;
    final List<Object?> sqlParams = [];

    switch (searchType) {
      case SearchType.typical:
        sqlString =
            'SELECT * FROM hadith WHERE hadith LIKE ? AND ($rulingString) '
            'LIMIT ? OFFSET ?';
        sqlParams.addAll(['%$searchText%', limit, offset]);

      case SearchType.allWords:
        final String allWordsQuery =
            splittedSearchWords.map((word) => 'hadith LIKE ?').join(' AND ');
        final List<String> params =
            splittedSearchWords.map((word) => '%$word%').toList();
        sqlString =
            'SELECT * FROM hadith WHERE ($allWordsQuery) AND ($rulingString) '
            'LIMIT ? OFFSET ?';
        sqlParams.addAll([...params, limit, offset]);

      case SearchType.anyWords:
        final String allWordsQuery =
            splittedSearchWords.map((word) => 'hadith LIKE ?').join(' OR ');
        final List<String> params =
            splittedSearchWords.map((word) => '%$word%').toList();
        sqlString =
            'SELECT * FROM hadith WHERE ($allWordsQuery) AND ($rulingString) '
            'LIMIT ? OFFSET ?';
        sqlParams.addAll([...params, limit, offset]);
    }

    final List<Map<String, dynamic>> maps =
        await db.rawQuery(sqlString, sqlParams);

    return List.generate(maps.length, (i) {
      return Hadith.fromMap(maps[i]);
    });
  }

  Future<List<Hadith>> searchByRawy(String rawy) async {
    final Database db = await database;

    ///TODO |  ORDER BY `order` ASC
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT * FROM hadith WHERE hadith LIKE ?',
      ['%$rawy%'],
    );

    return List.generate(maps.length, (i) {
      return Hadith.fromMap(maps[i]);
    });
  }

  Future<Hadith?> randomHadith(HadithRulingEnum ruling) async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT * FROM hadith WHERE ruling like ? ORDER BY RANDOM() LIMIT 1',
      ['%${ruling.title}%'],
    );

    if (maps.isNotEmpty) {
      return Hadith.fromMap(maps.first);
    }

    return null;
  }

  /// Close database
  Future close() async {
    final db = await database;
    db.close();
  }
}
