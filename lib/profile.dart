import 'package:Dime/EditCardsScreen.dart';
import 'package:Dime/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_search_panel/flutter_search_panel.dart';
import 'package:flutter_search_panel/search_item.dart';
import 'viewCards.dart';

class Profile extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      HomePageOne() /*, HomePageTwo(), HomePageThree()*/
    ]));
  }
}

class HomePageOne extends StatefulWidget {
  @override
  _HomePageOneState createState() => _HomePageOneState();
}

class _HomePageOneState extends State<HomePageOne> {
  String name;
  String major;
  String gradYear;
  String university;
  updateProfile() async {
//  QuerySnapshot query = await Firestore.instance
//      .collection('users')
//      .document(currentUserModel.uid)
//      .collection('socialcard')
//      .getDocuments();
//
//  for (var document in query.documents) {
//    setState(() {
//      socialCardId = document.documentID;
//    });
//
//    QuerySnapshot query2 = await Firestore.instance
//        .collection('users')
//        .document(currentUserModel.uid)
//        .collection('profcard')
//        .getDocuments();
//
//    for (var document2 in query2.documents) {
//      setState(() {
//        profCardId = document2.documentID;
//      });
//    }

    Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .setData({
      'displayName': name,
      'major': major,
      'university': university,
      'gradYear': gradYear
    }, merge: true);

    Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .collection('socialcard')
        .document(socialCardId)
        .updateData({
      'displayName': name,
      'major': major,
      'university': university,
      'gradYear': gradYear
    });

    Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .collection('profcard')
        .document(profCardId)
        .updateData({
      'displayName': name,
      'major': major,
      'university': university,
      'gradYear': gradYear
    });
  }

  @override
  List<SearchItem<int>> data2 = [
    SearchItem(0, 'Please select your university'),
    SearchItem(1, 'University of Waterloo'),
    SearchItem(2, 'University of Western Ontario'),
    SearchItem(3, "University of Calgary"),
  ];

  Widget build(BuildContext context) {
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return Column(children: <Widget>[
      SizedBox(
        height: 45,
      ),
      Row(
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
            iconSize: 25.0,
          ),
        ],
      ),
      SizedBox(
        height: 30,
      ),
      SizedBox(
        height: 5,
      ),
      Row(
        children: <Widget>[
          SizedBox(
            width: 40,
          ),
          Text(
            'Edit profile',
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 150.0,
          ),
          InkWell(
              onTap: updateProfile,
              child: Container(
                  height: 25,
                  width: 45,
                  child: Center(
                      child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color(0xFF1458EA),
                  )))
        ],
      ),
      SizedBox(
        height: 50,
      ),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 40.0),
          child: TextField(
            onSubmitted: (value) {
              if (value != '' && value != null) {
                setState(() {
                  name = value;
                });
              }
            },
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
              contentPadding: EdgeInsets.all(20),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                    color: Color(0xFF1458EA),
                    ),
              ),
              focusedBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                  color: Color(0xFF1458EA),
                ),
              ),
            ),
          )),
      SizedBox(
        height: 30,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 800,
            height: 70,
            child: FlutterSearchPanel<int>(
              padding: EdgeInsets.all(10.0),
              selected: 0,
              title: 'Select University',
              data: data2,
              color: Colors.white,
              icon: new Icon(Icons.school, color: Colors.black),
              textStyle: new TextStyle(
                color: Color(0xFF1458EA),
                fontSize: 15.0,
              ),
              onChanged: (int value) {
                if (value != null) {
                  setState(() {
                    university = data2[value].text;
                  });
                }
              },
            ),
          ),
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 40.0),
          child: TextField(
            onSubmitted: (value) {
              if (value != '' && value != null) {
                setState(() {
                  major = value;
                });
              }
            },
            decoration: InputDecoration(
              labelText: 'Program',
              labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
              contentPadding: EdgeInsets.all(20),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                  color: Color(0xFF1458EA),
                ),
              ),
              focusedBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                  color: Color(0xFF1458EA),
                ),
              ),
            ),
          )),
      SizedBox(
        height: 30,
      ),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 40.0),
          child: TextField(
            onSubmitted: (value) {
              if (value != '' && value != null) {
                setState(() {
                  gradYear = "" + value;
                });
              }
            },
            decoration: InputDecoration(
              labelText: 'Graduation Year',
              labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
              contentPadding: EdgeInsets.all(20),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(color: Colors.grey),
              ),
              focusedBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                  color: Color(0xFF1458EA),
                ),
              ),
            ),
          )),
      SizedBox(
        height: 40,
      ),
      Container(
        width: 250,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color(0xFF1458EA).withOpacity(0.35),
                blurRadius: (15),
                spreadRadius: (5),
                offset: Offset(0, 3)),
          ],
        ),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          elevation: (5),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TabsApp()),
            );
          },
          backgroundColor: Color(0xFF1458EA),
          child: Text(
            "Edit Your Cards",
            style: TextStyle(fontSize: (20), color: Colors.white),
          ),
        ),
      ),
    ]);
  }
}
