import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nafal/pages/splash_page.dart';

//Nama  : Nafal Adi SL
//NIM   : 124200025

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Color _primaryColor = HexColor('#00baff');
  Color _accentColor = HexColor('#45c5ff');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RESPONSI 124200025',
      theme: ThemeData(
        primaryColor: _primaryColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
            .copyWith(secondary: _accentColor),
      ),
      home: SplashScreen(),
    );
  }
}
