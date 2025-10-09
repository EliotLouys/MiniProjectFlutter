import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Articleform extends StatefulWidget {
  // Page with all the articles displayed where we can add to a cart, see details and see the cart.
  const Articleform({super.key});

  static Route<bool> route() {
    return MaterialPageRoute<bool>(
      settings: const RouteSettings(name: '/articlesForm'),
      builder: (_) => Articleform(),
    );
  }
  
  @override
  State<Articleform> createState() => _ArticleFormstate();
}

class _ArticleFormstate extends State<Articleform>{

    final TextEditingController _nameField = TextEditingController();
    final TextEditingController _priceField = TextEditingController();
    final TextEditingController _descriptionField = TextEditingController();

    File? _image;
    final ImagePicker _picker = ImagePicker();
    Future<void> _pickImage(ImageSource source) async {
      final XFile? pickedFile = await _picker.pickImage(source: source,maxWidth: 500,imageQuality: 50);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    }
    bool _cgvField = false;




    @override
    Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
                title: const Text("Ajouter des articles"),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
        body: 
        SingleChildScrollView(
        child:
          Column(
            children: [
              TextField(
                controller: _nameField,
                decoration: const InputDecoration(labelText: "Nom de l'article"),
                keyboardType: TextInputType.name,
                
              ),
              TextField(
                controller: _priceField,
                decoration: const InputDecoration(labelText: "Prix de l'article"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _descriptionField,
                decoration: const InputDecoration(labelText: "Description de l'article"),
                keyboardType: TextInputType.emailAddress,
                maxLines: 8,
              ),
              CheckboxListTile(
                value: _cgvField,
                title: Text("J'accepte les CGV"),
                onChanged: (bool? value) {
                  setState(() {
                    _cgvField = value!;
                  });
                }
              
              ),
              Center(
                child: _image == null
                    ? Text('No image selected.')
                    : Image.file(_image!),
              ),
              FloatingActionButton(
                onPressed: () async {
                  final ImageSource? source = await showDialog<ImageSource>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Select Image Source'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, ImageSource.camera),
                            child: Text('Camera'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, ImageSource.gallery),
                            child: Text('Gallery'),
                          ),
                        ],
                      );
                    },
                  );
                  if (source != null) {
                    _pickImage(source);
                  }
                },
                child: Icon(Icons.add_a_photo),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_nameField.text.trim().isNotEmpty &&  _priceField.text.trim().isNotEmpty && _descriptionField.text.trim().isNotEmpty && _cgvField){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Well done"),duration:Duration(milliseconds: 1000),),
                      );
                    
                    
                    _nameField.clear();
                    _priceField.clear();
                    _descriptionField.clear();
                    setState(() {
                    _cgvField=false;
                    _image=null;

                    });

                  Navigator.pop(context, true);

                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Enter something"),duration:Duration(milliseconds: 500),),
                      );
                  }
                },
                child: const Icon(Icons.arrow_forward)
              ), 
            ],
      ),


    ),
    );
  }


}