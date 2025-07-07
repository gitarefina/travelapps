import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class databaseSqlProvider {
  static final databaseSqlProvider provider = databaseSqlProvider();
  Database? _database;

  Future<Database> get databaseHistory async {
    if (_database != null) return _database!;
    _database = await createDatabaseDestinationHistory();

    return _database!;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await createDatabaseDestinationHistory();

    return _database!;
  }

  Future<Database> getDatabaseAllDestionation() async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await createDatabaseAllDestination();

      return _database!;
    }
  }

  Future<Database> getDatabaseDestionationHistory() async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await createDatabaseAllDestination();

      return _database!;
    }
  }

  Future<Database> createDatabaseAllDestination() async {
    Directory docDirectory = await getApplicationDocumentsDirectory();

    String path = join(docDirectory.path, "travel.db");

    var database = await openDatabase(
      path,
      version: 1,
      onUpgrade: (db, oldVersion, newVersion) {
        if (newVersion > oldVersion) {}
      },
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE  destination_history ("
          "destination_id INTEGER PRIMARY KEY ,"
          "type_source TEXT, "
          "type_name TEXT, "
          "name TEXT, "
          "package_type_id INTEGER "
          ")",
        );
      },
    );
    return database;
  }

  Future<Database> createDatabaseDestinationHistory() async {
    Directory docDirectory = await getApplicationDocumentsDirectory();

    String path = join(docDirectory.path, "travel.db");

    var database = await openDatabase(
      path,
      version: 1,
      onUpgrade: (db, oldVersion, newVersion) {
        if (newVersion > oldVersion) {}
      },
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE  destination_history ("
          "destination_id INTEGER PRIMARY KEY ,"
          "type_source TEXT, "
          "type_name TEXT, "
          "name TEXT, "
          "package_type_id INTEGER "
          ")",
        );
      },
    );
    return database;
  }
}
