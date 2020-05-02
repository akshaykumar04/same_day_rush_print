import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samedayrushprint/pages/profile_page.dart';
import 'package:samedayrushprint/pages/root_page.dart';
import 'package:samedayrushprint/services/authentication.dart';
import 'package:samedayrushprint/ui/web_view.dart';

class PastOrders extends StatelessWidget {
  PastOrders({Key key, this.auth, this.logoutCallback, this.profileCallback});

  final BaseAuth auth;
  VoidCallback profileCallback;
  VoidCallback logoutCallback;

  Future<void> navigateProfile(BuildContext context) async {
    if (await FirebaseAuth.instance.currentUser() != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Profile(auth: new Auth())),
          ModalRoute.withName("/profle"));
      // signed in
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => RootPage(auth: new Auth())),
          ModalRoute.withName("/login"));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: new Image.asset('images/logo.png'),
        backgroundColor: Colors.white,
        title: Text(
          "Past Orders",
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
                  child: Icon(
                Icons.shopping_cart,
                color: Colors.blue,
              )),
              title: Text(
                'Orders',
                style: TextStyle(color: Colors.blue),
              )),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () => navigateProfile(context),
              child: Icon(
                Icons.person,
                color: Colors.black45,
              ),
            ),
            title: GestureDetector(
                onTap: () => navigateProfile(context),
                child: Text(
                  'Profile',
                  style: TextStyle(color: Colors.black45),
                )),
          )
        ],
      ),
      body: new Container(
        alignment: Alignment.center,
        child: new Text(
          "Past Orders Status coming soon in next update!",
          textDirection: TextDirection.ltr,
          style: new TextStyle(
              color: Colors.blue, fontWeight: FontWeight.w900, fontSize: 18.3),
        ),
      ),
    );
  }

  Future<void> nav() async {
    if (await FirebaseAuth.instance.currentUser() != null) {
      // signed in
    } else {}
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
