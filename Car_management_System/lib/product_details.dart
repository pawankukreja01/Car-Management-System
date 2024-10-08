import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'buyer_details_home_screen.dart';
import 'buyerdetailsprovider.dart';
class ProductDetailsScreen extends StatefulWidget {
  static const String id='product-details-screen';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _loading = true;
  int _index=0;
  final format =NumberFormat("##,##,##0");
  String textTitle = 'Mark as delivered';
  bool isChanged=true;

  @override
  void initState() {
    Timer(Duration (seconds: 2),(){
      setState(() {
        _loading = false;

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var provider= Provider.of<buyerdetailsProvider> (context);
    var data = provider.productData;
    String formattedPrice = (data['price' ]); //convert to int becau var price =


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _loading ? Container() : Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30,),
                          Row(
                            children: [
                              Text(data['Title'].toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black))
                            ],
                          ),
                          SizedBox(height: 30,),
                          Row(
                            children: [
                              Text(data['Phonenumber'].toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black))
                            ],
                          ),

                          SizedBox(height: 30,),
                          Text(formattedPrice,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                          SizedBox(height: 30,),
                          Text('Address',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
              SizedBox (height: 10,),
              Row(
                children: [
                  Container(
                  color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column (
                        children: [
                          Text(data['address'],style:TextStyle(fontWeight: FontWeight.bold,color: Colors.black) ,)

                        ],
                      ),
                    ),
                  ),
                ],
              ),

                        ],
                      ),
                  ),

                  ],
              ),
            ),
        ),
      bottomSheet: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: NeumorphicButton(
                style: NeumorphicStyle(color: Colors.teal),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    textTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold), // Te
                  ),
                ),
                onPressed: () {
                  isChanged = !isChanged;
                  setState(() {
                    isChanged == true ? textTitle = "Mark as delivered" : textTitle = "Already delivered";
                  });



                },
              ),),
          ),
        ],
      ),

    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.teal,
      elevation:0.0,
      title: Text('Delivery Details',style: TextStyle(color: Colors.white),
      ),
      iconTheme: IconThemeData(color: Colors.white),

    );

  }
}