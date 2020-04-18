import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'datasource.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID-19 Tracker',
      theme: ThemeData(
        fontFamily: 'Circular',
        primaryColor: primaryBlack,
      ),
      home: HomePage(),
    );
  }
}
