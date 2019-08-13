import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import '../viewCards.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:Dime/homePage.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialCard extends StatelessWidget {
  final String type;
  final String major;
  final String photoUrl;
  final String displayName;
  final String gradYear;
  final String university;
  final String snapchat;
  final String instagram;
  final String twitter;
  final String interestString;
  final String email;
  final bool isSwitched;

  const SocialCard(
      {this.type,
      this.major,
      this.university,
      this.snapchat,
      this.instagram,
      this.twitter,
      this.photoUrl,
      this.displayName,
      this.gradYear,
      this.interestString,
      this.email,
      this.isSwitched});

  factory SocialCard.fromDocument(DocumentSnapshot document) {
    String interest = "";
    List<dynamic> interests = document['interests'];
    if (interests != null) {
      for (int i = 0; i < interests.length; i++) {
        if (i == interests.length - 1) {
          interest = interest + interests[i];
        } else {
          interest = interest + interests[i] + ", ";
        }
      }
    }
    return SocialCard(
      type: document['type'],
      photoUrl: document['photoUrl'],
      major: document['major'],
      displayName: document['displayName'],
      university: document['university'],
      snapchat: document['snapchat'],
      instagram: document['instagram'],
      twitter: document['twitter'],
      gradYear: document['gradYear'],
      interestString: interest,
      email: document['email'],
      isSwitched: document['socialToggled'],
    );
  }

  Future<void> _launchSnap(String url) async {
    if (await canLaunch('https://www.snapchat.com/add/' + snapchat)) {
      final bool nativeAppLaunchSucceeded = await launch(
        'https://www.snapchat.com/add/' + snapchat,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          'https://www.snapchat.com/add/' + snapchat,
          forceSafariVC: true,
        );
      }
    }
  }

  Future<void> _launchInsta(String url) async {
    if (await canLaunch('https://www.instagram.com/' + instagram)) {
      final bool nativeAppLaunchSucceeded = await launch(
        'https://www.instagram.com/' + instagram,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          'https://www.instagram.com/' + instagram,
          forceSafariVC: true,
        );
      }
    }
  }

  Future<void> _launchTwitter(String url) async {
    if (await canLaunch('https://twitter.com/' + twitter)) {
      final bool nativeAppLaunchSucceeded = await launch(
        'https://twitter.com/' + twitter,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          'https://twitter.com/' + twitter,
          forceSafariVC: true,
        );
      }
    }
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
                        top: screenH(15),
                        left: screenW(20),
                        child: Container(
                          width: 230,
                          child: AutoSizeText(
                            displayName,
                            style: TextStyle(
                                fontSize: screenF(20), color: Colors.black),
                            minFontSize: 12,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                    Positioned(
                      top: screenH(40),
                      left: screenW(20),
                      child: university == null
                          ? SizedBox(
                              height: screenH(1),
                            )
                          : Text(university,
                              style: TextStyle(
                                  fontSize: screenF(15),
                                  color: Color(0xFF8803fc))),
                    ),
                    Positioned(
                      top: screenH(60),
                      left: screenW(20),
                      child: major != null && gradYear != null
                          ? Text(major + ", " + gradYear,
                              style: TextStyle(
                                  fontSize: screenF(15), color: Colors.grey))
                          : Text(major != null ? major : "",
                              style: TextStyle(
                                  fontSize: screenF(15), color: Colors.grey)),
                    ),
                    Positioned(
                      top: screenH(115),
                      left: screenW(30),
                      child: email == null
                          ? Text("           ",
                              style: TextStyle(
                                  fontSize: screenF(13), color: Colors.grey))
                          : Text(email,
                              style: TextStyle(
                                  fontSize: screenF(13), color: Colors.grey)),
                    ),
                    Positioned(
                        top: screenH(105),
                        left: screenW(30),
                        child: snapchat != null
                            ? isSwitched == true
                                ? Column(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(
                                          FontAwesome.snapchat_square,
                                          size: 30,
                                          color: Color(0xFFfffc00),
                                        ),
                                        onPressed: () {
                                          _launchSnap(
                                              'https://www.snapchat.com/add/' +
                                                  snapchat);
                                        },
                                      ),
                                      Text(snapchat,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: screenF(12))),
                                    ],
                                  )
                                : Column(children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        FontAwesome.snapchat_square,
                                        size: 30,
                                        color: Color(0xFFfffc00),
                                      ),
                                    ),
                                    Text("           ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: screenF(12))),
                                  ])
                            : Column(children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    FontAwesome.snapchat_square,
                                    size: 30,
                                    color: Color(0xFFfffc00),
                                  ),
                                ),
                                Text("           ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: screenF(12))),
                              ])),
                    Positioned(
                        top: screenH(105),
                        left: screenW(150),
                        child: instagram != null
                            ? isSwitched == true
                                ? Column(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(
                                          MaterialCommunityIcons.instagram,
                                          color: Color(0xFF8803fc),
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          _launchInsta(
                                              'https://www.instagram.com/' +
                                                  instagram);
                                        },
                                      ),
                                      Text(instagram,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: screenF(12))),
                                    ],
                                  )
                                : Column(children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        MaterialCommunityIcons.instagram,
                                        size: 30,
                                        color: Color(0xFFfffc00),
                                      ),
                                    ),
                                    Text("           ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: screenF(12))),
                                  ])
                            : Column(children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    MaterialCommunityIcons.instagram,
                                    size: 30,
                                    color: Color(0xFFfffc00),
                                  ),
                                ),
                                Text("           ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: screenF(12))),
                              ])),
                    Positioned(
                        top: screenH(105),
                        left: screenW(260),
                        child: twitter != null
                            ? isSwitched == true
                                ? Column(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(
                                          MaterialCommunityIcons.twitter_box,
                                          color: Colors.blue,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          _launchTwitter(
                                              'https://twitter.com/' + twitter);
                                        },
                                      ),
                                      Text(twitter,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: screenF(12))),
                                    ],
                                  )
                                : Column(children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        MaterialCommunityIcons.twitter_box,
                                        size: 30,
                                        color: Color(0xFFfffc00),
                                      ),
                                    ),
                                    Text("           ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: screenF(12))),
                                  ])
                            : Column(children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    MaterialCommunityIcons.twitter_box,
                                    size: 30,
                                    color: Color(0xFFfffc00),
                                  ),
                                ),
                                Text("           ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: screenF(12))),
                              ])),
                    Positioned(
                      top: screenH(210),
                      left: screenW(20),
                      child: Text(interestString != null ? interestString : "",
                          style: TextStyle(
                              color: Color(0xFF8803fc), fontSize: screenF(13))),
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
