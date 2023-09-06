class Location {
  final int id;
  final String name;
  final String address;
  final String city;
  final String country;
  final String? description;
  final String? image;

  const Location({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.country,
    this.description,
    this.image,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'city': city,
      'country': country,
      'description': description,
      'image': image,
    };
  }

  Location.fromMap(Map<String, Object?> map)
      : id = map['id'] as int,
        name = map['name'] as String,
        address = map['address'] as String,
        city = map['city'] as String,
        country = map['country'] as String,
        description = map['description'] as String?,
        image = map['image'] as String?;

  @override
  String toString() {
    return 'Location{id: $id, name: $name, address: $address, city: $city, country: $country, description: $description, image: $image}';
  }
}
