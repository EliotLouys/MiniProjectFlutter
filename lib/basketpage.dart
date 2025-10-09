import 'package:flutter/material.dart';
import 'providers/article.dart';
import 'dart:io';


class BasketPage extends StatefulWidget{
  final List<Article>? selectedArticles;

  const BasketPage({super.key, required this.selectedArticles});

  static Route<void> route(List<Article>? articleList) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: '/cart'),
      builder: (_) => BasketPage(selectedArticles: articleList),
    );
  }

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage>{

  late List<Article> selectedArticles;

  //Calculate total basket price
  double get totalPrice =>
    selectedArticles.fold(0.0, (sum, item) => sum + item.prix);



  @override
  void initState() {
    // Get data from arguments in constructur
    super.initState();
    selectedArticles = widget.selectedArticles ?? [];
  }


  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Basket"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, selectedArticles);

          },
        ),
      ),
      body:
      Column(
        children: [
          Expanded(
            child: ListView.builder(
              // Build a row for each article added to cart
              itemCount: selectedArticles.length,
              itemBuilder: (context, index) {
                final fileNameStart = selectedArticles[index].image.substring(0,11); // path stored in Article.image

                final article = selectedArticles[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Row(
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child : fileNameStart == 'data/images'
                            ? Image.asset(
                                article.image,
                                height: 180,
                                width: 600,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(article.image),
                                height: 180,
                                width: 600,
                                fit: BoxFit.cover,
                              ),

                          )
                        ),
                      const SizedBox(width: 12),
                      // Name
                      Expanded(
                        child: Text(
                          article.nom,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      // Price
                      Text(
                        "${article.prix} €",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      // Delete button
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          setState(() {
                            selectedArticles.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Fixed container at the bottom of the screen to show total price.
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${totalPrice.toStringAsFixed(2)} €",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
      ],
    ),
    );
  }
}
