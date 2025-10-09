import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:io';


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
      'nom': nom,
      'prix': prix,
      'description': description,
      'image': image,
    };
  }
}


class ArticleProvider extends ChangeNotifier{
    
    Future<List<Article>> _loadArticles() async {
    //Allows to fetch the data from the json and store them for later use.
    final String jsonString = await rootBundle.loadString('data/articles.json');
    final Map<String, dynamic> data = jsonDecode(jsonString);
    
    return (data['articles'] as List)
        .map((item) => Article.fromJson(item))
        .toList();
  }


  void add(Article article) async {
    final List<Article> articlesFuture =  await _loadArticles();
    final List<Article> updatedList = List<Article>.from(articlesFuture)..add(article);
    final jsonString = jsonEncode(updatedList);
    print("Json encoded"); 
    final file = File('data/test.json');
    print("File accessed");
    await file.writeAsString(jsonString);
    print("Json written");
  }

}