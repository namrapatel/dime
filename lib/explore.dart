import 'package:Dime/socialPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sticky_infinite_list/sticky_infinite_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'profAtEvent.dart';
import 'package:circular_splash_transition/circular_splash_transition.dart';
import 'package:page_transition/page_transition.dart';
import 'homePage.dart';
import 'login.dart';
import 'EditCardsScreen.dart';

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {



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
      backgroundColor: Color(0xFFECE9E4),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height / 15,),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 17, 0, 0, 100),
                      ),
                      Text("Explore", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Container(
                  //color: Colors.white,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 22,
                        vertical: MediaQuery.of(context).size.height / 72),
                    child: TextField(
                      decoration: new InputDecoration(
                          icon: Icon(Icons.search),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 30,
                              bottom: MediaQuery.of(context).size.height / 75,
                              top: MediaQuery.of(context).size.height / 75,
                              right: MediaQuery.of(context).size.width / 30),
                          hintText: 'Search for people, interests, school ...'),
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      );
  }
}