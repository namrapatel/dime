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

class myCards extends StatefulWidget {
  @override
  _myCardsState createState() => _myCardsState();
}

class _myCardsState extends State<myCards> {



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
        body: Column(
    children: <Widget>[
        SizedBox(
        height: 40,
      ),
      Row(
        children: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
          ),
          SizedBox(
            width: 295,
          ),
            IconButton(
            onPressed: (){
              Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: TabsApp()));
            },
            icon: Icon(Icons.create, color: Colors.black,),
          ),
        
        ],
      ),
      Text("Professional Card", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      Stack(children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: screenH(30),
                ),

                SizedBox(
                  width: screenW(165),
                ),
              ],
            ),
            SizedBox(
              height: screenH(40),
            ),
            Container(
              height: screenH(220),
              width: screenW(370),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.35),
                        blurRadius: (20),
                        spreadRadius: (5),
                        offset: Offset(0, 5)),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: screenH(20),
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: screenW(20),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(currentUserModel.displayName,
                              style: TextStyle(
                                fontSize: screenF(18),
                              )),
                          SizedBox(
                            height: screenH(2),
                          ),
                          Text("University of Western Ontario",
                              style: TextStyle(
                                  fontSize: screenF(13),
                                  color: Colors.purple)),
                          SizedBox(
                            height: screenH(2),
                          ),
                          Text("Computer Science, 2022",
                              style: TextStyle(
                                  fontSize: screenF(13),
                                  color: Colors.grey)),
                        ],
                      ),
                      SizedBox(
                        width: screenW(115),
                      ),
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(currentUserModel.photoUrl),
                        radius: 22,
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenH(15),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenW(30.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Icon(
                              MaterialCommunityIcons.github_box,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: screenW(10),
                            ),
                            Text("namrapatel",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenF(12))),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Icon(
                              FontAwesome.linkedin_square,
                              color: Color(0xFF0077B5),
                            ),
                            SizedBox(
                              width: screenW(10),
                            ),
                            Text("namrapatel",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenF(12))),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Icon(
                              MaterialCommunityIcons.twitter_box,
                              color: Color(0xFF1976d2),
                            ),
                            Text("namrapatel",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenF(12))),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ]),
      SizedBox(
        height: 20,
      ),
            Stack(children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: screenH(50),
                  ),
                  Text("Social Card", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: screenW(215),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenH(40),
                  ),
                  Container(
                    height: screenH(220),
                    width: screenW(370),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.35),
                              blurRadius: (20),
                              spreadRadius: (5),
                              offset: Offset(0, 5)),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: screenH(20),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: screenW(20),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(currentUserModel.displayName,
                                    style: TextStyle(
                                      fontSize: screenF(18),
                                    )),
                                SizedBox(
                                  height: screenH(2),
                                ),
                                Text("University of Western Ontario",
                                    style: TextStyle(
                                        fontSize: screenF(13),
                                        color: Color(0xFF8803fc))),
                                SizedBox(
                                  height: screenH(2),
                                ),
                                Text("Computer Science, 2022",
                                    style: TextStyle(
                                        fontSize: screenF(13),
                                        color: Colors.grey)),
                              ],
                            ),
                            SizedBox(
                              width: screenW(115),
                            ),
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(currentUserModel.photoUrl),
                              radius: 22,
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenH(15),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: screenW(30.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Icon(
                                    FontAwesome.snapchat_square,
                                    color: Color(0xFFfffc00),
                                  ),
                                  SizedBox(
                                    width: screenW(10),
                                  ),
                                  Text("namrapatel9",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenF(12))),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    MaterialCommunityIcons.instagram,
                                    color: Color(0xFF8803fc),
                                  ),
                                  SizedBox(
                                    width: screenW(10),
                                  ),
                                  Text("namrajpatel",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenF(12))),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    MaterialCommunityIcons.twitter_box,
                                    color: Colors.blue,
                                  ),
                                  Text("namrapatel",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenF(12))),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ]),
    ],
        ),
      );
  }
}