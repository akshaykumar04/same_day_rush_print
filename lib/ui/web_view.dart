import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:samedayrushprint/pages/login_signup_page.dart';
import 'package:samedayrushprint/pages/placeholder.dart';

class WebView extends StatefulWidget {
  @override
  _WebViewState createState() => _WebViewState();
  int _currentIndex = 0;
  final List<Widget> _children = [
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green)
  ];
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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.history,
              color: Colors.lightBlue,
            ),
            tooltip: "Past Orders",
            //onPressed: () => SystemNavigator.pop(),
          ),
          IconButton(
            icon: Icon(
              Icons.input,
              color: Colors.lightBlue,
            ),
            onPressed: () => SystemNavigator.pop(),
          )
//          PopupMenuButton<int>(
//              onSelected: (selected) {},
//              icon: Icon(Icons.more_vert, color: Colors.lightBlue,),
//              itemBuilder: (BuildContext context) {
//            return[
//              PopupMenuItem(
//
//                child: GestureDetector(
//                  onTap: (){
//                    _showoOrdersDialog();
//                  },
//                  child: Text('Logout', style: TextStyle(color: Colors.lightBlue)),
//                ),
//              ),
//            ];
//          }),
        ], // make the icons colors inside appbar with white color
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
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginSignupPage())),
                child: Icon(Icons.shopping_cart)),
            title: Text('Orders'),
          ),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginSignupPage()),
                      ModalRoute.withName("/web")),
                  child: Icon(Icons.person)),
              title: GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginSignupPage()),
                      ModalRoute.withName("/web")),
                  child: Text('Login')))
        ],
      ),
      body: WebviewScaffold(
          url: url,
          withJavascript: true,
          // run javascript
          withZoom: false,
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
