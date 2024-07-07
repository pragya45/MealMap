class Restaurant {
  final String id;
  final String name;
  final String description;
  final String image;
  final double rating;
  final String place;
  final bool isFeatured;
  final List<String> popularItems;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.rating,
    required this.place,
    required this.isFeatured,
    required this.popularItems,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      rating: json['rating'].toDouble(),
      place: json['place'],
      isFeatured: json['isFeatured'],
      popularItems: List<String>.from(json['popularItems'] ?? []),
    );
  }
}

class Review {
  final String id;
  final String review;
  final double rating;

  Review({
    required this.id,
    required this.review,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      review: json['review'],
      rating: json['rating'].toDouble(),
    );
  }
}

class MenuItem {
  final String id;
  final String name;
  final double price;
  final String image;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['_id'],
      name: json['name'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }
}
