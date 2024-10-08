import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:provider/provider.dart';
import 'ImagePickerwidget.dart';
import 'Shop_Buyer.dart';
import 'buyer_provider.dart';
import 'cat_provider.dart';
import 'firebase_Services.dart';

class BHomeScreen extends StatefulWidget {
  static const String id='SHomeScreen';
  const BHomeScreen({
    required this.title,
    required this.formattedPrice,
  });
  final String formattedPrice;
  final String title;
  @override
  State<BHomeScreen> createState() => _BHomeScreenState();
}

class _BHomeScreenState extends State<BHomeScreen> {

  var _phonenumberController = TextEditingController();

  var _addressController = TextEditingController();



  final _formkey = GlobalKey<FormState>();
  FirebaseService service = FirebaseService();
  /*void didChangeDependencies() {
    var _catProvider=Provider.of<CategoryProvider>(context);
    setState(() {
      _titleController.text =
      _catProvider.datasToFirestore.isEmpty ? null : _catProvider
          .datasToFirestore['title'];
      _priceController.text =
      _catProvider.datasToFirestore.isEmpty ? null : _catProvider
          .datasToFirestore['price'];
      _descriptionController.text =
      _catProvider.datasToFirestore.isEmpty ? null : _catProvider
          .datasToFirestore['description'];

    });
    super.didChangeDependencies();
  }*/



  Future<void> saveProductToDb(BuyerProvider provider,context) {

    return service.buyerdetails.doc()
        .set(
        provider.datasToFirestore)
        .then(
            (value)=>print("user Added")).catchError((error)=>print("failed to add user:$error"));

  }

  validate(BuyerProvider provider) {
    if (_formkey.currentState!.validate()) {
        //should have image
        provider.datasToFirestore.addAll({

          'Phonenumber': _phonenumberController.text,
          'address':_addressController.text,
          'Title':widget.title,
          'price':widget.formattedPrice



        }
        );
        saveProductToDb(provider, context);
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('please complete  the required fields'),
        ),
      );
    }
  }

  @override
  void initstate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<BuyerProvider>(context);
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                 child: TextFormField(
                    controller: _phonenumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Phone number',
                        prefixText: 'Tel',
                        helperText: 'Mention your contact details (e.g 03333333333)'
                    ),
                  ),
                ),

                TextFormField(
                  controller: _addressController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Address',
                      helperText: 'Mention the flat number,area'
                  ),
                ),
                Divider(color: Colors.grey,),


                SizedBox(height: 10,),
//show this only if images available.

              ],
            ),
          ),

        ),
      ),

      bottomSheet: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: NeumorphicButton(
                style: NeumorphicStyle(color: Theme
                    .of(context)
                    .primaryColor),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Save',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold), // Te
                  ),
                ),
                onPressed: () {
                  validate(_provider);
                  Navigator.push(
                    context,
                    // MaterialPageRoute(builder: (context) => SHomeScreen()),
                    MaterialPageRoute(builder: (context) => shop_buyer()),

                  );
                },
              ),),
          ),
        ],
      ),












    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
      title: Text('Add details', style: TextStyle(color: Colors.white),
      ),
      shape: Border(bottom: BorderSide(color: Colors.grey.shade300)
      ),


    );
  }
}
