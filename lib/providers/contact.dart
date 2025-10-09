


import 'package:flutter/material.dart';

class Contact {
  String nom;
  String prenom;
  String mailAdress;
  String tel;
  bool acceptCGV;

  Contact({required this.nom,required this.prenom, required this.mailAdress, required this.tel, required this.acceptCGV});
}


class ContactProvider extends ChangeNotifier{ 
  final List<Contact> _contactList =[
    Contact(nom: 'Louys', prenom: 'Eliot', mailAdress: 'Eliot.Louys@mock.com',tel: '0147200001',acceptCGV: true)
  ] ;

    List<Contact> get contacts => _contactList;


  void add(String nom, String prenom, String mailAdress, String tel, bool acceptCGV){
    _contactList.add(Contact(nom: nom,prenom: prenom,mailAdress: mailAdress,tel: tel,acceptCGV: acceptCGV));
    notifyListeners(); 

  }

}