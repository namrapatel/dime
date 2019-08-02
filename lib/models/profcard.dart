import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import '../viewCards.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:Dime/homePage.dart';

class ProfCard extends StatelessWidget {
  final String type;
  final String major;
  final String photoUrl;
  final String displayName;
  final String bio;
  final String university;
  final String twitter;
  final String github;
  final String linkedIn;
  final String interestString;
  final String email;
  final bool isSwitched;



  const ProfCard(
      {
        this.type,this.major,
        this.university,this.twitter,
        this.github,this.linkedIn,
        this.photoUrl,
        this.displayName,
        this.bio,this.interestString,this.email,this.isSwitched
      });

  factory ProfCard.fromDocument(DocumentSnapshot document) {
    String interest="";
    List<dynamic> interests=document['interests'];
    for(int i=0;i<interests.length;i++){
      if(i==interests.length-1){
        interest=interest+ interests[i];
      }else{
        interest=interest+ interests[i]+", ";
      }

    }

    return ProfCard(
      type: document['type'],
      photoUrl: document['photoUrl'],
      major: document['major'],
      displayName: document['displayName'],
      university: document['university'],
      github: document['github'],
      linkedIn: document['linkedIn'],
      bio: document['bio'],
      twitter: document['twitter'],
      interestString: interest,
      email:document['email'],
      isSwitched: document['socialToggled'],
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
                          color: Colors.black26,
                          blurRadius: (20),
                          spreadRadius: (3),
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
                            Text("",
                                style: TextStyle(
                                    fontSize: screenF(13),
                                    color: Color(0xFF1976d2))):
                            Text(university,
                                style: TextStyle(
                                    fontSize: screenF(13),
                                    color: Color(0xFF1976d2))),
                            SizedBox(
                              height: screenH(2),
                            ),
                            major==null?
                            Text("",
                                style: TextStyle(
                                    fontSize: screenF(13),
                                    color: Colors.grey)):
                            Text(major,
                                style: TextStyle(
                                    fontSize: screenF(13),
                                    color: Colors.grey)),
                            email==null?
                            Text("",
                            style: TextStyle(
                            fontSize: screenF(13),
                            color: Colors.grey)):

                            Text(email,
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
                      EdgeInsets.symmetric(horizontal: screenW(30.0), vertical: screenH(10)),
                      child:Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          linkedIn != null
                              ? isSwitched == true?
                          Column(
                            children: <Widget>[
                              Icon(
                                FontAwesome.linkedin_square,
                                color: Color(0xFF0077B5),
                              ),
                              SizedBox(
                                width: screenW(10),
                              ),
                              Text(linkedIn,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenF(12))),
                            ],
                          )
                              : SizedBox(
                            height: screenH(1),
                          ):
                          SizedBox(
                            height: screenH(1),
                          ),
                          github != null
                              ? isSwitched == true?
                          Column(
                            children: <Widget>[
                              Icon(
                                MaterialCommunityIcons
                                    .github_box,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: screenW(10),
                              ),
                              Text(github,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenF(12))),
                            ],
                          )
                              : SizedBox(
                            height: screenH(1),
                          ): SizedBox(
                            height: screenH(1),
                          ),
                          twitter != null
                              ? isSwitched == true?
                          Column(
                            children: <Widget>[
                              Icon(
                                MaterialCommunityIcons
                                    .twitter_box,
                                color: Colors.blue,
                              ),
                              Text(twitter,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenF(12))),
                            ],
                          )
                              : SizedBox(
                            height: screenH(1),
                          ): SizedBox(
                            height: screenH(1),
                          )
                        ],
                      ),




                    ),
                    SizedBox(
                      height: screenH(7),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 20.0),
                        Text(interestString!=null?interestString:"",
                            style: TextStyle(
                                color: Color(0xFF1976d2), fontSize: screenF(13))
                                )
                      ],
                    )
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





