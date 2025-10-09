import 'package:shop_it/articleform.dart';

import 'basketpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'article_card.dart';
import 'providers/article.dart';
import 'contactform.dart';

class ArticlesPage extends StatefulWidget {
  final List<Article>? articleList;
  // Page with all the articles displayed where we can add to a cart, see details and see the cart.
  const ArticlesPage({super.key, this.articleList });

  static Route<void> route(List<Article>? articleList) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: '/articles'),
      builder: (_) => ArticlesPage(articleList: articleList,),
    );
  }
  
  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  late Future<List<Article>> _articlesFuture;
  late List<Article>? _selectedArticles;

  Future<List<Article>> _loadArticles() async {
    //Allows to fetch the data from the json and store them for later use.
    final String jsonString = await rootBundle.loadString('data/articles.json');
    final Map<String, dynamic> data = jsonDecode(jsonString);
    
    return (data['articles'] as List)
        .map((item) => Article.fromJson(item))
        .toList();
  }


    bool _isExpanded = false;

    void _toggleFab() {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }


  @override
  void initState() {
    super.initState();
    //Call the json load
    _articlesFuture = _loadArticles();
    _selectedArticles = widget.articleList ?? [];
    
  }

  @override
  Widget build(BuildContext context)  {
    // Visualisation
    return Scaffold(
      appBar: AppBar(
        title: const Text("Articles à commander"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:
      FutureBuilder<List<Article>>(
        future: _articlesFuture,
        builder: (context, snapshot) {
          //Nice view of waiting for data/No data found etc..
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucun article trouvé."));
          }

          final articles = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              //Build an article card for each article fetched from the json.
              return ArticleCard(
                article: articles[index],
                onOrderPressed: () {
                  setState(() {
                    _selectedArticles?.add(articles[index]);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${articles[index].nom} ajouté au panier !"),duration:Duration(milliseconds: 500),),
                  );
                },
              );
            },
          );
        },
      ),
    
    // Floating button allowing access to the whole shopping list.
    floatingActionButton: _isExpanded? Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 10,
      children: [
        Stack(
        clipBehavior: Clip.none,
        children: [
          FloatingActionButton(
            onPressed:() async { 
              _toggleFab;
              final updatedList = await Navigator.push(
              context,
              BasketPage.route(_selectedArticles),
            ) as List<Article>?;

            if (updatedList != null) {
              setState(() {
                _selectedArticles = updatedList;
              });
            }
            }, 
            tooltip: 'See basket', 
            child: const Icon(Icons.shopping_cart),
             ),
            
          // Badge incremental
          Positioned(
            right: -4,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              child: Center(
                child: Text(
                  '${_selectedArticles?.length}', 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      FloatingActionButton.extended(
            onPressed:() {
                  _toggleFab;
                  Navigator.push(context, ContactForm.route());
                }, 
            tooltip: 'Add contact', 
            label:Text("Ajouter un contact") ,
            icon: const Icon(Icons.add),       
        ),
        FloatingActionButton.extended(
            onPressed:() {
              _toggleFab;
              Navigator.push(context,Articleform.route());
            }, 
            tooltip: 'Add article', 
            label:Text("Ajouter un article à la vente") ,
            icon: const Icon(Icons.add),       
        ),
      ],
    ):  FloatingActionButton(
              heroTag: "fabMain",
              onPressed: _toggleFab,
              child: const Icon(Icons.menu),
            ),
    
    
    );

  }
}
