import 'package:flutter/material.dart';

import 'article.dart';


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
  return Scaffold(
    appBar: AppBar(title: Text(currentArticle.nom)),
    body: Column(
      children: [
        Image.asset(currentArticle.image),
        Column(mainAxisAlignment: MainAxisAlignment.center,
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