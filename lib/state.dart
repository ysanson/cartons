import 'dart:collection';

import 'package:cartons/models/item.dart';
import 'package:cartons/repositories/item_repository.dart';
import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  /// An unmodifiable view of the items
  Future<UnmodifiableListView<Item>> get items async =>
      UnmodifiableListView(await ItemRepository().getItems());

  /// An unmodifiable view of the unsorted items
  Future<UnmodifiableListView<Item>> get unsortedItems async =>
      UnmodifiableListView(await ItemRepository().getUnsortedItems());

  Future<void> addItem(Item item) async {
    await ItemRepository().insertItem(item);
    notifyListeners();
  }

  Future<void> updateItem(Item item) async {
    await ItemRepository().updateItem(item);
    notifyListeners();
  }

  Future<void> deleteItem(Item item) async {
    await ItemRepository().deleteItem(item);
    notifyListeners();
  }
}
