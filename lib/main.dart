import 'package:Dime/homePage.dart';
import 'package:Dime/login.dart';
import 'package:Dime/models/user.dart';
import 'package:Dime/newOnboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';

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
    fixBug();
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
                CupertinoPageRoute(builder: (context) => Onboarding1()));
          } else {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => ScrollPage(social: true)));
          }
        }
      } else {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => Login()));
        print("floppps");
      }
    });
  }

  fixBug() async {
    List<dynamic> emptyList = [];
    QuerySnapshot users = await Firestore.instance
        .collection('users')
        .where('likedBy', isEqualTo: null)
        .getDocuments();
    for (var doc in users.documents) {
      if (doc['likedBy'] == null) {
        Firestore.instance
            .collection('users')
            .document(doc.documentID)
            .updateData({'likedBy': emptyList});
      }
    }
    QuerySnapshot posts =
        await Firestore.instance.collection('socialPosts').getDocuments();
    for (var posts in posts.documents) {
      Firestore.instance
          .collection('socialPosts')
          .document(posts.documentID)
          .setData({'type': "social"}, merge: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            color: Colors.white,
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
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
                    ),
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
