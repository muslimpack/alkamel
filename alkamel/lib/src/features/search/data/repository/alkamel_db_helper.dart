import 'dart:async';

import 'package:alkamel/src/core/utils/db_helper.dart';
import 'package:alkamel/src/features/home/data/models/hadith_ruling_enum.dart';
import 'package:alkamel/src/features/search/data/models/hadith.dart';
import 'package:alkamel/src/features/search/data/models/search_header.dart';
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

  Future<SearchHeader> searchByHadithTextWithFiltersInfo(
    String hadithText, {
    required List<HadithRulingEnum> ruling,
  }) async {
    final Database db = await database;

    final rulingString = ruling
        .map((e) => e.title)
        .map((word) => "ruling LIKE '%$word%'")
        .join(' OR ');

    final sqlString =
        'SELECT ${SearchHeader.query} FROM hadith WHERE hadith LIKE ? AND ($rulingString)';

    final List<Map<String, dynamic>> maps =
        await db.rawQuery(sqlString, ['%$hadithText%']);

    final result = SearchHeader.fromMap(maps.first);

    return result;
  }

  Future<List<Hadith>> searchByHadithTextWithFilters(
    String hadithText, {
    required List<HadithRulingEnum> ruling,
    required int limit, // Number of items per page
    required int offset, // Offset to start fetching items from
  }) async {
    final Database db = await database;

    // Build the ruling filter string
    final rulingString = ruling
        .map((e) => e.title)
        .map((word) => "ruling LIKE '%$word%'")
        .join(' OR ');

    // Add LIMIT and OFFSET to the SQL query
    final sqlString =
        'SELECT * FROM hadith WHERE hadith LIKE ? AND ($rulingString) '
        'LIMIT ? OFFSET ?';

    final List<Map<String, dynamic>> maps =
        await db.rawQuery(sqlString, ['%$hadithText%', limit, offset]);

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
