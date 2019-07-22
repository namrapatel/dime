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
        initialValue: 0.45,
        lowerBoundValue: AnimationControllerValue(percentage: 0.45),
        duration: Duration(milliseconds: 200));
    super.initState();
    _focus.addListener(_onFocusChange);
    
  }

  void _onFocusChange(){
    if(_focus.hasFocus){
      _controller.animateTo(from: _controller.value, to: _controller.upperBound);
    }
  }



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
                      
                      focusNode: _focus,
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
            ),
          ),
          headerHeight: MediaQuery.of(context).size.height / 4.75,
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
                      width: screenH(30),
                    ),
                    Text(
                      "Social Mode",
                      style: TextStyle(
                          fontSize: screenF(20),
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: screenW(215),
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
                          Container(
                  width: MediaQuery.of(context).size.width / 1.8,
                  height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF8803fc),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Text("Reason you're here  ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17
                      ),
                      ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_down, color: Colors.white,),
                        onPressed: (){
                        showCupertinoModalPopup(
                          
                          context: context,
                          builder: (BuildContext context) => CupertinoActionSheet(
                            cancelButton: CupertinoActionSheetAction(
                                  child: const Text('Cancel'),
                                  isDefaultAction: true,
                                  onPressed: () {
                                    Navigator.pop(context, 'Cancel');
                                  },
                                ),
                              title: const Text('Select one of the following options for why you are at this event',
                              style: TextStyle(fontSize: 18),
                              ),
                              message: const Text('If you do not see an exact reason for your case, please choose the closest one  '),
                              actions: <Widget>[
                                CupertinoActionSheetAction(
                                  child: const Text('Meet new people'),
                                  onPressed: () {
                                    
                                    Navigator.pop(context, 'Meet new people');
                                  },
                                ),
                                CupertinoActionSheetAction(
                                  child: const Text('Fun, Social Activties'),
                                  onPressed: () {
                                    
                                    Navigator.pop(context, 'Fun, Social Activties');
                                  },
                                ),
                                CupertinoActionSheetAction(
                                  child: const Text('Hang out with Friends'),
                                  onPressed: () {
                               
                                    Navigator.pop(context, 'Hang out with Friends');
                                  },
                                ),
                                CupertinoActionSheetAction(
                                  child: const Text('Just have some fun'),
                                  onPressed: () {
                                    
                                    Navigator.pop(context, 'Two');
                                  },
                                ),
                                CupertinoActionSheetAction(
                                  child: const Text('IDK, I\'m DRUNK'),
                                  onPressed: () {
                                    
                                    Navigator.pop(context, 'Two');
                                  },
                                )
                              ],
                              ),
                        );
                        },
                      ),
                    ],
                  ),
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
                      _showCupertinoDialog();
                    },
                  ),
                ],
              ),
            );
          },
          itemCount: 100),
    );
  }

  void _showCupertinoDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Send Card to Dhruv Patel?'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Please select the card you would like to send. It will send as a message, you can view it in the messages page.',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Social',
                    style: TextStyle(fontSize: 18),
                  )),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Professional',
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          );
        });
  }
}
