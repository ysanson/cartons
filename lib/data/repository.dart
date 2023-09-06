abstract class Repository {
  Future<void> init();
  Future<void> close();
  Future<List<Map<String, Object?>>> query(
    String table, {
    String? where,
    List<Object?>? whereArgs,
    int? limit,
  });
  Future<void> insert(String table, Map<String, Object?> data);
  Future<void> update(String table, Map<String, Object?> data);
  Future<void> delete(String table, int id);
}
