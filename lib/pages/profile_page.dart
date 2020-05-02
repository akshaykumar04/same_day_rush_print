import 'package:flutter/material.dart';
import '../services/authentication.dart';
import '../ui/web_view.dart';

class Profile extends StatefulWidget {
  Profile({Key key, this.auth, this.userId, this.logoutCallback,  this.profileCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final VoidCallback profileCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<Profile> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();

  }


  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: new Image.asset('images/logo.png'),
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: false,
        elevation: 1,
        // give the appbar shadows
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: new Container(
        alignment: Alignment.center,
        child: new Text("Profile Page", textDirection: TextDirection.ltr,
          style:  new TextStyle(color: Colors.blue, fontWeight: FontWeight.w900,
              fontSize: 18.3),),
      ),
    );
  }
}
