import 'box.dart';

class Item {
  final int? id;
  final String name;
  final String description;
  final Box? box;
  final String? image;

  const Item({
    this.id,
    required this.name,
    required this.description,
    this.box,
    this.image,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'box_id': box?.id,
      'image': image ?? '',
    };
  }

  Item.fromMap(Map<String, Object?> map)
      : id = map['id'] as int,
        name = map['name'] as String,
        description = map['description'] as String,
        box = map.containsKey('box') ? map['box'] as Box : null,
        image = map['image'] as String?;

  @override
  String toString() {
    return 'Item{id: $id, name: $name, description: $description, box: $box, image: $image}';
  }
}
