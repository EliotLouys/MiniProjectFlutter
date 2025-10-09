import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';


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

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'nom': nom,
      'prix': prix,
      'description': description,
      'image': image,
    };
  }
}


class ArticleProvider extends ChangeNotifier{
    // List<Article> _allArticles = [];

    // List<Article> get articles => _allArticles;
    


    Future<List<Article>> loadArticles() async {
      //Allows to fetch the data from the json and store them for later use.
      final String jsonString = await rootBundle.loadString('data/articles.json');
      final Map<String, dynamic> jsonList = jsonDecode(jsonString);


      return (jsonList['articles'] as List)
          .map((item) => Article.fromJson(item))
          .toList();

      // print(jsonString);
      // print(data);

      // _allArticles = (data as List)
      //     .map((item) => Article.fromJson(item))
      //     .toList();
      // return _allArticles;
    }

}