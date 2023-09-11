import 'package:cartons/data/database_provider.dart';
import 'package:cartons/repositories/location_repository.dart';
import 'package:cartons/models/box.dart';
import 'package:cartons/utils/wait_concurrently.dart';

class BoxRepository {
  static final BoxRepository _boxRepository = BoxRepository._internal();

  factory BoxRepository() {
    return _boxRepository;
  }
  BoxRepository._internal();

  Future<List<Box>> getBoxes() async {
    final db = await DatabaseProvider().database;
    final (boxMaps, locations) = await waitConcurrently(
        db.query('boxes'), LocationRepository().getLocations());
    return boxMaps.map((map) {
      final location =
          locations.firstWhere((location) => location.id == map['location_id']);
      map['location'] = location;
      return Box.fromMap(map);
    }).toList();
  }

  Future<Box> getBox(int id) async {
    final db = await DatabaseProvider().database;
    final boxMaps = await db.query('boxes', where: 'id = ?', whereArgs: [id]);
    if (boxMaps.isEmpty) {
      return Box.empty();
    }
    final map = boxMaps.first;
    final location =
        await LocationRepository().getLocation(map['location_id'] as int);
    map['location'] = location;
    return Box.fromMap(map);
  }

  Future<void> insertBox(Box box) {
    final db = DatabaseProvider().database;
    return db.then((database) {
      database.insert('boxes', box.toMap());
    });
  }

  Future<void> updateBox(Box box) {
    final db = DatabaseProvider().database;
    return db.then((database) {
      database.update('boxes', box.toMap());
    });
  }

  Future<void> deleteBox(Box box) {
    final db = DatabaseProvider().database;
    return db.then((database) {
      database.delete('boxes', box.id);
    });
  }
}
