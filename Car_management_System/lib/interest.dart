import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class interest extends StatefulWidget{
  @override
  State<interest> createState() => _interestState();
}

class _interestState extends State<interest> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar:AppBar(title:Text("Demo"),),
    body:Column(
      children:<Widget>[

        _button('Cup'),
        _button('Glass'),
        _button('Bottle'),
      ],//<widget>[][
    ),// Column

  );
  }
  Widget _button(event)=>TextButton( child: Text(event),onPressed: ()async{
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot doc = await users.doc(user?.uid).get() ;
    List interests = (doc.data()as dynamic)['interest'];

    if(interests.contains(event)==true){
      users.doc(user?.uid).update({
        'interest':FieldValue.arrayRemove([event])
      });
    }
    else{
      users.doc(user?.uid).update({
        'interest':FieldValue.arrayUnion([event])
      });
    }

  },);
}