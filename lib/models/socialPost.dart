import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import '../viewCards.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:Dime/homePage.dart';

class SocialPost extends StatelessWidget {
  final String caption;
  final String postPic;
  final int comments;
  final String timeStamp;

  const SocialPost({this.caption, this.comments, this.timeStamp, this.postPic});

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
                          onPressed: () {},
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
                              )
                      ],
                    )),
              ],
            )));
  }
}
