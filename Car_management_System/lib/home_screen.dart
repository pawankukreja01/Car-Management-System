import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:provider/provider.dart';
import 'ImagePickerwidget.dart';
import 'Shop_Buyer.dart';
import 'cat_provider.dart';
import 'firebase_Services.dart';

class SHomeScreen extends StatefulWidget {
  static const String id='SHomeScreen';
  @override
  State<SHomeScreen> createState() => _SHomeScreenState();
}

class _SHomeScreenState extends State<SHomeScreen> {
  var _titleController = TextEditingController();
  var _priceController = TextEditingController();

  var _descriptionController = TextEditingController();
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



  Future<void> saveProductToDb(CategoryProvider provider,context) {

    return service.products.doc()
        .set(
        provider.datasToFirestore)
        .then(
            (value)=>print("user Added")).catchError((error)=>print("failed to add user:$error"));

  }

  validate(CategoryProvider provider) {
    if (_formkey.currentState!.validate()) {
      if (provider.urllist.isNotEmpty) {
        //should have image
        provider.datasToFirestore.addAll({
          'Title': _titleController.text,
          'Description': _descriptionController.text,
          'Price': _priceController.text,
          'address':_addressController,
          'Images': provider.urllist
        }
        );
        saveProductToDb(provider, context);
      }
      else {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('image not uploaded'),
          ),
        ); //

      }
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
    var _provider = Provider.of<CategoryProvider>(context);
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
                    controller: _titleController,
                    decoration: InputDecoration(
                        labelText: 'Title',
                        helperText: 'Mention the name (e.g Car name)'

                    ),
                  ),
                ),
                TextFormField(
                  controller: _descriptionController,
                  maxLength: 4000,
                  minLines: 1,
                  maxLines: 10,
                  decoration: InputDecoration(
                      labelText: 'Description',
                      helperText: 'Mention the key features and contact (e.g model, color, year, mobile number )',


                  ),
                ),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Price',
                      prefixText: 'Rs',
                      helperText: 'Mention the selling price (e.g 3000000, 4000000)'
                  ),
                ),
                TextFormField(
                  controller: _addressController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'address',
                      helperText: 'Mention the flat number,area'
                  ),
                ),
                Divider(color: Colors.grey,),

                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4)
                  ),
                  child:_provider.urllist.length==0?Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('No image selected',textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),
                  ): GalleryImage(
                    imageUrls: _provider.urllist,
                  ),
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context, builder: (BuildContext context) {
                      return ImagePickerwidget();
                    });
                  },

                  child: Neumorphic(
                    child: Container(
                      color: Colors.black,
                      height: 40,
                      child: Center(child: Text(_provider.urllist.length > 0
                          ? 'Upload more Images'
                          : 'Upload Images',style: TextStyle(color: Colors.white)),),
                    ), // Container
                  ),
                ),

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
                  _provider.urllist.length=0;
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
      title: Text('Sell product', style: TextStyle(color: Colors.white),
      ),
      shape: Border(bottom: BorderSide(color: Colors.grey.shade300)
      ),


    );
  }
}
