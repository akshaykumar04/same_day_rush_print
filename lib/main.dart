import 'package:flutter/material.dart';

import 'UI/WebView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Same Day Rush Printing',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: WebView(),
    );
  }
}