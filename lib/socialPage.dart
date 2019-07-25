import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:circular_splash_transition/circular_splash_transition.dart';
import 'homePage.dart';
import 'login.dart';
import 'socialAtEvent.dart';

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;
final _firestore = Firestore.instance;

class SocialPage extends StatefulWidget {
  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  CircularSplashController _controller = CircularSplashController(
    color: Color(0xFF8803fc), //optional, default is White.
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
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
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
            Column(children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('socialEvents')
                      .orderBy('monthWeighting', descending: false)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData ||
                        snapshot.data.documents.length == 0) {
                      return Column(
                        children: <Widget>[],
                      );
                    }
                    final docs = snapshot.data.documents;
                    List<SocialEventCard> socialEvents = [];
                    for (var doc in docs) {
                      String eventName = doc.data['eventName'].toString();
                      String location = doc.data['location'].toString();
                      String day = doc.data['day'].toString();
                      String month = doc.data['month'].toString();
                      String time = doc.data['time'].toString();

                      socialEvents.add(SocialEventCard(
                        eventName: eventName,
                        location: location,
                        day: day,
                        month: month,
                        time: time,
                      ));
                    }
                    return Stack(children: <Widget>[
                      Container(
                        height: screenH(525),
                        width: screenW(410),
                        child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: socialEvents.length,
                            itemBuilder: (BuildContext context, int index) {
                              return socialEvents[index];
                            }),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: screenH(410.0)),
                          child: Container(
                            height: screenH(55),
                            width: screenW(340),
                            child: FloatingActionButton.extended(
                              icon: Icon(Icons.done, color: Colors.white,),
                              elevation: screenH(5),
                              onPressed: () {
                                print(socialEvents.length);
                                _controller.push(context, socialAtEvent());
                              },
                              backgroundColor: Color(0xFF8803fc),
                              label: Text(
                                "  I'm at an event",
                                style: TextStyle(fontSize: screenF(20), color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]);
                  })
            ])
          ],
        ),
      ),
    );
  }
}

class SocialEventCard extends StatelessWidget {
  final CircularSplashController _controller = CircularSplashController(
    color: Color(0xFF1976d2), //optional, default is White.
    duration: Duration(milliseconds: 350), //optional.
  );
  final String eventName, location, day, time, month;

  SocialEventCard({
    this.eventName,
    this.location,
    this.day,
    this.month,
    this.time,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: screenH(35.0)),
          child: Container(
            margin: EdgeInsets.only(left: 10),
            width: screenW(50),
            height: screenH(70),
            child: Column(
              children: <Widget>[
                Text(this.day,
                    style: TextStyle(
                        fontSize: screenF(25), fontWeight: FontWeight.bold)),
                Text(this.month,
                    style: TextStyle(
                      fontSize: screenF(10),
                    )),
              ],
            ),
          ),
        ),
        Container(
            height: screenH(170),
            width: screenW(340),
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
                                    color: Color(0xFF8803fc),
                                  )),
                              Text(location,
                                  style: TextStyle(
                                    fontSize: screenF(13),
                                  )),
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
                                          this.time,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    // this.food == "true"
                                    //     ? Icon(
                                    //         MaterialCommunityIcons.food,
                                    //         color: Color(0xFF1976d2),
                                    //         size: screenW(25),
                                    //       )
                                    //     : SizedBox(
                                    //         width: screenW(25),
                                    //       ),
                                    // SizedBox(
                                    //   width: screenW(20),
                                    // ),
                                    // this.swag == "true"
                                    //     ? Icon(
                                    //         MaterialCommunityIcons.sunglasses,
                                    //         color: Color(0xFF1976d2),
                                    //         size: screenW(25),
                                    //       )
                                    //     : SizedBox(
                                    //         width: screenW(25),
                                    //       ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: screenW(20)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFF8803fc),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                  blurRadius: (10),
                                                  spreadRadius: (1),
                                                  offset: Offset(0, 5)),
                                            ],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: screenH(8.0),
                                              horizontal: screenW(15.0)),
                                          child: Text(
                                            "VIEW",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: screenF(15),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
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
