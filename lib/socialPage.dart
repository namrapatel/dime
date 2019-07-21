import 'package:Dime/socialPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sticky_infinite_list/sticky_infinite_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;

class SocialPage extends StatefulWidget {
  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
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
                      "Social Card",
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
                        Navigator.pop(context);
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
          Column(children: <Widget>[
            Stack(children: <Widget>[
              Container(
                height: screenH(525),
                width: screenW(400),
                child: InfiniteList(
                    controller: ScrollController(),
                    direction: InfiniteListDirection.multi,
                    minChildCount: -100,
                    maxChildCount: 100,

                    /// ViewPort anchor value. See [ScrollView] docs for more info
                    anchor: 0.0,
                    builder: (BuildContext context, int index) {
                      /// Builder requires [InfiniteList] to be returned
                      return InfiniteListItem(
                        // headerStateBuilder:
                        //     (BuildContext context, StickyState<int> state) {
                        //   return Container(
                        //     alignment: Alignment.center,
                        //     width: 50,
                        //     height: 50,
                        //     child: Text("Header $index"),
                        //     color: Colors.orange.withOpacity(state.position),
                        //   );
                        // },

                        /// This is just example
                        ///
                        /// In you application you should use or
                        /// [headerBuilder] or [headerStateBuilder],
                        /// but not both
                        ///
                        /// If both is specified, this invoker will be ignored
                        headerBuilder: (BuildContext context) {
                          return Padding(
                            padding: EdgeInsets.only(top: screenH(20.0)),
                            child: Container(
                              alignment: Alignment.center,
                              width: screenW(50),
                              height: screenH(70),
                              child: Column(
                                children: <Widget>[
                                  Text("$index",
                                      style: TextStyle(
                                          fontSize: screenF(25),
                                          fontWeight: FontWeight.bold)),
                                  Text("July",
                                      style: TextStyle(
                                        fontSize: screenF(15),
                                      )),
                                ],
                              ),
                            ),
                          );
                        },
                        contentBuilder: (BuildContext context) {
                          return Row(
                            children: <Widget>[
                              SizedBox(
                                width: screenH(80),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: screenH(20.0)),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenH(15)),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.grey.withOpacity(0.5),
                                      //     offset: const Offset(0.0, 0.0),
                                      //   ),
                                      //   BoxShadow(
                                      //     color: Colors.grey[200],
                                      //     offset: const Offset(0.0, 0.0),
                                      //     spreadRadius: -3.0,
                                      //     blurRadius: 15.0,
                                      //   ),
                                      // ],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  height: screenH(200),
                                  width: screenW(310),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: screenW(15.0)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text("Kappa Beta Phi House Party",
                                                style: TextStyle(
                                                    fontSize: screenF(16),
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF8803fc))),
                                            Text("84 Richmond Street",
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
                                                scrollDirection:
                                                    Axis.horizontal,
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenH(25),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: screenW(2.0)),
                                              child: Row(
                                                children: <Widget>[
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        "Time",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                          );
                        },
                        /// Min offset after which it
                        /// should stick to the bottom edge
                        /// of container
                        minOffsetProvider: (StickyState<int> state) => 50,

                        /// Header alignment
                        ///
                        /// Currently it supports top left,
                        /// top right, bottom left and bottom right alignments
                        ///
                        /// By default [HeaderAlignment.topLeft]
                        headerAlignment: HeaderAlignment.topLeft,
                      );
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
                      onPressed: () {},
                      backgroundColor: Color(0xFF8803fc),
                      label: Text(
                        "  I'm at an event",
                        style: TextStyle(fontSize: screenF(20)),
                      ),
                    ),
                  ),
                ),
              ),
            ])
          ])
        ],
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
