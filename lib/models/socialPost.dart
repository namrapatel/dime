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

class SocialPost extends StatefulWidget {
 final String postId;
 final  String caption;
 final String postPic;
 final int comments;
 final String timeStamp;
 final int upVotes ;

  const SocialPost({this.caption, this.comments, this.timeStamp, this.postPic,this.postId, this.upVotes});
  @override
  _SocialPostState createState() => _SocialPostState(postId:this.postId,caption:this.caption,postPic:this.postPic,comments:this.comments,timeStamp:this.timeStamp,upVotes:this.upVotes);
}

class _SocialPostState extends State<SocialPost> {
  String postId;
   String caption;
   String postPic;
   int comments;
   String timeStamp;
   int upVotes ;
bool liked=false;

  _SocialPostState({this.caption, this.comments, this.timeStamp, this.postPic, this.postId, this.upVotes});

  Future<void> _shareMixed() async {
    try {
      final ByteData bytes1 = await rootBundle.load('assets/trip.png');
      final ByteData bytes2 = await rootBundle.load('assets/groupselfie.png');

      await Share.files(
          'esys images',
          {
            'trip.png': bytes1.buffer.asUint8List(),
            'groupselfie.png': bytes2.buffer.asUint8List(),
          },
          '*/*',
          text: 'My optional text.');
    } catch (e) {
      print('error: $e');
    }
  }

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
                            if(liked==false){
                              setState(() {
                                liked=true;
                                upVotes++;

                              });
                            }else{
                                  setState(() {
                                  liked=false;
                                  upVotes--;
                                  });
                            }


                            Firestore.instance
                                .collection('socialPosts')
                                .document(postId)
                                .updateData({'upVotes': upVotes});
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: liked==false?Colors.grey[100]:Color(0xFFdeb8ff)),
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
                        ),
                        IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () async => await _shareMixed(),
                        ),
                      ],
                    )),
              ],
            )));
  }
}
