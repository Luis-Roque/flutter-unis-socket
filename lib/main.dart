import 'package:flutter/material.dart';
import 'package:unis_name/src/pages/homePage.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Universidades',
      initialRoute: 'home',
      routes: {
        'home': ( _ )=>homePage(),
      }, 
    );
  }
}