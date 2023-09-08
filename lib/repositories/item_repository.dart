import 'package:cartons/data/database_provider.dart';
import 'package:cartons/models/box.dart';
import 'package:cartons/repositories/box_repository.dart';
import 'package:cartons/models/item.dart';
import 'package:cartons/utils/wait_concurrently.dart';

class ItemRepository {
  static final ItemRepository _itemRepository = ItemRepository._internal();

  factory ItemRepository() {
    return _itemRepository;
  }
  ItemRepository._internal();

  Future<List<Item>> getItems() async {
    final db = await DatabaseProvider().database;
    final (items, boxes) =
        await waitConcurrently(db.query('items'), BoxRepository().getBoxes());
    return items.map((map) {
      final box = boxes.firstWhere((bx) => bx.id == map['box_id'],
          orElse: () => Box.empty());
      if (box.id != 0) {
        map['box'] = box;
      }
      return Item.fromMap(map);
    }).toList();
  }

  Future<Item> getItem(int id) async {
    final db = await DatabaseProvider().database;
    final itemMaps = await db.query('items', where: 'id = ?', whereArgs: [id]);
    final map = itemMaps.first;
    final box = await BoxRepository().getBox(map['box_id'] as int);
    if (box.id != 0) {
      map['box'] = box;
    }
    return Item.fromMap(map);
  }

  Future<List<Item>> getUnsortedItems() async {
    final db = await DatabaseProvider().database;
    final itemMaps = await db.query('items', where: "box_id = ''");
    return itemMaps.map((map) => Item.fromMap(map)).toList();
  }

  Future<void> insertItem(Item item) {
    final db = DatabaseProvider().database;
    return db.then((database) {
      database.insert('items', item.toMap());
    });
  }

  Future<void> updateItem(Item item) {
    final db = DatabaseProvider().database;
    return db.then((database) {
      database.update('items', item.toMap());
    });
  }

  Future<void> deleteItem(Item item) {
    final db = DatabaseProvider().database;
    return db.then((database) {
      database.delete('items', item.id);
    });
  }
}
