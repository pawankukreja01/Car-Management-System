import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:newprojecttesting/cat_provider.dart';

class ImagePickerwidget extends StatefulWidget {
  @override
  State<ImagePickerwidget> createState() => _ImagePickerwidgetState();
}

class _ImagePickerwidgetState extends State<ImagePickerwidget> {
  File ?_image;
  bool _uploading = false;

  final picker = ImagePicker();

  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(
      source: source,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  /* Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);


    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<CategoryProvider>(context);
    Future<String> uploadFile() async {
      File file = File(_image!.path);
      String imageName = 'productImage/${DateTime
          .now()
          .microsecondsSinceEpoch}';
      String downloadUrl='';
      try {
        await FirebaseStorage.instance
            .ref(imageName)
            .putFile(file);
        downloadUrl = await FirebaseStorage.instance
            .ref(imageName)
            .getDownloadURL();
        if (downloadUrl != null) {
          setState(() {
            _image != null;
            _provider.getImages(downloadUrl);
          });
        }
      } on FirebaseException catch (e) {
        // e.g, e.code == 'canceled'
        String error = e.code;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("cancelled"),
          ),
        );
      }
      return downloadUrl;
    }
    return Dialog(

      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [

          AppBar(

            elevation: 1,

            backgroundColor: Colors.white,

            iconTheme: IconThemeData(color: Colors.black),

            title: Text('Upload images', style: TextStyle(color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    if(_image != null)
                      Positioned(
                        right: 0,
                        child: IconButton(icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _image != null;
                            });
                          },
                        ),
                      ),
                    Container(
                      height: 120,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: FittedBox(
                        child: _image == null ? Icon(
                          CupertinoIcons.photo_on_rectangle
                          , color: Colors.grey,
                        ) : Image.file(_image!),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                if(_provider.urllist.length > 0)
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4)
                    ),
                    child: GalleryImage(
                      imageUrls: _provider.urllist,
                    ),
                  ),
                SizedBox(height: 20,),
                if(_image != null)
                  Row(
                    children: [
                      Expanded(
                        child: NeumorphicButton(
                          style: NeumorphicStyle(color: Colors.teal),
                          onPressed: () {
                            setState(() {
                              _uploading = true;
                              uploadFile().then((url) {
                                if (url != null) {
                                  setState(() {
                                    _uploading = false;
                                  });
                                }
                              });
                            });
                          },
                          child: Text('Upload', textAlign: TextAlign.center,),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: NeumorphicButton(
                          style: NeumorphicStyle(color: Colors.red),
                          onPressed: () {},
                          child: Text('Back', textAlign: TextAlign.center,),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20,),
                Row(
                  children: [

                    Expanded(

                      child: NeumorphicButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context, builder: ((builder) =>bottomsheet()));
                        },

                        style: NeumorphicStyle(color: Theme
                            .of(context)
                            .primaryColor),
                        child: Text(
                          _provider.urllist.length > 0
                              ? 'Upload more Images'
                              : 'Upload Images',
                          textAlign: TextAlign.center
                          , style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                if(_uploading)
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme
                        .of(context)
                        .primaryColor),
                  )

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 100.0,
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ), // EdgeInsets.symmetric
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ), // Text
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton.icon(
                  icon: Icon(Icons.camera),
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  label: Text("Camera"),
                ), // FlatButton.icon
                TextButton.icon(
                  icon: Icon(Icons.image),
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  label: Text("Gallery"),
                ), // FlatButton.icon
              ]) // <widget>[ // Row
        ], // <widget>[U
      ), // Column
    ); // Container
  }
}