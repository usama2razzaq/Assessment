class Categories {
  // email_verified_at
  String name, imageUrl;
  int id, category;

  Categories({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      imageUrl: json['imageUrl'],
    );
  }
}
