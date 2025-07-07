import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class databaseSqlProvider {
  static final databaseSqlProvider provider = databaseSqlProvider();
  Database? database;

  Future<Database> getDatabaseAllDestionation() async {
    if (database != null) {
      return database!;
    } else {
      database = await createDatabaseAllDestination();

      return database!;
    }
  }

  Future<Database> getDatabaseDestionationHistory() async {
    if (database != null) {
      return database!;
    } else {
      database = await createDatabaseAllDestination();

      return database!;
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
          "CREATE TABLE  destination("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "destinationId INTEGER ,"
          "typeSource TEXT, "
          "typeName TEXT, "
          "name TEXT, "
          "packageTypeId INTEGER "
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
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "destinationId INTEGER ,"
          "typeSource TEXT, "
          "typeName TEXT, "
          "name TEXT, "
          "packageTypeId INTEGER "
          ")",
        );
      },
    );
    return database;
  }
}
