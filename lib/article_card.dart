import 'articlesdetails.dart';
import 'package:flutter/material.dart';
import 'article.dart';

class ArticleCard extends StatelessWidget {
  // Widget class for an article card in the article lists.

  final Article article;
  final VoidCallback? onOrderPressed;

  const ArticleCard({super.key, required this.article, this.onOrderPressed});

  @override
  Widget build(BuildContext context) {
    // InkWell to make the card clickable to go to the details
    return InkWell(
      onTap: () { Navigator.push(context, ArticlesDetails.route(article));} ,
      borderRadius:BorderRadius.circular(16) ,
      child:  Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
     
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              article.image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(article.nom, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 6),
                Text(article.description, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${article.prix} €",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                    ),
                    FilledButton(
                      onPressed: onOrderPressed ?? () {},
                      child: const Text("Commander"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
    
    
  }
}