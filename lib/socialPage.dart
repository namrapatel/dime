import 'package:Dime/profPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sticky_infinite_list/sticky_infinite_list.dart';

class SocialPage extends StatefulWidget {
  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(children: <Widget>[
            Container(
              color: Colors.purple[400],
              height: 330,
              width: 380,
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Social Card",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 190,
                    ),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.white,
                      iconSize: 25,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  width: 335,
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
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Namra Patel",
                                  style: TextStyle(
                                    fontSize: 17,
                                  )),
                              SizedBox(
                                height: 2,
                              ),
                              Text("University of Western Ontario",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.purple)),
                              SizedBox(
                                height: 2,
                              ),
                              Text("Computer Science, 2022",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                          SizedBox(
                            width: 85,
                          ),
                          CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/namrapatel.png"),
                            radius: 22,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              FontAwesome.snapchat_square,
                              color: Color(0xFFfffc00),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("namrapatel9",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12)),
                            SizedBox(
                              width: 50,
                            ),
                            Icon(
                              MaterialCommunityIcons.instagram,
                              color: Colors.purple,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("namrajpatel",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 65,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              Text("Relationship Status:",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Single",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ]),
          Column(children: <Widget>[
            Container(
              height: 482,
              width: 400,
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
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            alignment: Alignment.center,
                            width: 50,
                            height: 50,
                            child: Column(
                              children: <Widget>[
                                Text("$index",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                                Text("July",
                                    style: TextStyle(
                                      fontSize: 15,
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
                              width: 80,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        offset: const Offset(0.0, 0.0),
                                      ),
                                      BoxShadow(
                                        color: Colors.grey[200],
                                        offset: const Offset(0.0, 0.0),
                                        spreadRadius: -3.0,
                                        blurRadius: 15.0,
                                      ),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                height: 160,
                                width: 270,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Kappa Beta Phi House Party",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.purple)),
                                          Text("84 Richmond Street",
                                              style: TextStyle(
                                                fontSize: 12,
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            height: 40,
                                            child: ListView(
                                              children: memberAvatars,
                                              scrollDirection: Axis.horizontal,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "Time",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
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
                                                width: 120,
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
            )
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
        width: 40,
        child: CircleAvatar(
          backgroundImage: AssetImage(memberImage),
          radius: 15,
        ),
      ),
    );
  }
}
