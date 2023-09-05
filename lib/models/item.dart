import 'box.dart';

class Item {
  final int id;
  final String name;
  final String description;
  final Box box;
  final String? image;

  const Item({
    required this.id,
    required this.name,
    required this.description,
    required this.box,
    this.image,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'box_id': box.id,
      'image': image,
    };
  }

  Item.fromMap(Map<String, Object?> map)
      : id = map['id'] as int,
        name = map['name'] as String,
        description = map['description'] as String,
        box = map['box'] as Box,
        image = map['image'] as String?;

  @override
  String toString() {
    return 'Item{id: $id, name: $name, description: $description, box: $box, image: $image}';
  }
}
