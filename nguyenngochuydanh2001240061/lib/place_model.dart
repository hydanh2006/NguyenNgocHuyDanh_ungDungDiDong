class Place {
  final int? id;
  final String name;
  final double rating;
  final String phone;
  final String address;
  final String image;

  Place({
    this.id,
    required this.name,
    required this.rating,
    required this.phone,
    required this.address,
    this.image = '1.jpg',
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'rating': rating,
      'phone': phone,
      'address': address,
      'image': image,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'] as int?,
      name: map['name'] as String? ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      phone: map['phone'] as String? ?? '',
      address: map['address'] as String? ?? '',
      image: map['image'] as String? ?? '1.jpg',
    );
  }
}
