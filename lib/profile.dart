import 'package:Dime/EditCardsScreen.dart';
import 'package:Dime/models/user.dart';
import 'package:Dime/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/cupertino.dart';
import 'login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_search_panel/flutter_search_panel.dart';
import 'package:flutter_search_panel/search_item.dart';
import 'viewCards.dart';
import 'package:flushbar/flushbar.dart';
import 'homePage.dart';

class Profile extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: HomePageOne()
    );
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileInfo();
  }

  getProfileInfo() async {
    DocumentSnapshot doc = await Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .get();
    setState(() {
      name = doc.data['displayName'];
      major = doc.data['major'];
      gradYear = doc.data['gradYear'];
      university = doc.data['university'];
    });
  }

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
        .updateData({
      'displayName': name,
      'major': major,
      'university': university,
      'gradYear': gradYear
    });

    DocumentSnapshot user = await Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .get();
    currentUserModel = User.fromDocument(user);

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
        .setData({
      'displayName': name,
      'major': major,
      'university': university,
      'gradYear': gradYear
    });
  }

  @override
  List<SearchItem<int>> data2 = [
    SearchItem(0, 'University of Waterloo'),
    SearchItem(1, 'Western University'),
    SearchItem(2, "University of Alberta"),
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

    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
Column(children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height / 20,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 40,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => ProfilePage()));
              },
              color: Colors.black,
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 25.0,
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 100),
        SizedBox(height: MediaQuery.of(context).size.height / 100),
        Row(
          children: <Widget>[
            SizedBox(width: MediaQuery.of(context).size.width / 12.5),
            Text(
              'Edit profile',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
            ),

            FlatButton(
              color: Color(0xFF1458EA),
              child: Text(
                "Edit Cards",
                style: TextStyle(color: Colors.white),
              ),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => TabsApp()));
              },
            ),

            // InkWell(
            //     onTap: updateProfile,
            //     child: Container(
            //         padding: EdgeInsets.all(8),
            //         height: 25,
            //         width: 45,
            //         child: Center(
            //             child: Text(
            //           'Save',
            //           style: TextStyle(color: Colors.white),
            //         )),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(40),
            //           color: Color(0xFF1458EA),
            //         )))
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 20,
        ),
        Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 15),
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    name = value;
                  });
                }
              },
              decoration: InputDecoration(
                hintText: name == "No Display Name" ? "Name" : name,
                hintStyle: TextStyle(color: Colors.grey),
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
          height: MediaQuery.of(context).size.height / 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 15),
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height / 9,
              child: FlutterSearchPanel<int>(
                padding: EdgeInsets.all(10.0),
                selected: data2.indexWhere((SearchItem element) =>
                    element.text == currentUserModel.university),
                title: "Select your university",
                data: data2,
                color: Colors.white,
                icon: new Icon(Icons.school, color: Colors.black),
                textStyle: new TextStyle(
                  color: Color(0xFF1458EA),
                  fontSize: 15.0,
                ),
                onChanged: (int value) {
                  if (value != null) {
                    if (data2[value].text.isNotEmpty &&
                        data2[value].text != null) {
                      setState(() {
                        university = data2[value].text;
                      });
                    }
                  }
                },
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 20,
        ),
        Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 15),
            child: TextField(
              textCapitalization: TextCapitalization.words,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    major = value;
                  });
                }
              },
              decoration: InputDecoration(
                hintText: major == null ? "Program" : major,
                hintStyle: TextStyle(color: Colors.grey),
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
          height: MediaQuery.of(context).size.height / 20,
        ),
        Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 15),
            child: TextField(
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    gradYear = "" + value;
                  });
                }
              },
              decoration: InputDecoration(
                hintText: gradYear == null ? "Graduation Year" : gradYear,
                hintStyle: TextStyle(color: Colors.grey),
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
          height: MediaQuery.of(context).size.height / 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.height / 13,
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
              updateProfile();
              Flushbar(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                borderRadius: 15,
                messageText: Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Saved!',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Your basic information has been updated.',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
                boxShadows: [
                  BoxShadow(
                      color: Colors.black12.withOpacity(0.1),
                      blurRadius: (15),
                      spreadRadius: (5),
                      offset: Offset(0, 3)),
                ],
                flushbarPosition: FlushbarPosition.TOP,
                icon: Padding(
                  padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                  child: Icon(
                    Icons.save_alt,
                    size: 28.0,
                    color: Color(0xFF1458EA),
                  ),
                ),
                duration: Duration(seconds: 3),
              )..show(context);
            },
            backgroundColor: Color(0xFF1458EA),
            child: Text(
              "Save",
              style: TextStyle(fontSize: (20), color: Colors.white),
            ),
          ),
        ),
      ]),
        ],
      )
    );
  }
}
