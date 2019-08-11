import 'package:Dime/EditCardsScreen.dart';
import 'package:Dime/login.dart';
import 'package:Dime/profComments.dart';
import 'package:Dime/socialComments.dart';
import 'package:flutter/material.dart';
import 'package:Dime/homePage.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:page_transition/page_transition.dart';
import 'package:Dime/userCard.dart';

class Comment extends StatelessWidget {

  final String commentId,commenterId, commenterName, commenterPhoto, text, timestamp,type,postId;
  final List tags;
  const Comment({this.commenterId,this.commenterName,this.commenterPhoto,this.text,this.timestamp,this.tags,this.type,this.postId,this.commentId});


  factory Comment.fromDocument(DocumentSnapshot document) {
    Timestamp storedDate=document['timestamp'];
    String elapsedTime = timeago.format(storedDate.toDate());
    String timestamp = '$elapsedTime';
    return Comment(commenterId: document['commenterId'],
      commenterName:document['commenterName'],
      commentId: document.documentID,
      postId: document['postId'],
      type: document['type'],

      commenterPhoto:document['commenterPhoto'],
      tags: document['tags'],
      text:document['text'],
      timestamp:timestamp,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(screenH(15)),
      leading: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(commenterPhoto),
            radius: screenH(27.5),
          ),
        ],
      ),
      title: Row(
        children: <Widget>[
          Text(commenterName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
              IconButton(
                icon: Icon(MaterialCommunityIcons.card_bulleted),
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: UserCard(
                            userId: commenterId,
                            userName: commenterName
                          )));
                },
              ),
              Spacer(),
          Text(timestamp,
            style: TextStyle(fontSize: screenF(13.5),
                color: Color(0xFF8803fc)
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: screenH(2),
          ),
          Text(text),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
          commenterId == currentUserModel.uid?
          IconButton(
            icon: Icon(FontAwesome.trash),
            onPressed: ()async{
              DocumentSnapshot documentSnap= await Firestore.instance.collection('users').document(currentUserModel.uid).collection('recentActivity').document(postId).get();
              if (documentSnap['upvoted'] !=true&&documentSnap['numberOfComments']==1) {
                Firestore.instance.collection('users')
                    .document(currentUserModel.uid)
                    .collection('recentActivity').document(
                    postId)
                    .delete();
              } else{
                Firestore.instance.collection('users').document(
                    currentUserModel.uid)
                    .collection('recentActivity')
                    .document(postId)
                    .setData({
                  'numberOfComments':FieldValue.increment(-1),


                }, merge: true);
              }
              
              if(type=='social') {
                DocumentSnapshot snap= await Firestore.instance.collection('socialPosts').document(postId).get();
                int commentsNumber=snap['comments'];

                Firestore.instance.collection('socialPosts').document(postId).collection('comments').document(commentId).delete();
                Firestore.instance.collection('socialPosts').document(postId).updateData({
                  'comments':commentsNumber-1
                });


                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: SocialComments(
                          postId: postId,
                        )));
              }else if(type=='prof'){
                DocumentSnapshot snap= await Firestore.instance.collection('profPosts').document(postId).get();
                int commentsNumber=snap['comments'];
                Firestore.instance.collection('profPosts').document(postId).collection('comments').document(commentId).delete();
                Firestore.instance.collection('profPosts').document(postId).updateData({
                  'comments':commentsNumber-1
                });


                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: ProfComments(
                          postId: postId,
                        )));
              }


            },
            color: Colors.grey,
            iconSize: 17,
          ) :SizedBox(height: 1,)
            ],
          )
        ],
      ),
    );
  }
}

