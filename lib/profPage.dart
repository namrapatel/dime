import 'dart:ui' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sticky_infinite_list/sticky_infinite_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
import 'profAtEvent.dart';
import 'package:circular_splash_transition/circular_splash_transition.dart';
import 'package:page_transition/page_transition.dart';
import 'homePage.dart';

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;
final _firestore = Firestore.instance;

class ProfPage extends StatefulWidget {
  @override
  _ProfPageState createState() => _ProfPageState();
}

class _ProfPageState extends State<ProfPage> {
  String uid = currentUserModel.uid;
  CircularSplashController _controller = CircularSplashController(
    color: Color(0xFF1976d2), //optional, default is White.
    duration: Duration(milliseconds: 350), //optional.
  );

  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    return CircularSplash(
      controller: _controller,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Stack(children: <Widget>[
              Container(
                color: Color(0xFF1976d2),
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
                        "Networking Mode",
                        style: TextStyle(
                            fontSize: screenF(20),
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: screenW(165),
                      ),
                      IconButton(
                        icon: Icon(Icons.create),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.leftToRight,
                                  child: ScrollPage()));
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
            Column(children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                      stream:
                          _firestore.collection('networkingEvents').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData ||
                            snapshot.data.documents.length == 0) {
                          return Column(
                            children: <Widget>[],
                          );
                        }
                        final docs = snapshot.data.documents;
                        List<NetworkingEventCard> networkingEvents = [];
                        for (var doc in docs) {
                          String eventName = doc.data['eventName'].toString();
                          String location = doc.data['location'].toString();
                          String food = doc.data['food'].toString();
                          String swag = doc.data['swag'].toString();
                          var date = doc.data['timestamp'];
                          networkingEvents.add(NetworkingEventCard(
                            eventName: eventName,
                            location: location,
                            food: food,
                            date: date,
                            swag: swag,
                          ));
                          return Stack(children: <Widget>[
                            Container(
                              height: 475,
                              width: 400,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: networkingEvents.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return networkingEvents[index];
                                  }),
                            ),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: screenH(410.0)),
                                child: Container(
                                  height: screenH(55),
                                  width: screenW(340),
                                  child: FloatingActionButton.extended(
                                    icon: Icon(Icons.done),
                                    elevation: screenH(5),
                                    onPressed: () {
                                      print(networkingEvents.length);
                                      _controller.push(context, profAtEvent());
                                    },
                                    backgroundColor: Color(0xFF1976d2),
                                    label: Text(
                                      "  I'm at an event",
                                      style: TextStyle(fontSize: screenF(20)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]);
                        }
                      })
            ])
          ],
        ),
      ),
    );
  }
}

List<MemberAvatar> memberAvatars = [
  MemberAvatar("assets/namrapatel.png"),
  MemberAvatar("assets/dhruvpatel.jpeg"),
  MemberAvatar("assets/shehabsalem.jpeg"),
  MemberAvatar("assets/taher.jpeg"),
  MemberAvatar("assets/namrapatel.png"),
  MemberAvatar("assets/dhruvpatel.jpeg"),
  MemberAvatar("assets/shehabsalem.jpeg"),
  MemberAvatar("assets/taher.jpeg")
];

class MemberAvatar extends StatelessWidget {
  final String memberImage;
  MemberAvatar(this.memberImage);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
      child: Container(
        width: screenW(38),
        child: CircleAvatar(
          backgroundImage: AssetImage(memberImage),
          radius: screenH(15),
        ),
      ),
    );
  }
}

class NetworkingEventCard extends StatelessWidget {
  CircularSplashController _controller = CircularSplashController(
    color: Color(0xFF1976d2), //optional, default is White.
    duration: Duration(milliseconds: 350), //optional.
  );
  String eventName;
  String date;
  String food;
  String swag;
  String location;
  NetworkingEventCard(
      {this.eventName, this.location, this.date, this.food, this.swag});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: screenH(95.0)),
          child: Container(
            alignment: Alignment.centerRight,
            width: screenW(50),
            height: screenH(70),
            child: Column(
              children: <Widget>[
                Text("1",
                    style: TextStyle(
                        fontSize: screenF(25), fontWeight: FontWeight.bold)),
                Text("July",
                    style: TextStyle(
                      fontSize: screenF(15),
                    )),
              ],
            ),
          ),
        ),
        Container(
            height: screenH(525),
            width: screenW(360),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: screenH(20),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenH(20.0)),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: screenH(15)),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    height: screenH(200),
                    width: screenW(310),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: screenW(15.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(eventName,
                                  style: TextStyle(
                                      fontSize: screenF(16),
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1976d2))),
                              Text(location,
                                  style: TextStyle(
                                    fontSize: screenF(13),
                                  )),
                              SizedBox(
                                height: screenH(10),
                              ),
                              Container(
                                height: screenH(40),
                                child: ListView(
                                  children: memberAvatars,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                              SizedBox(
                                height: screenH(25),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: screenW(2.0)),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Time",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: screenH(5),
                                        ),
                                        Text(
                                          "6:00PM",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: screenW(140),
                                    ),

                                    Icon(
                                      MaterialCommunityIcons.food,
                                      color: Color(0xFF1976d2),
                                    ),
                                    SizedBox(
                                      width: screenW(20),
                                    ),
                                    Icon(
                                      MaterialCommunityIcons.sunglasses,
                                      color: Color(0xFF1976d2),
                                    )
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //       color: Colors.purple,
                                    //       boxShadow: [
                                    //         BoxShadow(
                                    //             color: Colors.black
                                    //                 .withOpacity(0.4),
                                    //             blurRadius: (10),
                                    //             spreadRadius: (1),
                                    //             offset: Offset(0, 5)),
                                    //       ],
                                    //       borderRadius:
                                    //           BorderRadius.all(
                                    //               Radius.circular(
                                    //                   15))),
                                    //   child: Padding(
                                    //     padding: const EdgeInsets
                                    //             .symmetric(
                                    //         vertical: 3.0,
                                    //         horizontal: 15.0),
                                    //     child: Text(
                                    //       "GO",
                                    //       style: TextStyle(
                                    //           color: Colors.white,
                                    //           fontSize: 20,
                                    //           fontWeight:
                                    //               FontWeight.bold),
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
