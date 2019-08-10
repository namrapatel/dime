import 'package:Dime/homePage.dart';
import 'package:Dime/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat.dart';

void main() => runApp(Dime());

class Dime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dime",
      home: Login(),
      theme: appTheme,
    );
  }
}

ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    hintColor: Colors.grey[500],
    primaryColor: Colors.black,
    fontFamily: 'Futura');

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    return Timer(
        Duration(seconds: 3),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            ));
  }
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [Color(0xFF8803fc), Color(0xFF1976d2)],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Center(
        child: Image.asset('assets/img/friendsDrawing.png'),
      ),
    ));
  }
}
