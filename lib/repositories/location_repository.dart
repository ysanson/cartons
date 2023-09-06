import 'package:cartons/models/location.dart';

import '../data/database_provider.dart';

class LocationRepository {
  static final LocationRepository _locationRepository =
      LocationRepository._internal();

  factory LocationRepository() {
    return _locationRepository;
  }
  LocationRepository._internal();

  Future<List<Location>> getLocations() async {
    final db = await DatabaseProvider().database;
    final maps = await db.query('locations');
    return maps.map((map) => Location.fromMap(map)).toList();
  }

  Future<Location> getLocation(int id) async {
    final db = await DatabaseProvider().database;
    final maps = await db.query('locations', where: 'id = ?', whereArgs: [id]);
    return maps.map((map) => Location.fromMap(map)).first;
  }

  Future<void> insertLocation(Location location) {
    final db = DatabaseProvider().database;
    return db.then((database) {
      database.insert('locations', location.toMap());
    });
  }

  Future<void> updateLocation(Location location) {
    final db = DatabaseProvider().database;
    return db.then((database) {
      database.update('locations', location.toMap());
    });
  }

  Future<void> deleteLocation(Location location) {
    final db = DatabaseProvider().database;
    return db.then((database) {
      database.delete('locations', location.id);
    });
  }
}
