import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_details.dart';
import 'buyerdetailsprovider.dart';

import 'firebase_Services.dart';

class productcard extends StatefulWidget {
  const productcard({
    required this.data,
    required this.formattedPrice,
  });

  final QueryDocumentSnapshot<Object> data;
  final String formattedPrice;

  @override
  State<productcard> createState() => _productcardState();
}

class _productcardState extends State<productcard> {
  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();
    var provider= Provider.of<buyerdetailsProvider> (context);
    return InkWell(
      onTap: (){


       provider.getProductDetails(widget.data);
       Navigator.push (context,
           MaterialPageRoute(builder: (context) => ProductDetailsScreen()),
           );

      },
      child: Container(


        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.formattedPrice,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
              Text(widget.data["Title"],style: TextStyle(color: Colors.black),maxLines: 1,overflow: TextOverflow.ellipsis,)
            ],
          ),
        ),
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.8),),
            borderRadius: BorderRadius.circular(4)

        ),
      ),
    );
  }
}