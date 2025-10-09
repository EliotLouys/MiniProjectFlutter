import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

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
    
    Future<List<Article>> _loadArticles() async {
    //Allows to fetch the data from the json and store them for later use.
    final String jsonString = await rootBundle.loadString('data/articles.json');
    final Map<String, dynamic> data = jsonDecode(jsonString);

    return (data['articles'] as List)
        .map((item) => Article.fromJson(item))
        .toList();
  }


  void add(Article article, File? img) async {
    final List<Article> articlesFuture =  await _loadArticles();

    // Ensure images folder exists
    final dir = await getApplicationDocumentsDirectory();

    final imagesDir = Directory(p.join(dir.path, 'images'));
    if (!imagesDir.existsSync()) {
      await imagesDir.create(recursive: true);
    }

    // Copy the image into the folder
    final String newImageName = Uuid().v4();
    final String newImagePath = p.join(imagesDir.path, newImageName);
    print(newImagePath);
    await img?.copy(newImagePath);


    

    final newArticle = Article(
      id: article.id,
      nom: article.nom,
      prix: article.prix,
      description: article.description,
      image: newImagePath,
    );

    final List<Article> updatedList = List<Article>.from(articlesFuture)..add(newArticle);
    final jsonString = jsonEncode(updatedList);

    print("Json encoded"); 
    final file = File('data/test.json');
    print("File accessed");
    await file.writeAsString(jsonString);
    print("Json written");



  }

}