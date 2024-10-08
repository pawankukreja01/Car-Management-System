import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newprojecttesting/authentication/emailauth.dart';
import 'package:newprojecttesting/buyer_provider.dart';
import 'package:newprojecttesting/buyerdetailsprovider.dart';
import 'package:provider/provider.dart';
import 'cat_provider.dart';


void main() async {
  Provider.debugCheckInvalidValueType=null;


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //runApp(MyApp());
  runApp(

    MultiProvider(
        providers:[
          Provider(create:(_)=>buyerdetailsProvider()),
          Provider(create:(_)=>BuyerProvider()),

        ],
        child:MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Dialog dialogs =new Dialog();

  @override
  Widget build(BuildContext context) {
    return Provider<CategoryProvider>(
        create: (_)=>CategoryProvider(),



        child: MaterialApp(

            debugShowCheckedModeBanner: false,
            initialRoute: 'splash',

            theme: ThemeData(
              scaffoldBackgroundColor: Color(0xFFF9F8FD),
              primaryColor: Colors.black,
              textTheme: Theme.of(context).textTheme.apply(bodyColor:Color(0xFF3C4046) ),
              visualDensity: VisualDensity.adaptivePlatformDensity,

            ),
            routes: {
              'splash':(context)=>Emailauth(),






            }
        )

    );
  }
}

