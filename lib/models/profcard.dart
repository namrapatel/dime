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




  const ProfCard(
      {
        this.type,this.major,
        this.university,this.twitter,
        this.github,this.linkedIn,
        this.photoUrl,
        this.displayName,
        this.bio,this.interestString
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
                            Text("No University Displayed",
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
                            Text("No Program Displayed              ",
                                style: TextStyle(
                                    fontSize: screenF(13),
                                    color: Colors.grey)):
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
                              github!=null?
                              Icon(
                                MaterialCommunityIcons.github_box,
                                color: Colors.black,
                              ): Icon(
                                MaterialCommunityIcons.github_box,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: screenW(10),
                              ),
                              Text(github==null?'No GitHub \nDisplayed':github,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenF(12))),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              linkedIn!=null?
                              Icon(
                                FontAwesome.linkedin_square,
                                color: Color(0xFF0077B5),
                              ): Icon(
                                FontAwesome.linkedin_square,
                                color: Color(0xFF0077B5),
                              ),
                              SizedBox(
                                width: screenW(10),
                              ),
                              Text(linkedIn==null?'No Linkedin \nDisplayed':linkedIn,
                                  textAlign: TextAlign.center,
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
                              ): Icon(
                                MaterialCommunityIcons.twitter_box,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: screenW(10),
                              ),
                              Text(twitter==null?'No Twitter \nDisplayed':twitter,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenF(12))),
                            ],
                          ),

                        ],
                      ),

                    ),
                    SizedBox(
                      height: screenH(25),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 20.0),
                        Text(interestString!=null?interestString:"",
                            style: TextStyle(
                                color: Color(0xFF1976d2), fontSize: screenF(13)))
                      ],
                    )
                  ],
                ),
                Positioned(
                  left: screenW(285),
                  top: screenH(20),
                  right: screenW(25),
                  child:  CircleAvatar(
                          backgroundImage:
                          NetworkImage(photoUrl),
                          radius: 30,
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





