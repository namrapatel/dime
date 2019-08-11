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

class SocialPost extends StatefulWidget {
 final String postId;
 final  String caption;
 final String postPic;
 final int comments;
 final String timeStamp;
 final int upVotes ;
 final List<dynamic> likes;

  const SocialPost({this.caption, this.comments, this.timeStamp, this.postPic,this.postId, this.upVotes,this.likes});
  @override
  _SocialPostState createState() => _SocialPostState(postId:this.postId,caption:this.caption,postPic:this.postPic,comments:this.comments,timeStamp:this.timeStamp,upVotes:this.upVotes,likes:this.likes);
}

class _SocialPostState extends State<SocialPost> {
  List<dynamic> likes;
  String postId;
   String caption;
   String postPic;
   int comments;
   String timeStamp;
   int upVotes ;
bool liked;

String name = currentUserModel.displayName;

  _SocialPostState({this.caption, this.comments, this.timeStamp, this.postPic, this.postId, this.upVotes,this.likes});

  @override
  void initState() {
    super.initState();
    print(caption);
    if(likes.length!=0) {
      if (likes.contains(currentUserModel.uid)) {
        liked = true;
      }
    }else{
      liked=false;
    }
  }


  Future<void> _sharePost() async {
    if(caption == ""){
      try {
      var request = await HttpClient().getUrl(Uri.parse(
          postPic));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.files(
          'Message from Dime',
          {
            'esys.png': bytes.buffer.asUint8List(),
          },
          '*/*',
          text: "Download Dime today to stay up to date on the latest updates at your university! https://storyofdhruv.com/");

    } catch (e) {
      print('error: $e');
    }
    }
    else if(postPic == null){
    try {
      Share.text('Message from Dime',
          caption + "\n \n \n \n Download Dime today to stay up to date on the latest updates at your university! https://storyofdhruv.com/", 'text/plain');
    } catch (e) {
      print('error: $e');
    }
    }
    else{
      try {
      var request = await HttpClient().getUrl(Uri.parse(
          postPic));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.files(
          'Message from Dime',
          {
            'esys.png': bytes.buffer.asUint8List(),
          },
          '*/*',
          text: caption + "\n \n \n \n Download Dime today to stay up to date on the latest updates at your university! https://storyofdhruv.com/");

    } catch (e) {
      print('error: $e');
    }
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
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        caption != null
                            ? Text(caption)
                            : SizedBox(
                                width: 1,
                              ),
                        IconButton(
                          icon: Icon(FontAwesome.share_square_o),
                          iconSize: 25,
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
                                    type: PageTransitionType.fade,
                                    child: SocialComments(
                                      postId: postId,
                                    )));
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: screenH(20),),
                            comments != null
                                ? GestureDetector(
                                  child: Text("$comments Comments", style: TextStyle(color: Colors.black),),
                                  onTap: (){
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: SocialComments(
                                      postId: postId,
                                    )));
                                  },
                                )
                                : SizedBox(
                                    width: 1,
                                  ),
                               timeStamp != null
                            ? Text(timeStamp, style: TextStyle(fontSize: 12, color: Colors.grey),)
                            : SizedBox(
                                width: 1,
                              ),
                          ],
                        ),
                        Spacer(),

                        GestureDetector(
                          onTap: () {
                            if(liked==false){
                              setState(() {
                                liked=true;
                                upVotes++;

                              });

                              Firestore.instance.collection('socialPosts').document(postId).updateData({
                                'likes':FieldValue.arrayUnion([currentUserModel.uid])
                              });

                            }else{
                                  setState(() {
                                  liked=false;
                                  upVotes--;
                                  });
                                  Firestore.instance.collection('socialPosts').document(postId).updateData({
                                    'likes':FieldValue.arrayRemove([currentUserModel.uid])
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
                      ],
                    )),
              ],
            )));
  }
}
