

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../emailAuth_Service.dart';

class Emailauth extends StatefulWidget {
  const Emailauth({Key? key}) : super(key: key);

  @override
  _EmailauthState createState() => _EmailauthState();
}

class _EmailauthState extends State<Emailauth> {

  final _formkey = GlobalKey<FormState>();
  bool _validate = false;
  bool _login = false;
  bool _loading = false;
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  EmailAuthentication _service=EmailAuthentication();

  _validateEmail(){
    if(_formkey.currentState!.validate()){
      setState(() {
        _validate = false;
        _loading = true;
      });
      _service.getAdminCredential(email:_emailController.text, password:_passwordController.text, isLog:_login, context:context).then((value){
        setState(() {

          _loading = false;
        });
      });

    }
  }




  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.teal,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'login',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(
                  CupertinoIcons.person_alt_circle,
                  color: Colors.teal,
                  size: 60,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Enter to ${_login ? 'login':'Register'}',
                style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Enter Email and Password to ${_login ? 'login':'Register'}' ,
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _emailController,
                validator: (value){
                  final bool isValid = EmailValidator.validate(_emailController.text);
                  if(value == null || value.isEmpty){
                    return 'Enter email';
                  }
                  if(value.isNotEmpty && isValid == false){
                    return 'Enter valid email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.blueGrey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(

                obscureText: _isObscure,
                controller:_passwordController ,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  labelText: 'Password',

                  suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      }),


                  filled: true,
                  fillColor: Colors.blueGrey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onChanged: (value){
                  if(_emailController.text.isNotEmpty){
                    if(value.length>3){
                      setState(() {
                        _validate = true;
                      });
                    }
                    else {
                      setState(() {
                        _validate = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 10,),

                ],
              )
          ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: AbsorbPointer(
            absorbing: _validate ? false : true,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: _validate
                    ? MaterialStateProperty.all(Theme.of(context).primaryColor)
                    : MaterialStateProperty.all(Colors.teal),
              ),
              onPressed: (){
                _validateEmail();
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _loading ? SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ) : Text(
                  '${_login ? 'login':'Register'}' ,
                  style: TextStyle(
                    color: Colors.white,fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}
