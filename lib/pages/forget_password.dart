import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:samedayrushprint/pages/login_signup_page.dart';


class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPage createState() => _ForgetPasswordPage();
}

class _ForgetPasswordPage extends State<ForgetPasswordPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (input) {
                  if(input.isEmpty){
                    return 'Provide an email';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Email'
                ),
                onSaved: (input) => _email = input,
              ),
              RaisedButton(
                onPressed: forgotPassword,
                child: Text('Forgot Password'),
              ),
            ],
          )
      ),
    );
  }

  void forgotPassword() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginSignupPage()));
      }catch(e){
        print(e.message);
      }
    }
  }
}