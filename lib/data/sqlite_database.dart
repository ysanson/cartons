import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqLiteDatabase {
  final Database _database;

  SqLiteDatabase({required Database database}) : _database = database;

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE locations(id INTEGER PRIMARY KEY, name TEXT, description TEXT)');
    await db.execute(
        'CREATE TABLE boxes(id INTEGER PRIMARY KEY, name TEXT, code TEXT, location_id INTEGER, type_id INTEGER, description TEXT) FOREIGN KEY(location_id) REFERENCES locations(id) ON DELETE CASCADE');
    await db.execute(
        'CREATE TABLE items(id INTEGER PRIMARY KEY, name TEXT, description TEXT, box_id INTEGER, image TEXT) FOREIGN KEY(box_id) REFERENCES boxes(id) ON DELETE CASCADE');
  }

  static Future<Database> _createDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'inventory.db'),
      onConfigure: _onConfigure,
      onCreate: _onCreate,
    );
    return database;
  }

  static Future<SqLiteDatabase> init() async {
    final database = await _createDatabase();
    return SqLiteDatabase(database: database);
  }

  Future<void> close() async {
    await _database.close();
  }

  Future<void> insert(String table, Map<String, Object?> data) async {
    await _database.insert(table, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
