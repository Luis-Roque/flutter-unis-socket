import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:unis_name/src/pages/homePage.dart';
import 'package:unis_name/src/pages/statusPage.dart';
import 'package:unis_name/src/service/socket_service.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> SocketService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Universidades',
        initialRoute: 'home',
        routes: {
          'home': ( _ )=>homePage(),
          'status': ( _ )=>statusPage(),
        }, 
      ),
    );
  }
}