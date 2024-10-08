import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class BuyerProvider with ChangeNotifier{

  late DocumentSnapshot doc;
  late String selectedCategory;
  List<String> urllist =[];
  Map<String, dynamic> datasToFirestore = {};


  getCategory(selectedCat){
    this.selectedCategory = selectedCat;
    notifyListeners();
  }
  getcatsnapshot (snapshot){
    this.doc =snapshot;
    notifyListeners();
  }
  getImages(url){
    this.urllist.add(url);
    notifyListeners();

  }
  getdata(data){
    this.datasToFirestore=data;
    notifyListeners();

  }
}