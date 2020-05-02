import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:samedayrushprint/pages/past_orders.dart';
import 'package:samedayrushprint/pages/profile_page.dart';
import 'package:samedayrushprint/pages/root_page.dart';
import 'package:samedayrushprint/services/authentication.dart';

// ignore: must_be_immutable
class WebView extends StatefulWidget {
  WebView({Key key, this.auth, this.logoutCallback, this.profileCallback});

  final BaseAuth auth;
  VoidCallback profileCallback;
  VoidCallback logoutCallback;

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  String url = "https://www.samedayrushprinting.com/";

  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription<WebViewStateChanged>
      _onchanged; // here we checked the url state if it loaded or start Load or abort Load

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onchanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        if (state.type == WebViewState.finishLoad) {
          // if the full website page loaded
          print("loaded...");
        } else if (state.type == WebViewState.abortLoad) {
          // if there is a problem with loading the url
          print("there is a problem...");
        } else if (state.type == WebViewState.startLoad) {
          // if the url started loading
          print("start loading...");
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flutterWebviewPlugin
        .dispose(); // disposing the webview widget to avoid any leaks
  }

  Future<void> navigateProfile() async {
    if (await FirebaseAuth.instance.currentUser() != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Profile(auth: new Auth())),
          ModalRoute.withName("/profile"));
      // signed in
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => RootPage(auth: new Auth())),
          ModalRoute.withName("/login"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: new Image.asset('images/logo.png'),
        backgroundColor: Colors.white,
        title: Text(
          "Home",
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
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => PastOrders()),
                    ModalRoute.withName("/orders")),
                child: Icon(Icons.shopping_cart)),
            title: GestureDetector(
                onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => PastOrders()),
                    ModalRoute.withName("/orders")),
                child: Text('Orders')),
          ),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: navigateProfile, child: Icon(Icons.person)),
              title:
                  GestureDetector(onTap: navigateProfile, child: Text('Profile')))
        ],
      ),
      body: WebviewScaffold(
          url: url,
          withJavascript: true,
          // run javascript
          withZoom: false,
          userAgent:
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36",
          // if you want the user zoom-in and zoom-out
          hidden: true,
          // put it true if you want to show CircularProgressIndicator while waiting for the page to load

          initialChild: Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )),
    );
  }


}
