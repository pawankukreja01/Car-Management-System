import 'package:flutter/material.dart';
import 'package:newprojecttesting/authentication/emailauth.dart';


class AuthUi extends StatelessWidget {
  const AuthUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              width: 220 ,height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white  )
                ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Emailauth()),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.email_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(width: 8,),
                    Text('LOGIN / REGISTER ',style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.black),)
                  ],
                ),
              )
          ),
          SizedBox(height: 30),
          /*SizedBox(
              width: 220 ,height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white  )
                ),
                onPressed: (){
                  //Navigator.pushNamed(context, email.id);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.email_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(width: 8,height: 30,),
                    Text('Sign Up',style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.black),)
                  ],
                ),
              )
          ),*/
        ],
      ),
    );
  }
}
