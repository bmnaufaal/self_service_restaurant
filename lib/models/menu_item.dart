class MenuItem {
  final String name;
  final int price;
  final String category;
  final String description;
  final String image;

  MenuItem({
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['name'],
      price: json['price'],
      category: json['category'],
      description: json['description'],
      image: json['image'],
    );
  }
}
