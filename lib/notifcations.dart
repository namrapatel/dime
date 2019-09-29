import 'package:Dime/chatList.dart';
import 'package:Dime/homePage.dart';
import 'package:Dime/models/notifModel.dart';
import 'package:Dime/models/largerPic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'homePage.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_size_text/auto_size_text.dart';

class NotifcationsScreen extends StatefulWidget {
  @override
  _NotifcationsScreenState createState() => _NotifcationsScreenState();
}

class _NotifcationsScreenState extends State<NotifcationsScreen> {
  Firestore firestore = Firestore.instance;
  List<LikeNotif> notifs = [];
  bool isLoading = false;
  bool hasMore = true;
  bool noLikes = false;
  int documentLimit = 6;
  DocumentSnapshot lastDocument;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    getUnreadMessages();
    getNumberOfChatsLikes();
    getNotifs();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        getNotifs();
      }
    });
    super.initState();
  }

  int unread = 0;
  int numberOfChats = 0;
  int numberOfLikes = 0;

  getNumberOfChatsLikes() async {
    DocumentSnapshot doc = await Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .get();
    setState(() {
      numberOfLikes = doc['likedBy'].length;
    });
    QuerySnapshot query = await Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .collection('messages')
        .getDocuments();
    setState(() {
      numberOfChats = query.documents.length;
    });
  }

  getUnreadMessages() async {
    QuerySnapshot query = await Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .collection('messages')
        .where('unread', isEqualTo: true)
        .getDocuments();
    setState(() {
      unread = query.documents.length;
    });
  }

  getNotifs() async {
    if (!hasMore) {
      print('done');

      return;
    }
    if (isLoading) {
      return;
    }
    if (notifs.length != 0) {
      setState(() {
        isLoading = true;
      });
    }
    List<LikeNotif> userDocuments = [];
    QuerySnapshot querySnapshot;
    if (lastDocument == null) {
      querySnapshot = await Firestore.instance
          .collection('users')
          .document(currentUserModel.uid)
          .collection('likes')
          .orderBy('timestamp', descending: true)
          .limit(documentLimit)
          .getDocuments();
      if (querySnapshot.documents.length == 0 || querySnapshot == null) {
        setState(() {
          noLikes = true;
        });
      }
    } else {
      querySnapshot = await Firestore.instance
          .collection('users')
          .document(currentUserModel.uid)
          .collection('likes')
          .orderBy('timestamp', descending: true)
          .startAfterDocument(lastDocument)
          .limit(documentLimit)
          .getDocuments();
      if (querySnapshot.documents.length == 0 || querySnapshot == null) {
        setState(() {
          hasMore = false;
          isLoading = false;
        });
      }
    }
    for (var document in querySnapshot.documents) {
      DocumentSnapshot doc = await Firestore.instance
          .collection('users')
          .document(document.documentID)
          .get();
      var storedDate = document.data['timestamp'];
      String elapsedTime = timeago.format(storedDate.toDate());
      String timestamp = '$elapsedTime';
      Firestore.instance
          .collection('users')
          .document(currentUserModel.uid)
          .collection('likes')
          .document(document.documentID)
          .updateData({'unread': false});
      userDocuments.add(new LikeNotif(
        verified: doc['verified'],
        timestamp: timestamp,
        id: doc.documentID,
        name: doc['displayName'],
        major: doc['major'],
        university: doc['university'],
        bio: doc['bio'],
        gradYear: doc['gradYear'],
        liked: document['liked'],
        type: document['likeType'],
        relationshipStatus: doc['relationshipStatus'],
        photo: doc['photoUrl'],
      ));
//      userDocuments.add(userDoc);

    }
    notifs.addAll(userDocuments);
    if (querySnapshot.documents.length < documentLimit) {
      hasMore = false;
    }
    lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];
    setState(() {
      isLoading = false;
    });
