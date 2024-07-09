class Restaurant {
  final String id;
  final String name;
  final String category;
  final String description;
  final double rating;
  final bool isFeatured;
  final String image;
  final String place;

  Restaurant({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.rating,
    required this.isFeatured,
    required this.image,
    required this.place,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['_id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      rating: json['rating'].toDouble(),
      isFeatured: json['isFeatured'],
      image: json['image'],
      place: json['place'],
    );
  }
}
