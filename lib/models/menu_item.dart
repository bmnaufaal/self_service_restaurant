class MenuItem {
  final String name;
  final int price;
  final int? memberPrice;
  final String category;
  final String description;
  final String image;
  final int count;
  final String tag;

  MenuItem({
    required this.name,
    required this.price,
    this.memberPrice,
    required this.category,
    required this.description,
    required this.image,
    required this.count,
    required this.tag,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
        name: json['name'],
        price: json['price'],
        memberPrice: json['memberPrice'],
        category: json['category'],
        description: json['description'],
        image: json['image'],
        count: 0,
        tag: json['tag']);
  }

  @override
  String toString() {
    return 'MenuItem{name: $name, price: $price, memberPrice: $memberPrice, category: $category, description: $description, image: $image, count: $count, tag: $tag}';
  }

  MenuItem copyWith({int? count}) {
    return MenuItem(
      name: name,
      price: price,
      memberPrice: memberPrice,
      category: category,
      description: description,
      image: image,
      count: count ?? this.count,
      tag: tag,
    );
  }
}