//    print('length of docs' + userDocuments.length.toString());
//    return userDocuments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height / 30,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 28,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 50,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => ScrollPage(
                              social: true,
                            )));
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.grey[100],
                ),
                child: Stack(children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => ChatList()));
                    },
                    icon: Icon(
                      Feather.message_circle,
                      size: screenH(27),
                      color: Colors.black,
                    ),
                  ),
                  unread > 0
                      ? Positioned(
                          top: MediaQuery.of(context).size.height / 70,
                          left: MediaQuery.of(context).size.width / 13,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => LargePic(
                                            largePic: 'photoUrl',
                                          )));
                            },
                            child: CircleAvatar(
                              child: Text(
                                unread.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              ),
                              backgroundColor: Colors.red,
                              radius: 8.2,
                            ),
                          ))
                      : SizedBox(
                          height: 0.0,
                        )
                ]))
          ],
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width / 17,
                  0,
                  0,
                  MediaQuery.of(context).size.height / 7),
            ),
            Text(
              "Notifications",
              style: TextStyle(
                fontSize: screenF(40),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width / 17, 0, 0, 0),
          child: Row(
            children: <Widget>[
              Text(
                numberOfLikes != null
                    ? numberOfLikes.toString() + " Likes"
                    : "",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 50,
              ),
              Text("•"),
              SizedBox(
                width: MediaQuery.of(context).size.width / 50,
              ),
              Text(
                numberOfChats != null
                    ? numberOfChats.toString() + " Chats"
                    : "",
                style: TextStyle(fontSize: 18),
              ),
              numberOfLikes != null && numberOfChats != null
                  ? IconButton(
                      icon: Icon(
                        Icons.info_outline,
                        color: Color(0xFF1458EA),
                      ),
                      onPressed: () {
                        Flushbar(
                          margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          borderRadius: 15,
                          messageText: Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "You have recieved " +
                                      numberOfLikes.toString() +
                                      " anonymous likes, and chosen to chat with " +
                                      numberOfChats.toString() +
                                      " people!",
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          backgroundColor: Colors.white,
                          flushbarPosition: FlushbarPosition.TOP,
                          icon: Padding(
                            padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                            child: Icon(
                              Icons.info_outline,
                              size: 28.0,
                              color: Color(0xFF1458EA),
                            ),
                          ),
                          duration: Duration(seconds: 5),
                        )..show(context);
                      },
                    )
                  : SizedBox(
                      width: 0.0,
                    )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 50,
        ),
        Container(
          height: MediaQuery.of(context).size.height / 1.67,
          child: Column(
            children: <Widget>[
              Expanded(
                  child: noLikes
                      ? Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20.0,
                            ),
                            Image.asset(
                                'assets/img/undraw_peoplearoundyou.png'),
                            Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.height / 20),
                              child: Text(
                                "You don't have any likes right now. \n Check out people around you to like some people!",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        )
                      : notifs.length == 0
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              controller: _scrollController,
//              cacheExtent: 5000.0,
                              itemCount: notifs.length,
//              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return notifs[index];
                              })),
              isLoading
                  ? Container(child: CircularProgressIndicator())
                  : Container()
            ],
          ),

//          child: ListView(
//            physics: BouncingScrollPhysics(),
//            children: <Widget>[
//              FutureBuilder(
//                  future: getNotifs(),
//                  builder: (context, snapshots) {
//                    if (!snapshots.hasData) {
//                      return Container(
//                          alignment: FractionalOffset.center,
//                          child: CircularProgressIndicator());
//                    } else {
//                      print(snapshots.data.length);
//                      print('ength is above');
//                      return (snapshots.data.length == 0)
//                          ? Column(
//                              children: <Widget>[
//                                SizedBox(
//                                  height: 20.0,
//                                ),
//                                Image.asset(
//                                    'assets/img/undraw_peoplearoundyou.png'),
//                                Padding(
//                                  padding: EdgeInsets.all(
//                                      MediaQuery.of(context).size.height / 20),
//                                  child: Text(
//                                    "There's nobody around. \n Go get a walk in and find some new people!",
//                                    textAlign: TextAlign.center,
//                                    style: TextStyle(fontSize: 20),
//                                  ),
//                                ),
//                              ],
//                            )
//                          : Container(
//                              child: Column(children: snapshots.data),
//                            );
//                    }
//                  })
//            ],
//          ),
        ),
      ],
    ));
  }
}
