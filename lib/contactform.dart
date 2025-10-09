import 'package:flutter/material.dart';
import 'package:shop_it/providers/contact.dart';


class ContactForm extends StatefulWidget {
  // Page with all the articles displayed where we can add to a cart, see details and see the cart.
  const ContactForm({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: '/contactForm'),
      builder: (_) => ContactForm(),
    );
  }
  
  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm>{

    final TextEditingController _nameField = TextEditingController();
    final TextEditingController _prenomField = TextEditingController();
    final TextEditingController _mailField = TextEditingController();
    final TextEditingController _telField = TextEditingController();

    bool _cgvField = false;



    ContactProvider provider = ContactProvider();

    @override
    Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
                title: const Text("Ajouter des contacts"),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
        body: Column(
          children: [
            TextField(
              controller: _nameField,
              decoration: const InputDecoration(labelText: "Nom"),
              keyboardType: TextInputType.name,
              
            ),
            TextField(
              controller: _prenomField,
              decoration: const InputDecoration(labelText: "Prenom"),
              keyboardType: TextInputType.name,
            ),
            TextField(
              controller: _mailField,
              decoration: const InputDecoration(labelText: "Mail"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _telField,
              decoration: const InputDecoration(labelText: "Tel"),
              keyboardType: TextInputType.phone,
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
            ElevatedButton(
              onPressed: (){
                if (_nameField.text.trim().isNotEmpty &&  _prenomField.text.trim().isNotEmpty && _mailField.text.trim().isNotEmpty && _cgvField){
                  setState(() {
                    provider.add(_nameField.text,_prenomField.text, _mailField.text,_telField.text,_cgvField);
                  });
                  _nameField.clear();
                  _prenomField.clear();
                  _mailField.clear();
                  _telField.clear();
                  _cgvField=false;
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Enter something"),duration:Duration(milliseconds: 500),),
                    );
                }
              },
              child: const Icon(Icons.arrow_forward)
            ),
            Text("Liste de contacts actuels : "),
            Expanded( 
                  child: 
                  ListView.builder(
                  itemCount: provider.contacts.length,
                  itemBuilder: (context, index) {
                    final contact = provider.contacts[index];
                    return ListTile(
                      title: Text("${contact.prenom} ${contact.nom}"),
                      subtitle: Text("${contact.mailAdress} ${contact.tel}"),
                    );
                    },
                  ),       
                )  
          ],
      ),


    );
  }


}