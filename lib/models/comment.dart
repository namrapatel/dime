import 'package:Dime/EditCardsScreen.dart';
import 'package:Dime/login.dart';
import 'package:Dime/models/largerPic.dart';
import 'package:flutter/cupertino.dart';
import 'package:Dime/profComments.dart';
import 'package:Dime/socialComments.dart';
import 'package:flutter/material.dart';
import 'package:Dime/homePage.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:Dime/chat.dart' as chat;
import 'package:page_transition/page_transition.dart';
import 'package:Dime/userCard.dart';
import 'package:flushbar/flushbar.dart';
import 'package:Dime/viewCards.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Comment extends StatelessWidget {
  final String commentId,
      commenterId,
      commenterName,
      commenterPhoto,
      text,
      timestamp,
      type,
      postId,
      stream;
  final bool verified;
  final List tags;
  const Comment(
      {this.verified,
      this.commenterId,
      this.commenterName,
      this.commenterPhoto,
      this.text,
      this.timestamp,
      this.tags,
      this.type,
      this.postId,
      this.commentId,
      this.stream});

  factory Comment.fromDocument(DocumentSnapshot document) {
    Timestamp storedDate = document['timestamp'];
    String elapsedTime = timeago.format(storedDate.toDate());
    String timestamp = '$elapsedTime';
    return Comment(
        verified: document['verified'],
        commenterId: document['commenterId'],
        commenterName: document['commenterName'],
        commentId: document.documentID,
        postId: document['postId'],
        type: document['type'],
        commenterPhoto: document['commenterPhoto'],
        tags: document['tags'],
        text: document['text'],
        timestamp: timestamp,
        stream: document['stream']);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(screenH(15)),
      leading: Column(
        children: <Widget>[
          SizedBox(
            height: 8.0,
          ),
          InkWell(
            child: GestureDetector(
              onTap: () {
                if (commenterPhoto != null) {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => LargePic(
                                largePic: commenterPhoto,
                              )));
                }
              },
              child: CircleAvatar(
                  radius: screenH(22.0),
                  backgroundImage: CachedNetworkImageProvider(commenterPhoto)),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => UserCard(
                            userId: commenterId,
                            userName: commenterName,
                          )));
            },
          ),
        ],
      ),
      title: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              InkWell(
                child: Row(
                  children: <Widget>[
                    Text(
                      commenterName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.0),
                    ),
                    verified == true
                        ? Icon(
                            Feather.check_circle,
                            color: Color(0xFF096664),
                            size: screenF(17),
                          )
                        : Container()
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => UserCard(
                                userId: commenterId,
                                userName: commenterName,
                              )));
                },
              ),
              Spacer(),
              Text(
                timestamp,
                style: TextStyle(
                    fontSize: screenF(13.5),
                    color: type == 'social'
                        ? Color(0xFF8803fc)
                        : Color(0xFF063F3E)),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 14.0),
                ),
                width: screenW(270),
              ),
              commenterId == currentUserModel.uid
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.grey[200],
                      ),
                      child: InkWell(
                        child: Text('Delete',
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.black)),
                        onTap: () async {
                          DocumentSnapshot documentSnap = await Firestore
                              .instance
                              .collection('users')
                              .document(currentUserModel.uid)
                              .collection('recentActivity')
                              .document(postId)
                              .get();
                          if (documentSnap['upvoted'] != true &&
                              documentSnap['numberOfComments'] == 1) {
                            Firestore.instance
                                .collection('users')
                                .document(currentUserModel.uid)
                                .collection('recentActivity')
                                .document(postId)
                                .delete();
                          } else {
                            bool commented = documentSnap['commented'];
                            if (documentSnap['numberOfComments'] == 1) {
                              commented = false;
                            }
                            Firestore.instance
                                .collection('users')
                                .document(currentUserModel.uid)
                                .collection('recentActivity')
                                .document(postId)
                                .setData({
                              'numberOfComments': FieldValue.increment(-1),
                              'commented': commented
                            }, merge: true);
                          }

                          if (type == 'social' || type == "party") {
                            String collection;
                            if (type == "social") {
                              collection = "socialPosts";
                            } else {
                              collection = "partyPosts";
                            }
                            DocumentSnapshot snap = await Firestore.instance
                                .collection(collection)
                                .document(postId)
                                .get();
                            int commentsNumber = snap['comments'];
                            String ownerID = snap['ownerId'];
                            int points = snap['points'];
                            Firestore.instance
                                .collection(collection)
                                .document(postId)
                                .collection('comments')
                                .document(commentId)
                                .delete();
                            Firestore.instance
                                .collection(collection)
                                .document(postId)
                                .updateData({
                              'comments': commentsNumber - 1,
                              'points': FieldValue.increment(-2)
                            });
                            points = points - 2;

                            if (points >= 100) {
                              Firestore.instance
                                  .collection('users')
                                  .document(ownerID)
                                  .collection('socialcard')
                                  .document("social")
                                  .updateData({'isFire': true});
                            } else {
                              Firestore.instance
                                  .collection('users')
                                  .document(ownerID)
                                  .collection('socialcard')
                                  .document("social")
                                  .updateData({'isFire': false});
                            }
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => SocialComments(
                                          postId: postId,
                                          type: type,
                                          collection: collection,
                                        )));
                          } else if (type == 'prof') {
                            DocumentSnapshot snap = await Firestore.instance
                                .collection('streams')
                                .document(stream)
                                .collection('posts')
                                .document(postId)
                                .get();
                            int commentsNumber = snap['comments'];
                            String ownerID = snap['ownerId'];
                            int points = snap['points'];
                            Firestore.instance
                                .collection('streams')
                                .document(stream)
                                .collection('posts')
                                .document(postId)
                                .collection('comments')
                                .document(commentId)
                                .delete();
                            Firestore.instance
                                .collection('streams')
                                .document(stream)
                                .collection('posts')
                                .document(postId)
                                .updateData({
                              'comments': commentsNumber - 1,
                              'points': FieldValue.increment(-2)
                            });
                            points = points - 2;

                            if (points >= 100) {
                              Firestore.instance
                                  .collection('users')
                                  .document(ownerID)
                                  .collection('profcard')
                                  .document('prof')
                                  .updateData({'isFire': true});
                            } else {
                              Firestore.instance
                                  .collection('users')
                                  .document(ownerID)
                                  .collection('profcard')
                                  .document('prof')
                                  .updateData({'isFire': false});
                            }

                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => ProfComments(
                                          postId: postId,
                                          stream: stream,
                                        )));
                          }
                        },
                      ))
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.grey[200],
                      ),
                      child: InkWell(
                        onTap: () {
                          List<String> id = [];
                          id.add(currentUserModel.uid);
                          Firestore.instance
                              .collection('reportedComments')
                              .document(commentId)
                              .setData({
                            'type': type,
                            'postID': postId,
                            'commentID': commentId,
                            'commenterId': commenterId,
                            'reporterIDs': FieldValue.arrayUnion(id),
                            'text': text,
                            'stream': stream
                          }, merge: true);

                          Flushbar(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            borderRadius: 15,
                            messageText: Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Done",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Our team will review this comment as per your report.",
                                    style: TextStyle(color: Colors.grey),
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
                            duration: Duration(seconds: 3),
                          )..show(context);
                        },
                        child: Text('Report',
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.black)),
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }
}
