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

  @override
  String toString() {
    return 'Location{id: $id, name: $name, address: $address, city: $city, country: $country, description: $description, image: $image}';
  }
}
