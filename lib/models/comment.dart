import 'package:Dime/EditCardsScreen.dart';
import 'package:flutter/material.dart';
import 'package:Dime/homePage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:timeago/timeago.dart' as timeago;

class Comment extends StatelessWidget {

  final String commenterId, commenterName, commenterPhoto, text, timestamp;
  final List tags;
  const Comment({this.commenterId,this.commenterName,this.commenterPhoto,this.text,this.timestamp,this.tags});


  factory Comment.fromDocument(DocumentSnapshot document) {
    Timestamp storedDate=document['timestamp'];
    String elapsedTime = timeago.format(storedDate.toDate());
    String timestamp = '$elapsedTime';
    return Comment(commenterId: document['commenterId'],
      commenterName:document['commenterName'],


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
      leading: CircleAvatar(
        backgroundImage: NetworkImage(commenterPhoto),
        radius: screenH(27.5),
      ),
      title: Row(
        children: <Widget>[
          Text(commenterName,
            style: TextStyle(fontWeight: FontWeight.bold),
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
            height: screenH(15),
          ),
          Text(text),
        ],
      ),
    );
  }
}

