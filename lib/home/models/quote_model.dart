class Quote {
  final String id;
  final String text;
  final String author;
  final String category;

  Quote({
    required this.id,
    required this.text,
    required this.author,
    required this.category,
  });

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      id: map['id'],
      text: map['text'],
      author: map['author'] ?? 'Unknown',
      category: map['category'],
    );
  }
}
