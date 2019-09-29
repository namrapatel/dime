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
  final String userId, type;
  String userName;
  bool liked = false;
  bool likedBack = false;
  bool noPosts = false;
  Firestore firestore = Firestore.instance;
  List<Widget> products = [];
  bool isLoading = false;
  bool hasMore = true;
  bool noLikes = false;
  int documentLimit = 3;
  String firstName;
  DocumentSnapshot lastDocument;
  ScrollController _scrollController = ScrollController();
  _UserCardState(this.userId, this.type, this.userName);

  final screenH = ScreenUtil.instance.setHeight;
  final screenW = ScreenUtil.instance.setWidth;
  final screenF = ScreenUtil.instance.setSp;

  @override
  void initState() {
    getLikeStatus();
    super.initState();

    getName();

    getRecentActivity();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        getRecentActivity();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  getName() async {
    if (userName == null) {
      DocumentSnapshot doc =
          await Firestore.instance.collection('users').document(userId).get();
      setState(() {
        userName = doc['displayName'];
      });
    }

    if (userName.contains(" ")) {
      var string = userName.split(" ");
      setState(() {
        firstName = string[0];
      });

      print('in second');
    } else {
      setState(() {
        firstName = "User";
      });

      print('in third');
    }

    print(userName);
  }

  getLikeStatus() async {
    DocumentSnapshot document =
        await Firestore.instance.collection('users').document(userId).get();
    if (document['likedBy'].contains(currentUserModel.uid)) {
      setState(() {
        liked = true;
      });
    }
    DocumentSnapshot myDoc = await Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .get();
    if (myDoc['likedBy'].contains(userId)) {
      setState(() {
        likedBack = true;
      });
    }
  }

  getRecentActivity() async {
    if (!hasMore) {
//
      return;
    }
    if (isLoading) {
      return;
    }
    if (products.length != 0) {
      setState(() {
        isLoading = true;
      });
    }
    QuerySnapshot qn;
    List<Widget> posts = [];
    if (lastDocument == null) {
      qn = await Firestore.instance
          .collection('users')
          .document(userId)
          .collection('recentActivity')
          .orderBy('timeStamp', descending: true)
          .limit(documentLimit)
          .getDocuments();

      if (qn.documents.length == 0 || qn == null) {
        setState(() {
          noPosts = true;
        });
      }
    } else {
      qn = await Firestore.instance
          .collection('users')
          .document(userId)
          .collection('recentActivity')
          .orderBy('timeStamp', descending: true)
          .startAfterDocument(lastDocument)
          .limit(documentLimit)
          .getDocuments();
      if (qn.documents.length == 0 || qn == null) {
        setState(() {
          hasMore = false;
          isLoading = false;
        });
      }
    }
    for (int i = 0; i < qn.documents.length; i++) {
//      posts.add(createPost(qn.documents[i],i,qn.documents[i]['type']));
      DocumentSnapshot doc;
      if (qn.documents[i]['type'] == "social") {
        doc = await Firestore.instance
            .collection('socialPosts')
            .document(qn.documents[i]['postId'])
            .get();
      } else if (qn.documents[i]['type'] == "party") {
        doc = await Firestore.instance
            .collection('partyPosts')
            .document(qn.documents[i]['postId'])
            .get();
      } else {
        doc = await Firestore.instance
            .collection('streams')
            .document(qn.documents[i]['stream'])
            .collection('posts')
            .document(qn.documents[i]['postId'])
            .get();
//        return ProfPost.fromDocument(doc);
      }
      if (doc != null) {
        posts.add(Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  qn.documents[i]['upvoted'] == true &&
                          qn.documents[i]['commented'] == true
                      ? Text(
                          firstName + " upvoted and commented",
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(
                          qn.documents[i]['upvoted'] == true
                              ? firstName + " upvoted"
                              : firstName + " commented",
                          style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            (qn.documents[i]['type'] == "social" ||
                    qn.documents[i]['type'] == "party")
                ? SocialPost.fromDocument(doc)
                : ProfPost.fromDocument(doc)
          ],
        ));
      } else {
        i++;
      }
    }
    if (qn.documents.length < documentLimit) {
      hasMore = false;
    }
    if (qn.documents.length != 0) {
      lastDocument = qn.documents[qn.documents.length - 1];
    }
    products.addAll(posts);
    setState(() {
      isLoading = false;
    });

//    return docs;
  }

  @override
  Widget build(BuildContext context) {
//    String firstName = string[0];

    Future<Widget> createPost(
        DocumentSnapshot snap, int index, String postType) async {
      DocumentSnapshot doc;
      if (postType == "social") {
        doc = await Firestore.instance
            .collection('socialPosts')
            .document(snap.data[index].data['postId'])
            .get();
      } else if (postType == "party") {
        doc = await Firestore.instance
            .collection('partyPosts')
            .document(snap.data[index].data['postId'])
            .get();
      } else {
        doc = await Firestore.instance
            .collection('streams')
            .document(snap.data[index].data['stream'])
            .collection('posts')
            .document(snap.data[index].data['postId'])
            .get();
//        return ProfPost.fromDocument(doc);
      }
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            snap.data[index].data['upvoted'] == true &&
                    snap.data[index].data['commented'] == true
                ? Text(
                    firstName + " upvoted and commented",
                    style: TextStyle(color: Colors.white),
                  )
                : Text(
                    snap.data[index].data['upvoted'] == true
                        ? firstName + " upvoted"
                        : firstName + " commented",
                    style: TextStyle(color: Colors.white)),
            (type == "social" || type == "party")
                ? SocialPost.fromDocument(doc)
                : ProfPost.fromDocument(doc)
          ],
        ),
      );
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
                  child: userName != null
                      ? AutoSizeText(
                          userName,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          minFontSize: 12,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : Center(child: CircularProgressIndicator())),
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
                      (liked == true && likedBack == true)
                          ? IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => Chat(
                                              toUserId: userId,
                                              fromUserId: currentUserModel.uid,
                                            )));
                              },
                              icon: Icon(
                                Feather.message_circle,
                                size: screenH(25),
                                color: Colors.white,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                if (liked == false) {
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
                                                      setState(() {
                                                        liked = true;
                                                      });
                                                      // SHEHABBBB BACKEND CODE FOR CASUAL LIKE GOES HERE, FLUSHBAR IS ALREADY ADDED
                                                      Flushbar(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 15,
                                                                vertical: 5),
                                                        borderRadius: 15,
                                                        messageText: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
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
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(
                                                                "A casual" +
                                                                    " like has been sent to ",
                                                                // widget.contactName,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        backgroundColor:
                                                            Colors.white,
                                                        flushbarPosition:
                                                            FlushbarPosition
                                                                .TOP,
                                                        icon: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  15, 8, 8, 8),
                                                          child: Icon(
                                                            Icons.info_outline,
                                                            size: 28.0,
                                                            color: Color(
                                                                0xFF1458EA),
                                                          ),
                                                        ),
                                                        duration: Duration(
                                                            seconds: 3),
                                                      )..show(context);
                                                      Firestore.instance
                                                          .collection('users')
                                                          .document(userId)
                                                          .collection('likes')
                                                          .document(
                                                              currentUserModel
                                                                  .uid)
                                                          .setData({
                                                        'likeType': 'social',
                                                        'liked': false,
                                                        'timestamp':
                                                            Timestamp.now(),
                                                        'unread': false
                                                      });

                                                      List<String> newId = [];
                                                      newId.add(
                                                          currentUserModel.uid);

                                                      Firestore.instance
                                                          .collection('users')
                                                          .document(userId)
                                                          .updateData({
                                                        'likedBy': FieldValue
                                                            .arrayUnion(newId),
                                                      });

                                                      List<String> newUserId =
                                                          [];
                                                      newUserId.add(userId);
                                                      Firestore.instance
                                                          .collection('users')
                                                          .document(
                                                              currentUserModel
                                                                  .uid)
                                                          .updateData({
                                                        "likedUsers": FieldValue
                                                            .arrayUnion(
                                                                newUserId)
                                                      });

                                                      Firestore.instance
                                                          .collection(
                                                              'likeNotifs')
                                                          .add({
                                                        'toUser': userId,
                                                        'fromUser':
                                                            currentUserModel
                                                                .uid,
                                                        "likeType": 'social'
                                                      });
                                                    }),
                                                CupertinoActionSheetAction(
                                                  child: const Text('Network'),
                                                  onPressed: () {
                                                    setState(() {
                                                      liked = true;
                                                    });
                                                    // SHEHABBBB BACKEND CODE FOR CASUAL LIKE GOES HERE, FLUSHBAR IS ALREADY ADDED
                                                    Flushbar(
                                                      margin:
                                                          EdgeInsets.symmetric(
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
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              "A network" +
                                                                  " like has been sent to ",
                                                              // widget.contactName,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      backgroundColor:
                                                          Colors.white,
                                                      flushbarPosition:
                                                          FlushbarPosition.TOP,
                                                      icon: Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                15, 8, 8, 8),
                                                        child: Icon(
                                                          Icons.info_outline,
                                                          size: 28.0,
                                                          color:
                                                              Color(0xFF1458EA),
                                                        ),
                                                      ),
                                                      duration:
                                                          Duration(seconds: 3),
                                                    )..show(context);

                                                    Firestore.instance
                                                        .collection('users')
                                                        .document(userId)
                                                        .collection('likes')
                                                        .document(
                                                            currentUserModel
                                                                .uid)
                                                        .setData({
                                                      'likeType': 'prof',
                                                      'liked': false,
                                                      'timestamp':
                                                          Timestamp.now(),
                                                      'unread': false
                                                    });

                                                    List<String> newId = [];
                                                    newId.add(
                                                        currentUserModel.uid);

                                                    Firestore.instance
                                                        .collection('users')
                                                        .document(userId)
                                                        .updateData({
                                                      'likedBy':
                                                          FieldValue.arrayUnion(
                                                              newId),
                                                    });

                                                    List<String> newUserId = [];
                                                    newUserId.add(userId);
                                                    Firestore.instance
                                                        .collection('users')
                                                        .document(
                                                            currentUserModel
                                                                .uid)
                                                        .updateData({
                                                      "likedUsers":
                                                          FieldValue.arrayUnion(
                                                              newUserId)
                                                    });

                                                    Firestore.instance
                                                        .collection(
                                                            'likeNotifs')
                                                        .add({
                                                      'toUser': userId,
                                                      'fromUser':
                                                          currentUserModel.uid,
                                                      "likeType": 'prof'
                                                    });
                                                  },
                                                )
                                              ],
                                              cancelButton:
                                                  CupertinoActionSheetAction(
                                                child: const Text('Cancel'),
                                                isDefaultAction: true,
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context, 'Cancel');
                                                },
                                              )));
                                }
                              },
                              icon: liked == false
                                  ? Icon(
                                      AntDesign.like2,
                                      size: screenH(25),
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      AntDesign.like1,
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
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: products.length == 0
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              controller: _scrollController,
                              //  shrinkWrap: true,
                              //  cacheExtent: 5000.0,
                              //  physics: BouncingScrollPhysics(),
                              itemCount: products.length,
                              itemBuilder: (_, index) {
                                return products[index];

//                           DocumentSnapshot doc;
//      if (postType == "social") {
//        doc = await Firestore.instance
//            .collection('socialPosts')
//            .document(snap.data[index].data['postId'])
//            .get();
//      } else if (postType == "party") {
//        doc = await Firestore.instance
//            .collection('partyPosts')
//            .document(snap.data[index].data['postId'])
//            .get();
//      } else {
//        doc = await Firestore.instance
//            .collection('streams')
//            .document(snap.data[index].data['stream'])
//            .collection('posts')
//            .document(snap.data[index].data['postId'])
//            .get();
////        return ProfPost.fromDocument(doc);
//      }
//      return Padding(
//        padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.end,
//          children: <Widget>[
//            snap.data[index].data['upvoted'] == true &&
//                    snap.data[index].data['commented'] == true
//                ? Text(
//                    firstName + " upvoted and commented",
//                    style: TextStyle(color: Colors.white),
//                  )
//                : Text(
//                    snap.data[index].data['upvoted'] == true
//                        ? firstName + " upvoted"
//                        : firstName + " commented",
//                    style: TextStyle(color: Colors.white)),
//            (type == "social" || type == "party")
//                ? SocialPost.fromDocument(doc)
//                : ProfPost.fromDocument(doc)
//          ],
//        ),
//      );
                              }),
                    ),
                    isLoading
                        ? Container(child: CircularProgressIndicator())
                        : Container()
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
