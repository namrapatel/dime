import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import '../viewCards.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:Dime/homePage.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ProfCard extends StatelessWidget {
  final String type;
  final String major;
  final String photoUrl;
  final String displayName;
  final String gradYear;
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
        this.gradYear,this.interestString,this.email,this.isSwitched
      });

  factory ProfCard.fromDocument(DocumentSnapshot document) {
    String interest="";

    List<dynamic> interests=document['interests'];
    if(interests!=null) {
      for (int i = 0; i < interests.length; i++) {
        if (i == interests.length - 1) {
          interest = interest + interests[i];
        } else {
          interest = interest + interests[i] + ", ";
        }
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
      gradYear: document['gradYear'],
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
              Container(
                height: screenH(245),
                width: screenW(350),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: (20),
                          spreadRadius: (3),
                          offset: Offset(0, 5)),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: screenH(25),
                      left: screenW(30),
                      child: Container(
                        width: 230,
                        
                        child: AutoSizeText(
                        displayName,
                        style: TextStyle(fontSize: screenF(20), color: Colors.black),
                        minFontSize: 12,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                    ),
                      )
                    ),
                    Positioned(
                      top: screenH(60),
                      left: screenW(30),
                      child: university == null
                        ? SizedBox(
                            height: screenH(1),
                          )
                        : Text(university,
                            style: TextStyle(
                                fontSize: screenF(15),
                                color: Color(0xFF063F3E))),
                    ),
                    Positioned(
                      top: screenH(85),
                      left: screenW(30),
                      child: major != null && gradYear != null
                        ? Text(major + ", " + gradYear,
                            style: TextStyle(
                                fontSize: screenF(15),
                                color: Colors.grey))
                        : Text(major != null ? major : "",
                            style: TextStyle(
                                fontSize: screenF(15),
                                color: Colors.grey)),
                    ),
                    Positioned(
                      top: screenH(115),
                      left: screenW(30),
                      child:  email == null
                        ? Text("",
                            style: TextStyle(
                                fontSize: screenF(13),
                                color: Colors.grey))
                        : Text(email,
                            style: TextStyle(
                                fontSize: screenF(13),
                                color: Colors.grey)),
                    ),
                    Positioned(
                      top: screenH(125),
                      left: screenW(40),
                      child: linkedIn != null
                        ? isSwitched == true
                            ? Column(
                                children: <Widget>[
                                  Icon(
                                    FontAwesome.linkedin_square,
                                    size: 30,
                                    color: Color(0xFF0077b5),
                                  ),
                                  SizedBox(
                                    width: screenW(10),
                                    height: screenH(5),
                                  ),
                                  Text(linkedIn,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenF(12))),
                                ],
                              )
                            :    Icon(
                                    FontAwesome.linkedin_square,
                                    size: 30,
                                    color: Color(0xFF0077b5),
                                  )
                        :      Icon(
                                    FontAwesome.linkedin_square,
                                    size: 30,
                                    color: Color(0xFF0077b5),
                                  ),
                    ),
                    Positioned(
                      top: screenH(125),
                      left: screenW(160),
                      child:  github != null
                        ? isSwitched == true
                            ? Column(
                                children: <Widget>[
                                  Icon(
                                    MaterialCommunityIcons.github_box,
                                    color: Color(0xFF3c3744),
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: screenW(10),
                                    height: screenH(5),
                                  ),
                                  Text(github,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenF(12))),
                                ],
                              )
                            :                                   Icon(
                                    MaterialCommunityIcons.github_box,
                                    color: Color(0xFF3c3744),
                                    size: 30,
                                  )
                        :    Icon(
                                    MaterialCommunityIcons.github_box,
                                    color: Color(0xFF3c3744),
                                    size: 30,
                                  ),
                    ),
                    Positioned(
                      top: screenH(125),
                      left: screenW(260),
                      child: twitter != null
                        ? isSwitched == true
                            ? Column(
                                children: <Widget>[
                                  Icon(
                                    MaterialCommunityIcons
                                        .twitter_box,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: screenW(10),
                                    height: screenH(5),
                                  ),
                                  Text(twitter,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenF(12))),
                                ],
                              )
                            :                                   Icon(
                                    MaterialCommunityIcons
                                        .twitter_box,
                                    color: Colors.blue,
                                    size: 30,
                                  )
                        :                                   Icon(
                                    MaterialCommunityIcons
                                        .twitter_box,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                    ),
                    Positioned(
                      top: screenH(210),
                      left: screenW(30),
                      child: 
                    Text(interestString != null ? interestString : "",
                        style: TextStyle(
                            color: Color(0xFF063F3E),
                            fontSize: screenF(13))) ,
                    ),
                    Positioned(
                      left: screenW(265),
                      top: screenH(20),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(photoUrl),
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
