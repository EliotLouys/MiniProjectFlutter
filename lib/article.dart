class Article {
  //Data model for an article
  final int id;
  final String nom;
  final double prix;
  final String description;
  final String image;

  Article({
    required this.id,
    required this.nom,
    required this.prix,
    required this.description,
    required this.image,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as int,
      nom: json['nom'] as String,
      prix: (json['prix'] as num).toDouble(),
      description: json['description'] as String,
      image: json['image'] as String,
    );
  }
}
