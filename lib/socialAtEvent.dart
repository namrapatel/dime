import 'package:Dime/profPage.dart';
import 'package:Dime/socialPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:location/location.dart';
import 'viewCards.dart';



class socialAtEvent extends StatefulWidget {
  socialAtEvent({Key key}) : super(key: key);
  @override
  _socialAtEventState createState() => _socialAtEventState();
}

class _socialAtEventState extends State<socialAtEvent>
    with SingleTickerProviderStateMixin {
  RubberAnimationController _controller;
  //Completer <GoogleMapController> mapController = Completer();

  FocusNode _focus = new FocusNode();

  // getPermission() async {
  //   final GeolocationResult result =
  //       await Geolocation.requestLocationPermission(const LocationPermission(
  //           android: LocationPermissionAndroid.fine,
  //           ios: LocationPermissionIOS.always));
  //   return result;
  // }





  final screenH = ScreenUtil.instance.setHeight;
  final screenW = ScreenUtil.instance.setWidth;
  final screenF = ScreenUtil.instance.setSp;

  // getPermission() async {
  //   final GeolocationResult result =
  //       await Geolocation.requestLocationPermission(const LocationPermission(
  //           android: LocationPermissionAndroid.fine,
  //           ios: LocationPermissionIOS.always));
  //   return result;
  // }

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {

    
    _controller = RubberAnimationController(
        vsync: this,
        upperBoundValue: AnimationControllerValue(percentage: 0.95),
        initialValue: 0.57,
        lowerBoundValue: AnimationControllerValue(percentage: 0.57),
        duration: Duration(milliseconds: 200));
    super.initState();
    _focus.addListener(_onFocusChange);
    
  }

  void _onFocusChange(){
    if(_focus.hasFocus){
      _controller.animateTo(from: _controller.value, to: _controller.upperBound);
    }
  }


  String _value;

 DropdownButton _normalDown() => DropdownButton<String>(
          iconEnabledColor: Colors.white,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
        items: [
          DropdownMenuItem(
            value: "1",
            child: Text(
              "Meet new people",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          DropdownMenuItem(
            value: "2",
            child: Text(
              "Fun, social activities",
              style: TextStyle(color: Colors.black, fontSize: 15),

            ),
          ),
          DropdownMenuItem(
            value: "3",
            child: Text(
              "Hang out with friends",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          DropdownMenuItem(
            value: "4",
            child: Text(
              "Just have some fun",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          DropdownMenuItem(
            value: "4",
            child: Text(
              "IDK I\'m drunk",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        },
        value: _value,
      );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RubberBottomSheet(
          scrollController: _scrollController,
          lowerLayer: _getLowerLayer(),
          header: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                )),
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 122),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 7.5,
                  height: MediaQuery.of(context).size.height / 110,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.width / 32.5, 0, 0),
                ),
                Center(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width / 17.5, 0, 0, 0),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width / 1.65, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height / 52, 0, 0)),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width / 4.2, 0, 0, 0),
                    ),
                    Icon(Icons.people, color: Colors.black),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width / 52,
                          MediaQuery.of(context).size.height / 52,
                          0,
                          0),
                    ),
                    Text(
                      "Others at this Event",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width / 52, 0, 0, 0),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.height / 109, 0, 0),
                ),
              ],
            ),
          ),
          headerHeight: MediaQuery.of(context).size.height / 8.75,
          upperLayer: _getUpperLayer(),
          animationController: _controller,
        ), 
      ),
    );
  }

  //map goes here
  Widget _getLowerLayer() {
    return new Stack(
      children: <Widget>[
        _btmCard(context),

      ],
    );
  }

  Widget _btmCard(BuildContext context) {
      List<String> _reasons = ['Meet new people', 'Fun, social activities', 'Hang out with friends', 'Just have some fun', 'IDK I\'m drunk']; // Option 2
      String _selectedReason; // 
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(children: <Widget>[
            Container(
              color: Color(0xFF8803fc),
              height: screenH(370),
              width: screenW(420),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: screenH(50),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: screenH(35),
                    ),
                    _normalDown(), 
                    SizedBox(
                      width: screenW(110),
                    ),
                    IconButton(
                      icon: Icon(Icons.create),
                      onPressed: () {
                        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: SocialPage()));
                      },
                      color: Colors.white,
                      iconSize: screenH(25),
                    )
                  ],
                ),
                SizedBox(
                  height: screenH(10),
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
                              Text("Namra Patel",
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
                                AssetImage("assets/namrapatel.png"),
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
            Padding(
              padding: EdgeInsets.all(10),
            ),

        ],
      ),
    );
  }

  Widget _getUpperLayer() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                "Dhruv Patel",
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height / 100, 0, 0),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text("Mechatronics Engineering, 2023"),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text("Meet new people", style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height / 70, 0, 0),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 30,
                        width: MediaQuery.of(context).size.width / 6,
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width / 40,
                            MediaQuery.of(context).size.height / 150,
                            0,
                            0),
                        child: Text("Badminton",
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                        decoration: BoxDecoration(
                            color: Color(0xFF8803fc),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 30,
                        width: MediaQuery.of(context).size.width / 8.5,
                        padding: EdgeInsets.fromLTRB(10, 4.5, 0, 0),
                        child: Text("Flutter",
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                        decoration: BoxDecoration(
                            color: Color(0xFF1976d2),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height / 50, 0, 0),
                  )
                ],
              ),
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/img/dhruvpatel.jpeg'),
                radius: 20,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(MaterialCommunityIcons.chat),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(MaterialCommunityIcons.card_bulleted),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ViewCards()));
                    },
                  ),
                ],
              ),
            );
          },
          itemCount: 100),
    );
  }


}
