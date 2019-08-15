import 'package:Dime/profComments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import '../viewCards.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Dime/homePage.dart';
import 'package:Dime/socialComments.dart';
import 'package:page_transition/page_transition.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:Dime/login.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProfPost extends StatefulWidget {
  final String postId;
// final  String caption;
// final String postPic;
// final int comments;
// final String timeStamp;
// final int upVotes ;
// final List<dynamic> likes;

  const ProfPost({this.postId});
  @override
  _ProfPostState createState() => _ProfPostState();
}

class _ProfPostState extends State<ProfPost> {
  List<dynamic> likes;
//  String postId;
  String caption;
  String postPic;
  int comments;
  String timeStamp;
  int upVotes;
  String university;
  bool liked = false;

  String name = currentUserModel.displayName;

  @override
  void initState() {
    super.initState();
    getPostInfo();
    print(caption);
  }

  getPostInfo() async {
    DocumentSnapshot doc = await Firestore.instance
        .collection('profPosts')
        .document(widget.postId)
        .get();
    Timestamp storedDate = doc["timeStamp"];
    String elapsedTime = timeago.format(storedDate.toDate());
    String times = '$elapsedTime';
    setState(() {
      likes = doc['likes'];
      university = doc['university'];
      caption = doc['caption'];
      postPic = doc['postPic'];
      comments = doc['comments'];
      timeStamp = times;
      upVotes = doc['upVotes'];
    });
    if (likes.length != 0) {
      if (likes.contains(currentUserModel.uid)) {
        print('id');
        print(currentUserModel.uid);
        setState(() {
          liked = true;
        });
      }
    } else {
      setState(() {
        liked = false;
      });
    }
  }

  Future<void> _sharePost() async {
    if (caption == "") {
      try {
        var request = await HttpClient().getUrl(Uri.parse(postPic));
        var response = await request.close();
        Uint8List bytes = await consolidateHttpClientResponseBytes(response);
        await Share.files(
            'Message from Dime',
            {
              'esys.png': bytes.buffer.asUint8List(),
            },
            '*/*',
            text:
                "Download Dime today to stay up to date on the latest updates at your university! https://storyofdhruv.com/");
      } catch (e) {
        print('error: $e');
      }
    } else if (postPic == null) {
      try {
        Share.text(
            'Message from Dime',
            caption +
                "\n \n \n \n Download Dime today to stay up to date on the latest updates at your university! https://storyofdhruv.com/",
            'text/plain');
      } catch (e) {
        print('error: $e');
      }
    } else {
      try {
        var request = await HttpClient().getUrl(Uri.parse(postPic));
        var response = await request.close();
        Uint8List bytes = await consolidateHttpClientResponseBytes(response);
        await Share.files(
            'Message from Dime',
            {
              'esys.png': bytes.buffer.asUint8List(),
            },
            '*/*',
            text: caption +
                "\n \n \n \n Download Dime today to stay up to date on the latest updates at your university! https://storyofdhruv.com/");
      } catch (e) {
        print('error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(screenH(9.0)),
        child: caption == null
            ? SizedBox(height: 1,)
            : Card(
                elevation: screenH(10),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(screenH(15.0)))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(screenH(15.0)),
                        topRight: Radius.circular(screenH(15.0)),
                      ),
                      child: postPic != null
                          ? AspectRatio(
                              aspectRatio: 0.92,
                              child: Image(
                                image: NetworkImage(postPic),
                                width: screenW(200),
                                height: screenH(275),
                                fit: BoxFit.fill,
                              ),
                            )
                          : SizedBox(
                              width: screenH(1.2),
                            ),
                    ),
                    ListTile(
                        contentPadding: EdgeInsets.fromLTRB(
                            screenH(22), screenH(11), screenH(22), screenH(11)),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: screenW(290),
                              child: caption != null
                                  ? Text(caption)
                                  : SizedBox(
                                      width: screenW(1.2),
                                    ),
                            ),
                            IconButton(
                              icon: Icon(FontAwesome.share_square_o),
                              iconSize: screenF(25),
                              onPressed: () async => await _sharePost(),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                FontAwesome.comments,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: ProfComments(
                                          postId: widget.postId,
                                        )));
                              },
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: screenH(20),
                                ),
                                comments != null
                                    ? GestureDetector(
                                        child: Text(
                                          "$comments Comments",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child: ProfComments(
                                                    postId: widget.postId,
                                                  )));
                                        },
                                      )
                                    : SizedBox(
                                        width: screenW(1.2),
                                      ),
                                timeStamp != null
                                    ? Text(
                                        timeStamp,
                                        style: TextStyle(
                                            fontSize: screenF(13.5),
                                            color: Colors.grey),
                                      )
                                    : SizedBox(
                                        width: screenW(1.2),
                                      ),
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {
                                if (liked == false) {
                                  setState(() {
                                    liked = true;
                                    upVotes++;
                                  });

                                  Firestore.instance
                                      .collection('profPosts')
                                      .document(widget.postId)
                                      .updateData({
                                    'likes': FieldValue.arrayUnion(
                                        [currentUserModel.uid])
                                  });
                                  Firestore.instance
                                      .collection('users')
                                      .document(currentUserModel.uid)
                                      .collection('recentActivity')
                                      .document(widget.postId)
                                      .setData({
                                    'type': 'prof',
                                    'upvoted': true,
                                    'postId': widget.postId,
                                    'timeStamp': Timestamp.now()
                                  }, merge: true);
                                } else {
                                  setState(() {
                                    liked = false;
                                    upVotes--;
                                  });
                                  Firestore.instance
                                      .collection('profPosts')
                                      .document(widget.postId)
                                      .updateData({
                                    'likes': FieldValue.arrayRemove(
                                        [currentUserModel.uid])
                                  });
                                  DocumentSnapshot documentSnap =
                                      await Firestore.instance
                                          .collection('users')
                                          .document(currentUserModel.uid)
                                          .collection('recentActivity')
                                          .document(widget.postId)
                                          .get();

                                  if (documentSnap['commented'] != true) {
                                    Firestore.instance
                                        .collection('users')
                                        .document(currentUserModel.uid)
                                        .collection('recentActivity')
                                        .document(widget.postId)
                                        .delete();
                                  } else {
                                    Firestore.instance
                                        .collection('users')
                                        .document(currentUserModel.uid)
                                        .collection('recentActivity')
                                        .document(widget.postId)
                                        .setData({
                                      'upvoted': false,
                                    }, merge: true);
                                  }
                                }

                                Firestore.instance
                                    .collection('profPosts')
                                    .document(widget.postId)
                                    .updateData({'upVotes': upVotes});
                              },
                              child: Container(
                                width: screenW(55),
                                height: screenW(55),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(screenH(16)),
                                    color: liked == false
                                        ? Colors.grey[100]
                                        : Color(0xFF76c2c0)),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: screenH(5),
                                    ),
                                    Icon(Icons.keyboard_arrow_up,
                                        color: Color(0xFF063F3E)),
                                    //Text("$upVotes", style: TextStyle(color:Color(0xFF8803fc), fontWeight: FontWeight.bold),)
                                    Text(
                                      '$upVotes',
                                      style: TextStyle(
                                          color: Color(0xFF063F3E),
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                )));
  }
}
