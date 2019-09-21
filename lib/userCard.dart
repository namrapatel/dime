import 'package:Dime/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'viewCards.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'models/profPost.dart';
import 'models/socialPost.dart';
import 'login.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat.dart';
import 'package:flushbar/flushbar.dart';

class UserCard extends StatefulWidget {
  const UserCard({this.userId, this.type, this.userName});

  final String userId, type, userName;

  @override
  _UserCardState createState() =>
      _UserCardState(this.userId, this.type, this.userName);
}

class _UserCardState extends State<UserCard> {
  final String userId, type, userName;

  _UserCardState(this.userId, this.type, this.userName);

  final screenH = ScreenUtil.instance.setHeight;
  final screenW = ScreenUtil.instance.setWidth;
  final screenF = ScreenUtil.instance.setSp;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getRecentActivity() async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('users')
        .document(userId)
        .collection('recentActivity')
        .orderBy('timeStamp', descending: true)
        .getDocuments();
    final docs = querySnapshot.documents;

    return docs;
  }

  @override
  Widget build(BuildContext context) {
    String firstName;
    if (userName != null && userName.contains(" ")) {
      var string = userName.split(" ");
      firstName = string[0];
    } else {
      firstName = "User";
    }
//    String firstName = string[0];

    Future<Widget> createPost(
        AsyncSnapshot<dynamic> snap, int index, String postType) async {
      if (postType == "social") {
        DocumentSnapshot doc = await Firestore.instance
            .collection('socialPosts')
            .document(snap.data[index].data['postId'])
            .get();
        return SocialPost.fromDocument(doc);
      } else {
        DocumentSnapshot doc = await Firestore.instance
            .collection('streams')
            .document(snap.data[index].data['stream'])
            .collection('posts')
            .document(snap.data[index].data['postId'])
            .get();
        return ProfPost.fromDocument(doc);
      }
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF1458EA),
          title: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 3.1,
                child: AutoSizeText(
                  userName,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  minFontSize: 12,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Spacer(),
              // IconButton(
              //   icon: Icon(
              //     Feather.message_circle,
              //   ),
              //   color: Colors.white,
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         CupertinoPageRoute(
              //             builder: (context) => Chat(
              //                 fromUserId: currentUserModel.uid,
              //                 toUserId: userId)));
              //   },
              // ),
              currentUserModel.uid != userId
                  ? Row(children: <Widget>[
                      IconButton(
                          onPressed: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) =>
                                    CupertinoActionSheet(
                                        title: const Text(
                                            'What type of like do you want to send?'),
                                        actions: <Widget>[
                                          CupertinoActionSheetAction(
                                              child: const Text('Casual'),
                                              onPressed: () {
                                                // SHEHABBBB BACKEND CODE FOR CASUAL LIKE GOES HERE, FLUSHBAR IS ALREADY ADDED
                                                Flushbar(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 5),
                                                  borderRadius: 15,
                                                  messageText: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 0, 0, 0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          "Done",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          "A casual" +
                                                              " like has been sent to ",
                                                          // widget.contactName,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  backgroundColor: Colors.white,
                                                  flushbarPosition:
                                                      FlushbarPosition.TOP,
                                                  icon: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 8, 8, 8),
                                                    child: Icon(
                                                      Icons.info_outline,
                                                      size: 28.0,
                                                      color: Color(0xFF1458EA),
                                                    ),
                                                  ),
                                                  duration:
                                                      Duration(seconds: 3),
                                                )..show(context);
                                              }),
                                          CupertinoActionSheetAction(
                                            child: const Text('Network'),
                                            onPressed: () {
                                              // SHEHABBBB BACKEND CODE FOR CASUAL LIKE GOES HERE, FLUSHBAR IS ALREADY ADDED
                                              Flushbar(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 5),
                                                borderRadius: 15,
                                                messageText: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      15, 0, 0, 0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        "Done",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "A network" +
                                                            " like has been sent to ",
                                                        // widget.contactName,
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                backgroundColor: Colors.white,
                                                flushbarPosition:
                                                    FlushbarPosition.TOP,
                                                icon: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      15, 8, 8, 8),
                                                  child: Icon(
                                                    Icons.info_outline,
                                                    size: 28.0,
                                                    color: Color(0xFF1458EA),
                                                  ),
                                                ),
                                                duration: Duration(seconds: 3),
                                              )..show(context);
                                            },
                                          )
                                        ],
                                        cancelButton:
                                            CupertinoActionSheetAction(
                                          child: const Text('Cancel'),
                                          isDefaultAction: true,
                                          onPressed: () {
                                            Navigator.pop(context, 'Cancel');
                                          },
                                        )));
                          },
                          icon: Icon(
                            AntDesign.like2,
                            size: screenH(25),
                            color: Colors.white,
                          )),
                      IconButton(
                          icon: Icon(Feather.more_vertical),
                          color: Colors.white,
                          onPressed: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) =>
                                    CupertinoActionSheet(
                                        title: const Text(
                                            'What would you like to do?'),
                                        actions: <Widget>[
                                          CupertinoActionSheetAction(
                                              child: const Text('Block'),
                                              onPressed: () {
                                                List<String> blockedId = [];
                                                blockedId.add(userId);
                                                Firestore.instance
                                                    .collection('users')
                                                    .document(
                                                        currentUserModel.uid)
                                                    .setData({
                                                  'blocked$userId': true,
                                                  'blocked':
                                                      FieldValue.arrayUnion(
                                                          blockedId)
                                                }, merge: true);

                                                List<String> blocked = [];
                                                blocked
                                                    .add(currentUserModel.uid);
                                                Firestore.instance
                                                    .collection('users')
                                                    .document(userId)
                                                    .setData({
                                                  'blocked${currentUserModel.uid}':
                                                      true,
                                                  'blockedby':
                                                      FieldValue.arrayUnion(
                                                          blocked)
                                                }, merge: true);

                                                Firestore.instance
                                                    .collection('users')
                                                    .document(
                                                        currentUserModel.uid)
                                                    .collection('messages')
                                                    .document(userId)
                                                    .setData({'blocked': true},
                                                        merge: true);

                                                Firestore.instance
                                                    .collection('users')
                                                    .document(userId)
                                                    .collection('messages')
                                                    .document(
                                                        currentUserModel.uid)
                                                    .setData({'blocked': true},
                                                        merge: true);
                                                Navigator.push(
                                                    context,
                                                    CupertinoPageRoute(
                                                        builder: (context) =>
                                                            ScrollPage(
                                                                social: true)));
                                                Flushbar(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 5),
                                                  borderRadius: 15,
                                                  messageText: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 0, 0, 0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          "Done",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          "This user has been blocked.",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  backgroundColor: Colors.white,
                                                  flushbarPosition:
                                                      FlushbarPosition.TOP,
                                                  icon: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 8, 8, 8),
                                                    child: Icon(
                                                      Icons.info_outline,
                                                      size: 28.0,
                                                      color: Color(0xFF1458EA),
                                                    ),
                                                  ),
                                                  duration:
                                                      Duration(seconds: 3),
                                                )..show(context);
                                              }),
                                          CupertinoActionSheetAction(
                                            child: const Text('Report'),
                                            onPressed: () {
                                              // ADD REPORT FUNCTIONALITY HERE
                                              List<String> id = [];
                                              id.add(currentUserModel.uid);
                                              Firestore.instance
                                                  .collection('reportedUsers')
                                                  .document(userId)
                                                  .setData({
                                                'userID': userId,
                                                'userName': userName,
                                                'reporterIDs':
                                                    FieldValue.arrayUnion(id),
                                              }, merge: true);

                                              Flushbar(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 5),
                                                borderRadius: 15,
                                                messageText: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      15, 0, 0, 0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        "Done",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "Our team will review this user's recent activity as per your report.",
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                backgroundColor: Colors.white,
                                                flushbarPosition:
                                                    FlushbarPosition.TOP,
                                                icon: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      15, 8, 8, 8),
                                                  child: Icon(
                                                    Icons.info_outline,
                                                    size: 28.0,
                                                    color: Color(0xFF1458EA),
                                                  ),
                                                ),
                                                duration: Duration(seconds: 3),
                                              )..show(context);
                                            },
                                          )
                                        ],
                                        cancelButton:
                                            CupertinoActionSheetAction(
                                          child: const Text('Cancel'),
                                          isDefaultAction: true,
                                          onPressed: () {
                                            Navigator.pop(context, 'Cancel');
                                          },
                                        )));
                          })
                    ])
                  : Container()
            ],
          ),
        ),
        backgroundColor: Color(0xFF1458EA),
        body: Stack(
          children: <Widget>[
            ListView(
              padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 20,
                      MediaQuery.of(context).size.height / 18,
                      0,
                      0),
                  child: Align(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: ViewCards(
                          userId: userId,
                          type: 'social',
                        )),
                      ],
                    ),
                    alignment: Alignment.topCenter,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 35,
                      MediaQuery.of(context).size.height / 18,
                      0,
                      0),
                  child: Align(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: ViewCards(
                          userId: userId,
                          type: 'prof',
                        )),
                      ],
                    ),
                    alignment: Alignment.topCenter,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width / 20,
                  MediaQuery.of(context).size.height / 2.6,
                  0,
                  0),
              child: Text(
                "Recent Activity",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenF(17),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height / 2.4, 0, 0),
                child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: FutureBuilder(
                        future: getRecentActivity(),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: Text("loading..."));
                          } else if (snapshot.data.length == 0) {
                            return Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/img/improvingDrawing.png',
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  width: MediaQuery.of(context).size.height / 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    "Interactions from the feeds will show up here!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenF(19),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            String action;

                            return ListView.builder(
                                cacheExtent: 5000.0,
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot?.data?.length,
                                itemBuilder: (_, index) {
                                  return Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 15, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            snapshot.data[index]
                                                            .data['upvoted'] ==
                                                        true &&
                                                    snapshot.data[index].data[
                                                            'commented'] ==
                                                        true
                                                ? Text(
                                                    firstName +
                                                        " upvoted and commented",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                : Text(
                                                    snapshot.data[index].data[
                                                                'upvoted'] ==
                                                            true
                                                        ? firstName + " upvoted"
                                                        : firstName +
                                                            " commented",
                                                    style: TextStyle(
                                                        color: Colors.white))
                                          ],
                                        ),
                                      ),
                                      FutureBuilder(
                                          future: snapshot.data[index]
                                                      .data['type'] ==
                                                  'social'
                                              ? createPost(
                                                  snapshot, index, 'social')
                                              : createPost(
                                                  snapshot, index, 'prof'),
                                          builder: (_, snap) {
                                            if (snap.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else {
                                              return Container(
                                                child: snap.data,
                                              );
                                            }
                                          }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  );
                                });
                          }
                        }))),
          ],
        ));
  }
}
