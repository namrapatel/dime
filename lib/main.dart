import 'package:Dime/homePage.dart';
import 'package:Dime/login.dart';
import 'package:Dime/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'onboarding.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(Dime());

class Dime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dime",
      home: SplashScreen(),
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
  final String route;
  const SplashScreen({this.route});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
//  startTime() async {
//    return Timer(
//        Duration(seconds: 3))
////        () => widget.route == 'login'
////            ? Navigator.push(
////                context,
////                PageTransition(
////                    type: PageTransitionType.rightToLeft, child: Login()))
////            : Navigator.push(
////                context,
////                PageTransition(
////                    type: PageTransitionType.rightToLeft,
////                    child: ScrollPage())));
//  }

  @override
  void initState() {
    super.initState();
//    startTime();
    FirebaseAuth.instance.onAuthStateChanged.listen((firebaseUser) async {
      if (firebaseUser != null) {
        print('in login');
        print(firebaseUser);
        print(firebaseUser.displayName);
        print("you're in");
//check for exception, may only be if emulator not wiped
        DocumentSnapshot userRecord = await Firestore.instance
            .collection('users')
            .document(firebaseUser.uid)
            .get();
        if (userRecord.data != null) {
          currentUserModel = User.fromDocument(userRecord);
          if (widget.route == 'onBoarding') {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => onBoarding()));
          } else {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => ScrollPage()));
          }
        }
      } else {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => Login()));
        print("floppps");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //   return Scaffold(
    //       body: Container(
    //     decoration: new BoxDecoration(
    //       gradient: new LinearGradient(
    //           colors: [Color(0xFF8803fc), Color(0xFF1976d2)],
    //           begin: const FractionalOffset(0.0, 0.0),
    //           end: const FractionalOffset(1.0, 1.0),
    //           stops: [0.0, 1.0],
    //           tileMode: TileMode.clamp),
    //     ),
    //     child: Center(
    //       child: Image.asset('assets/img/friendsDrawing.png'),
    //     ),
    //   ));
    // }
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            color: Colors.white,
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //         begin: Alignment.topRight,
            //         end: Alignment.bottomLeft,
            //         colors: [Color(0xFF1458EA), Color(0xFF003cbf)])),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  width: 100,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/GroupDimeTransparent.png')
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 90,
                    ),
                    SpinKitRipple(
                      color: Color(0xFF1458EA),
                      duration: Duration(milliseconds: 1000),
                    ),
                    // CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
                    ),
                    // Text(
                    //   'Dime',
                    //   softWrap: true,
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 46.0,
                    //       color: Colors.grey[200]),
                    // )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
