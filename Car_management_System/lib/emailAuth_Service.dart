
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'Shop_Buyer.dart';

class EmailAuthentication{

CollectionReference users = FirebaseFirestore.instance.collection('users');
Future<DocumentSnapshot> getAdminCredential({email,password,isLog,context})async {
  DocumentSnapshot _result =await users.doc(email).get();
  if(isLog){
    //direct login
    emailLogin(email,password,context);
  }else {
    //if register
    if (_result.exists){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An account already exist with this email'),
          ),
      );
    }
    else{
      emailRegister(email,password,context);
    }
  }
  return _result;
}
emailLogin(email,password, context) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    if(credential.user?.uid!=null){
      Navigator.push(
        context,
       // MaterialPageRoute(builder: (context) => SHomeScreen()),
        MaterialPageRoute(builder: (context) => shop_buyer()),

      );

    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No user found for that email.'),
        ),
      );
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wrong password provided for that user..'),
        ),
      );
      print('Wrong password provided for that user.');
    }
  }

}
emailRegister(email,password,context) async {
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if(credential.user?.uid!=null){
      return users. doc (credential.user?.email).set({
        'uid' : credential.user?.uid,
        'mobile' : null,
        'email' : credential.user?.email
      }).then((value) {
        Navigator.push(
          context,
         // MaterialPageRoute(builder: (context) => SHomeScreen()),
          MaterialPageRoute(builder: (context) => shop_buyer()),
        );
      }).catchError((onError){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add user'),
          ),
        );

      });
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('The password provided is too weak.'),
        ),
      );
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('The account already exists for that email.'),
        ),
      );

      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error occured'),
      ),
    );
  }

}
}