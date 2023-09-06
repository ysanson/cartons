import 'dart:async';

import 'package:cartons/data/repository.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqLiteDatabase implements Repository {
  late Database _database;

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

  @override
  Future<void> init() async {
    _database = await _createDatabase();
  }

  @override
  Future<void> close() async {
    await _database.close();
  }

  @override
  Future<void> insert(String table, Map<String, Object?> data) async {
    await _database.insert(table, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> update(String table, Map<String, Object?> data) async {
    await _database.update(table, data,
        where: 'id = ?',
        whereArgs: [data['id']],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> delete(String table, int id) async {
    await _database.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Map<String, Object?>>> query(
    String table, {
    String? where,
    List<Object?>? whereArgs,
    int? limit,
  }) {
    return _database.query(table,
        where: where, whereArgs: whereArgs, limit: limit);
  }
}
