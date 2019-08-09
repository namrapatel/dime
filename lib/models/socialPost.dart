import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import '../viewCards.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Dime/homePage.dart';
import 'package:Dime/socialComments.dart';
import 'package:page_transition/page_transition.dart';

class SocialPost extends StatefulWidget {
  SocialPost({caption, comments, timeStamp, postPic, postId, upVotes});
  @override
  _SocialPostState createState() => _SocialPostState();
}

class _SocialPostState extends State<SocialPost> {
  String postId;
  String caption;
  String postPic;
  int comments;
  String timeStamp;
  int upVotes = 0;

  _SocialPostState({caption, comments, timeStamp, postPic, postId, upVotes});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8.0),
        child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  child: postPic != null
                      ? Image(
                          image: NetworkImage(postPic),
                          width: 200,
                          height: 250,
                          fit: BoxFit.fill,
                        )
                      : SizedBox(
                          width: 1,
                        ),
                ),
                ListTile(
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    title: caption != null
                        ? Text(caption)
                        : SizedBox(
                            width: 1,
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
                                    type: PageTransitionType.fade,
                                    child: SocialComments(
                                      postId: postId,
                                    )));
                          },
                        ),
                        comments != null
                            ? Text("$comments Comments")
                            : SizedBox(
                                width: 1,
                              ),
                        Spacer(),
                        timeStamp != null
                            ? Text(timeStamp)
                            : SizedBox(
                                width: 1,
                              ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              upVotes++;
                              Firestore.instance
                                  .collection('socialPosts')
                                  .document(postId)
                                  .updateData({'upVotes': upVotes});
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.grey[100]),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: screenH(10),
                                ),
                                Icon(Icons.keyboard_arrow_up,
                                    color: Color(0xFF8803fc)),
                                //Text("$upVotes", style: TextStyle(color:Color(0xFF8803fc), fontWeight: FontWeight.bold),)
                                Text(
                                  '$upVotes',
                                  style: TextStyle(
                                      color: Color(0xFF8803fc),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            )));
  }
}
