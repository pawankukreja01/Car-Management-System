import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:newprojecttesting/firebase_Services.dart';
import 'package:intl/intl.dart';
import 'package:newprojecttesting/buyerdetailsprovider.dart';
import 'package:newprojecttesting/productcard.dart';



class Productlist extends StatelessWidget {
  const Productlist({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();
    final _format= NumberFormat('##,##,##0');
    var provider= Provider.of<buyerdetailsProvider> (context);

    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: FutureBuilder<QuerySnapshot>(
          future: _service.buyerdetails.get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) {
            if (snapshot1.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot1.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.only(left: 140.0,right: 140),
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  backgroundColor: Colors.black,
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 56,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Fresh Recommendation",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                    )),
                GridView.builder
                  (
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.all(16) ,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2/2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 10
                    ),

                    itemCount: snapshot1.data?.size,
                    itemBuilder: (BuildContext context, int i){
                      var data = snapshot1.data?.docs[i] as QueryDocumentSnapshot<Object>;
                      String formattedPrice = data['price' ]; //convert to int becau var price =


                      return  productcard (data: data,formattedPrice: formattedPrice );

                    }),
              ],
            );
          },
        ),
      ),
    );
  }
}

