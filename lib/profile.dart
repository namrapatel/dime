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
  @override
  List<SearchItem<int>> data2 = [
    SearchItem(0, 'Please select your university'),
    SearchItem(1, 'Athabasca University'),
    SearchItem(2, 'MacEwan University'),
    SearchItem(3, 'Mount Royal University'),
    SearchItem(4, 'University of Alberta'),
    SearchItem(5, 'University of Calgary'),
    SearchItem(6, 'University of Lethbridge'),
    SearchItem(7, 'Capilano University'),
    SearchItem(8, 'Emily Carr University of Art and Design'),
    SearchItem(9, 'Kwantlen Polytechnic University'),
    SearchItem(10, 'Royal Roads University'),
    SearchItem(11, 'Simon Fraser University'),
    SearchItem(12, 'Thompson Rivers University'),
    SearchItem(13, 'University of British Columbia'),
    SearchItem(14, 'University of Victoria'),
    SearchItem(15, 'University of the Fraser Valley'),
    SearchItem(16, 'University of Northern British Columbia'),
    SearchItem(17, 'Vancouver Island University'),
    SearchItem(18, 'Brandon University'),
    SearchItem(19, 'University College of the North'),
    SearchItem(20, 'University of Manitoba'),
    SearchItem(21, 'University of Winnipeg'),
    SearchItem(22, 'Université de Saint-Boniface'),
    SearchItem(23, 'Mount Allison University'),
    SearchItem(24, 'St. Thomas University'),
    SearchItem(25, 'University of New Brunswick'),
    SearchItem(26, 'Université de Moncton'),
    SearchItem(27, 'Memorial University of Newfoundland'),
    SearchItem(28, 'Acadia University'),
    SearchItem(29, 'Cape Breton University'),
    SearchItem(30, 'Dalhousie University'),
    SearchItem(31, "University of King's College"),
    SearchItem(32, 'Mount Saint Vincent University'),
    SearchItem(33, 'Saint Francis Xavier University'),
    SearchItem(34, "Saint Mary's University"),
    SearchItem(35, 'Université Sainte-Anne'),
    SearchItem(36, "Algoma University"),
    SearchItem(37, 'Brock University'),
    SearchItem(38, 'Carleton University'),
    SearchItem(39, "Dominican University College"),
    SearchItem(40, 'Lakehead University'),
    SearchItem(41, "Laurentian University"),
    SearchItem(42, 'McMaster University'),
    SearchItem(43, 'Nipissing University'),
    SearchItem(44, "OCAD University"),
    SearchItem(45, "Queen's University"),
    SearchItem(46, "Saint Paul University"),
    SearchItem(47, 'Royal Military College of Canada'),
    SearchItem(48, 'Ryerson University'),
    SearchItem(49, "Trent University"),
    SearchItem(50, 'University of Guelph'),
    SearchItem(51, "University of Ontario Institute of Technology"),
    SearchItem(52, 'University of Ottawa'),
    SearchItem(53, 'University of Toronto'),
    SearchItem(54, "Huron University College"),
    SearchItem(55, 'University of Waterloo'),
    SearchItem(56, "University of Western Ontario"),
    SearchItem(57, 'University of Windsor'),
    SearchItem(58, 'Wilfrid Laurier University'),
    SearchItem(59, "York University"),
    SearchItem(60, 'University of Prince Edward Island'),
    SearchItem(61, "Bishop's University"),
    SearchItem(62, 'Concordia University'),
    SearchItem(63, 'University of Regina'),
    SearchItem(64, "University of Saskatchewan"),
    SearchItem(65, "The King's University"),
    SearchItem(66, "HEC Montréal"),
    SearchItem(67, 'Concordia University of Edmonton'),
    SearchItem(68, 'McGill University'),
    SearchItem(69, "Université de Montréal"),
  ];

  String university;

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
                    color: Colors.black,
                  )))
        ],
      ),
      SizedBox(
        height: 50,
      ),
      Row(
        children: <Widget>[
          SizedBox(
            width: 40,
          ),
          Text(
            'First name',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 40.0),
          child: TextField(
            decoration: InputDecoration(
                border: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black))),
            style: TextStyle(fontSize: 18, color: Colors.grey),
            cursorColor: Colors.black,
          )),
      SizedBox(
        height: 30,
      ),
      Row(
        children: <Widget>[
          SizedBox(
            width: 40,
          ),
          Text(
            'Last name',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 40.0),
          child: TextField(
            decoration: InputDecoration(
                border: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black))),
            style: TextStyle(fontSize: 18, color: Colors.grey),
            cursorColor: Colors.black,
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
            color: Colors.white,
            child: FlutterSearchPanel<int>(
              padding: EdgeInsets.all(10.0),
              selected: 0,
              title: 'Select University',
              data: data2,
              icon: new Icon(Icons.school, color: Colors.black),
              color: Color(0xFFECE9E4),
              textStyle: new TextStyle(
                color: Colors.black,
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
      Row(
        children: <Widget>[
          SizedBox(
            width: 40,
          ),
          Text(
            'Program',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 40.0),
          child: TextField(
            decoration: InputDecoration(
                border: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black))),
            style: TextStyle(fontSize: 18, color: Colors.grey),
            cursorColor: Colors.black,
          )),
      SizedBox(
        height: 30,
      ),
      Row(
        children: <Widget>[
          SizedBox(
            width: 40,
          ),
          Text(
            'Grad year',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 40.0),
          child: TextField(
            decoration: InputDecoration(
                border: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black))),
            style: TextStyle(fontSize: 18, color: Colors.grey),
            cursorColor: Colors.black,
          )),
      SizedBox(
        height: 40,
      ),
      Container(
        width: 250,
        height: 50,
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
          backgroundColor: Colors.black,
          child: Text(
            "Edit Your Cards",
            style: TextStyle(fontSize: (20), color: Colors.white),
          ),
        ),
      ),
    ]);
  }
}
