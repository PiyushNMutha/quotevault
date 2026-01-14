class Category {
  final String name;

  Category({required this.name});

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(name: map['category']);
  }
}
