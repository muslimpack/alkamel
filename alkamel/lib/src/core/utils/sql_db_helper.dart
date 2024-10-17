import 'dart:async';
import 'dart:io';

import 'package:alkamel/src/core/functions/print.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqlDBHelper {
  late final String dbName;
  late final int dbVersion;

  SqlDBHelper({required this.dbName, required this.dbVersion}) {
    appPrint("DatabaseHelper for $dbName");
  }

  Future<String> getDbPath() async {
    late final String path;

    if (Platform.isWindows) {
      final dbPath = (await getApplicationSupportDirectory()).path;
      path = join(dbPath, dbName);
    } else {
      final dbPath = await getDatabasesPath();
      path = join(dbPath, dbName);
    }

    return path;
  }

  /// Instead of copying a .db file, this will load and execute the .sql file
  Future<void> executeSqlFromAssets(Database db, String sqlAssetPath) async {
    appPrint("Loading SQL file $sqlAssetPath...");

    try {
      // Load the .sql file from assets
      final ByteData data = await rootBundle.load(sqlAssetPath);
      final String sql = String.fromCharCodes(data.buffer.asUint8List());

      // Split the SQL file into individual commands
      final List<String> sqlCommands =
          sql.split(';').where((cmd) => cmd.trim().isNotEmpty).toList();

      // Execute each SQL command in the database
      for (final String command in sqlCommands) {
        await db.execute(command.trim());
      }

      appPrint("SQL execution done");
    } catch (e) {
      appPrint("SQL execution failed: $e");
    }
  }

  Future<Database> initDatabase() async {
    appPrint("$dbName init db");
    final String path = await getDbPath();
    final bool exist = await databaseExists(path);

    final fileName = dbName.split(".").first;

    if (!exist) {
      // If database does not exist, create it by executing the .sql file
      appPrint("$dbName does not exist, creating new db...");
      final Database db = await openDatabase(
        path,
        version: dbVersion,
        onCreate: (db, version) async {
          await executeSqlFromAssets(db, 'assets/db/$fileName.sql');
        },
      );
      return db;
    } else {
      // If database exists, open it
      final Database db = await openDatabase(path);

      await db.getVersion().then((currentVersion) async {
        if (currentVersion < dbVersion) {
          appPrint("$dbName detect new version");
          await deleteDatabase(path);
          final Database newDb = await openDatabase(
            path,
            version: dbVersion,
            onCreate: (db, version) async {
              await executeSqlFromAssets(db, 'assets/db/$fileName.sql');
            },
          );
          return newDb;
        }
      });

      return db;
    }
  }
}
