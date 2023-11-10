class Pokemon {
  final String name;

  Pokemon({
    required this.name,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
    );
  }
}
