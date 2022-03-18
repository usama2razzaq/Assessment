class Products {
  // email_verified_at
  String name, description, imageUrl;
  int id, category_id;
  dynamic price;

  Products({
    required this.id,
    required this.category_id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'],
      category_id: json["category"],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'],
    );
  }
}
