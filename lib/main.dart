import 'dart:async';
import 'package:flutter/material.dart';
import 'pages/root_page.dart';
import 'services/authentication.dart';

import 'ui/web_view.dart';

Future<void> main() async {
  runApp(new MaterialApp(
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/Login': (BuildContext context) => new RootPage(auth: new Auth()),
      '/Home' : (BuildContext context) => new WebView(),
    },
  ));

}



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  startTime() async {
//    if (await FirebaseAuth.instance.currentUser() != null) {
//      var _duration = new Duration(seconds: 3);
//      return new Timer(_duration, navigationHome);
//      // signed in
//    } else {
      var _duration = new Duration(seconds: 3);
      return new Timer(_duration, navigationLogin);


  }

  void navigationHome() {
    Navigator.of(context).pushReplacementNamed('/Home');
  }

  void navigationLogin() {
    Navigator.of(context).pushReplacementNamed('/Login');
  }

  @override
  void initState() {
    super.initState();

    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 25.0),
          child: new Image.asset('images/sameday.png'),
        )
      ),
    );
  }
  
  


}