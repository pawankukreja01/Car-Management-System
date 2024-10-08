import 'package:flutter/material.dart';
import 'package:newprojecttesting/assets.dart';

import 'AuthUi.dart';


class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(child: Container(
              width: MediaQuery.of(context).size.width,
              color:Colors.black,
              child: Column(
                children: [

                  SizedBox(
                    height: 50,
                  ),
                  Image.asset(Assets.imageavatar11),
                  SizedBox(height: 15,),
                  Text('Car Management System',style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                  ),
                  )
                ],
              ),
            ),
            ),
            Expanded(child: Container(
              child: AuthUi(),
            ),
            ),
          ],
        )

    );
  }
}
