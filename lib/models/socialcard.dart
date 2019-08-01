import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import '../viewCards.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:Dime/homePage.dart';

class SocialCard extends StatelessWidget {
  final String type;
  final String major;
  final String photoUrl;
  final String displayName;
  final String bio;
  final String university;
  final String snapchat;
  final String instagram;
  final String twitter;






  const SocialCard(
      {
        this.type,this.major,
        this.university,this.snapchat,
        this.instagram,this.twitter,

        this.photoUrl,
        this.displayName,
        this.bio
      });

  factory SocialCard.fromDocument(DocumentSnapshot document) {

      return SocialCard(
        type: document['type'],
        photoUrl: document['photoUrl'],
        major: document['major'],
        displayName: document['displayName'],
        university: document['university'],
        snapchat: document['snapchat'],
        instagram: document['instagram'],
        twitter: document['twitter'],
        bio: document['bio'],
      );

  }
    @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: screenH(30),
                  ),

                  SizedBox(
                    width: screenW(165),
                  ),
                ],
              ),

              Container(
                height: screenH(225),
                width: screenW(370),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.transparent,
                          blurRadius: (20),
                          spreadRadius: (5),
                          offset: Offset(0, 5)),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Stack(
                  children: <Widget>[
                  Column(
                  children: <Widget>[
                    SizedBox(
                      height: screenH(20),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: screenW(20),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(displayName,
                                style: TextStyle(
                                  fontSize: screenF(18),
                                )),
                            SizedBox(
                              height: screenH(2),
                            ),university==null?
                            SizedBox(
                              height: screenH(1),
                            ):
                            Text(university,
                                style: TextStyle(
                                    fontSize: screenF(13),
                                    color: Color(0xFF8803fc))),
                            SizedBox(
                              height: screenH(2),
                            ),
                            major==null?
                            SizedBox(
                              height: screenH(1),
                            ):
                            Text(major,
                                style: TextStyle(
                                    fontSize: screenF(13),
                                    color: Colors.grey)),
                          ],
                        ),
                        SizedBox(
                          width: screenW(75),
                        ),

                          ],
                        ),


                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: screenW(30.0), vertical: screenH(25)),
                      child:

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              snapchat!=null?
                              Icon(
                                FontAwesome.snapchat_square,
                                color: Color(0xFFfffc00),
                              ):  SizedBox(
                                width: 1,
                              ),
                              SizedBox(
                                width: screenW(10),
                              ),
                              Text(snapchat==null?'':snapchat,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenF(12))),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              instagram!=null?
                              Icon(
                                MaterialCommunityIcons.instagram,
                                color: Color(0xFF8803fc),
                              ):  SizedBox(
                                width: 1,
                              ),
                              SizedBox(
                                width: screenW(10),
                              ),
                              Text(instagram==null?'':instagram,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenF(12))),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              twitter!=null?
                              Icon(
                                MaterialCommunityIcons.twitter_box,
                                color: Colors.blue,
                              ): SizedBox(
                                width: 1,
                              ),
                              SizedBox(
                              width: screenW(10),
                              ),
                              Text(twitter==null?'':twitter,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenF(12))),
                            ],
                          )
                        ],
                      ),


                    ),
                  ],
                ),

                  Positioned(
                  left: screenW(285),
                  top: screenH(20),
                  child:  CircleAvatar(
                          backgroundImage:
                          NetworkImage(photoUrl),
                          radius: 25,
                        ),
                ),
                  ],
                ),
              )
            ],
          ),
        ]),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}





