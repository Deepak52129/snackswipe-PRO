
class Restaurant {
  final String id;
  final String name;
  final String cuisine;
  final List<String> tags;
  final double price;
  final int spiceLevel;
  final int rating;

  double popularity;
  bool unlocked;

  Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.tags,
    required this.price,
    required this.spiceLevel,
    required this.rating,
    this.popularity = 50,
    this.unlocked = false,
  });
}
