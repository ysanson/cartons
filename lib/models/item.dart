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

  @override
  String toString() {
    return 'Item{id: $id, name: $name, description: $description, box: $box, image: $image}';
  }

}
