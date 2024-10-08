import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference products = FirebaseFirestore.instance.collection(
      'products');
  CollectionReference buyerdetails = FirebaseFirestore.instance.collection(
      'buyerdetails');


  Future<DocumentSnapshot> getuserdata() async {
    DocumentSnapshot doc = await users.doc(user?.uid).get();


    return doc;



  }
}
