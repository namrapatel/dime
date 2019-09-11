import 'package:flutter/material.dart';
import 'package:Dime/profile.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'viewCards.dart';
import 'homePage.dart';

class Onboarding1 extends StatefulWidget {
  @override
  _Onboarding1State createState() => _Onboarding1State();
}

class _Onboarding1State extends State<Onboarding1> {
  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    return Scaffold(
      backgroundColor: Color(0xFF1458EA),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: screenH(65.0)),
              child: Text('People around you',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenF(36.0),
                      // fontWeight: FontWeight.bold,
                      fontFamily: 'futura')),
            ),
            SizedBox(
              height: screenH(25),
            ),
            Image.asset(
              'assets/darkpeoplearoundyou.png',
              height: screenH(600.0),
              width: screenW(600.0),
              alignment: Alignment.center,
            ),
            Padding(
              padding: EdgeInsets.all(screenH(8.0)),
              child: Text(
                'Find people around your location, read their bios, and chat or connect with their medias!',
                style: TextStyle(
                    fontFamily: 'futura',
                    color: Colors.white,
                    fontSize: screenF(18.0)),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: screenW(320),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => Onboarding2()));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Onboarding2 extends StatefulWidget {
  @override
  _Onboarding2State createState() => _Onboarding2State();
}

class _Onboarding2State extends State<Onboarding2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1458EA),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: screenH(65.0)),
              child: Text('People around you',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenF(36.0),
                      // fontWeight: FontWeight.bold,
                      fontFamily: 'futura')),
            ),
            SizedBox(
              height: screenH(25),
            ),
            Image.asset(
              'assets/darkpeoplearoundyou.png',
              height: screenH(600.0),
              width: screenW(600.0),
              alignment: Alignment.center,
            ),
            Padding(
              padding: EdgeInsets.all(screenH(8.0)),
              child: Text(
                'Find people around your location, read their bios, and chat or connect with their medias!',
                style: TextStyle(
                    fontFamily: 'futura',
                    color: Colors.white,
                    fontSize: screenF(18.0)),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: screenW(320),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => Onboarding2()));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
