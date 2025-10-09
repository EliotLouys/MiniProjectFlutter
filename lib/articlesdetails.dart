import 'package:flutter/material.dart';
import 'dart:io';
import 'providers/article.dart';


class ArticlesDetails extends StatelessWidget{
  // Simple visualisation class for an article
  final Article currentArticle;

  const ArticlesDetails({super.key, required this.currentArticle});

  static Route<void> route(Article currentArticle) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: '/details'),
      builder: (_) => ArticlesDetails(currentArticle: currentArticle),
    );
  }


  @override 
  Widget build(BuildContext context){
  final fileNameStart = currentArticle.image.substring(0,11); // path stored in Article.image

  return Scaffold(

    appBar: AppBar(title: Text(currentArticle.nom)),
    body: Column(
      children: [
        ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: fileNameStart == 'data/images'
                ? Image.asset(
                    currentArticle.image,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    File(currentArticle.image),
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
        Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Text(currentArticle.description),
          Text("${currentArticle.prix} €"),
          ]
        ),
        
      ],
    ),
  );
  }
}