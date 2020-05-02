import 'package:flutter/material.dart';
import 'package:samedayrushprint/pages/past_orders.dart';
import 'package:samedayrushprint/pages/root_page.dart';

import '../services/authentication.dart';
import '../ui/web_view.dart';

class Profile extends StatefulWidget {
  Profile(
      {Key key,
      this.auth,
      this.userId,
      this.logoutCallback,
      this.profileCallback})
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
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => RootPage(auth: new Auth())),
          ModalRoute.withName("/login"));
    } catch (e) {
      print(e);
    }
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
      bottomNavigationBar: new BottomNavigationBar(
//        onTap: onTabTapped,
//
//        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WebView())),
                child: Icon(
                  Icons.home,
                  color: Colors.black45,
                )),
            title: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WebView())),
                child: Text(
                  'Home',
                  style: TextStyle(color: Colors.black45),
                )),
          ),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PastOrders())),
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.black45,
                  )),
              title: GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PastOrders())),
                  child: Text('Orders'))),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.blue,
            ),
            title: Text(
              'Profile',
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 25.0),
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            showLogo(),
            Container(
              margin: const EdgeInsets.only(top: 80.0),
              child: Center(
                child: Text(
                  'App Version: 1.0',
                  style: TextStyle(color: Colors.black, fontSize: 16.0,),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Text(
                  'Developed by: sstechcanada',
                  style: TextStyle(color: Colors.black, fontSize: 16.0,),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 80.0),
              child: new RaisedButton(
                  elevation: 5.0,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  color: Colors.blue,
                  child: new Text('Log Out',
                      style:
                          new TextStyle(fontSize: 20.0, color: Colors.white)),
                  onPressed: signOut),
            )
          ],
        ),
      ),
    );
  }
}
