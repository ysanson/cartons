import 'package:cartons/data/repository.dart';
import 'package:cartons/data/sqlite_database.dart';

class DatabaseProvider {
  static final DatabaseProvider _databaseProvider =
      DatabaseProvider._internal();
  Repository? _database;

  factory DatabaseProvider() {
    return _databaseProvider;
  }

  DatabaseProvider._internal();

  Future<Repository> get database async {
    if (_database == null) {
      _database = SqLiteDatabase();
      await _database?.init();
    }
    return _database!;
  }
}
