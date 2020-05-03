import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:samedayrushprint/pages/login_signup_page.dart';

import 'sign_in.dart';

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
      appBar: new AppBar(
        leading: new Image.asset('images/logo.png'),
        backgroundColor: Colors.white,
        title: Text(
          "Forget Password",
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: false,
        elevation: 1,
        // give the appbar shadows
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
            key: _formKey,
            child: new ListView(
              shrinkWrap: true,
              children: <Widget>[
                showLogo(),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                  child: TextFormField(
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Provide an email';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Email',
                        icon: new Icon(
                          Icons.mail,
                          color: Colors.grey,
                        )),
                    onSaved: (input) => _email = input,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                  child: SizedBox(
                    height: 40.0,
                    child: RaisedButton(
                      elevation: 5.0,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Colors.blue,
                      child: Text(
                        'Forgot Password',
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      onPressed: forgotPassword,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('images/sameday.png'),
        ),
      ),
    );
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text('Forget Password',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: forgotPassword,
          ),
        ));
  }

  void forgotPassword() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }catch(e){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginSignupPage()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
