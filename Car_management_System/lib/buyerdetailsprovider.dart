import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
class buyerdetailsProvider with ChangeNotifier {
  late DocumentSnapshot productData;

  getProductDetails(details) {
    this.productData = details;
    notifyListeners();
  }

}
