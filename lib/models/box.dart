import 'location.dart';
import 'box_types.dart';

class Box {
  final int id;
  final String name;
  final String code;
  final Location location;
  final BoxTypes type;
  final String? description;

  const Box({
    required this.id,
    required this.name,
    required this.code,
    required this.location,
    required this.type,
    this.description,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'location_id': location.id,
      'type_id': type.index,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'Box{id: $id, name: $name, code: $code, location: $location, type: $type, description: $description}';
  }
}
