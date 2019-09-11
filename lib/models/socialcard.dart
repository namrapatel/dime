import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import '../viewCards.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:Dime/homePage.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:Dime/userCard.dart';
import 'package:Dime/chat.dart';
import 'package:page_transition/page_transition.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

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
  final bool isFire;
  GlobalKey globalKey = new GlobalKey();

  SocialCard(
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
      this.isSwitched,
      this.isFire});

  factory SocialCard.fromDocument(DocumentSnapshot document) {
    String interest = "";
    // List<dynamic> interests = document['interests'];
    // if (interests != null) {
    //   for (int i = 0; i < interests.length; i++) {
    //     if (i == interests.length - 1) {
    //       interest = interest + interests[i];
    //     } else {
    //       interest = interest + interests[i] + ", ";
    //     }
    //   }
    // }
    return SocialCard(
      isFire: document['isFire'],
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
    if (await canLaunch('https://www.snapchat.com/add/$snapchat')) {
      final bool nativeAppLaunchSucceeded = await launch(
        'https://www.snapchat.com/add/$snapchat',
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          'https://www.snapchat.com/add/$snapchat',
          forceSafariVC: true,
        );
      }
    }
  }

  Future<void> _launchInsta(String url) async {
    if (await canLaunch('https://www.instagram.com/$instagram')) {
      final bool nativeAppLaunchSucceeded = await launch(
        'https://www.instagram.com/$instagram',
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          'https://www.instagram.com/$instagram',
          forceSafariVC: true,
        );
      }
    }
  }

  Future<void> _launchTwitter(String url) async {
    if (await canLaunch('https://twitter.com/$twitter')) {
      final bool nativeAppLaunchSucceeded = await launch(
        'https://twitter.com/$twitter',
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          'https://twitter.com/$twitter',
          forceSafariVC: true,
        );
      }
    }
  }

  Future<void> _shareText() async {
    try {
      Share.text(
          'My Social Media:',
          'https://www.snapchat.com/add/$snapchat' +
              'https://www.instagram.com/$instagram' +
              'https://twitter.com/$twitter',
          'text/plain');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);

      await Share.file(
          'Share card', displayName + '.png', pngBytes, 'image/png',
          text: 'Snapchat: https://www.snapchat.com/add/$snapchat'
              '\n \n'
              'Instagram: https://www.instagram.com/$instagram'
              '\n \n'
              'Twitter: https://twitter.com/$twitter');

      return pngBytes;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RepaintBoundary(
          key: globalKey,
          child: Stack(children: <Widget>[
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
                            child: Row(
                              children: <Widget>[
                                AutoSizeText(
                                  displayName,
                                  style: TextStyle(
                                      fontSize: screenF(20),
                                      color: Colors.black),
                                  minFontSize: 12,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  width: screenW(5),
                                ),
                                isFire == true
                                    ? Icon(
                                        Octicons.flame,
                                        color: Color(0xFF8803fc),
                                        size: screenF(17),
                                      )
                                    : Container()
                              ],
                            ),
                          )),
                      Positioned(
                        top: screenH(46),
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
                        top: screenH(190),
                        left: screenW(295),
                        child: IconButton(
                            icon: Icon(Ionicons.ios_send),
                            color: Color(0xFF8803fc),
                            iconSize: screenF(25),
                            onPressed: () async => await _capturePng()),
                      ),

                      Positioned(
                        top: screenH(65),
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
                                                'https://www.snapchat.com/add/$snapchat');
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
                                                'https://www.instagram.com/$instagram');
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
                                          color: Color(0xFF8803fc),
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
                                      color: Color(0xFF8803fc),
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
                                                'https://twitter.com/$twitter');
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
                                            color: Colors.blue),
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
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Text("           ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenF(12))),
                                ])),
                      // Positioned(
                      //   top: screenH(210),
                      //   left: screenW(20),
                      //   child: Text(
                      //       interestString != null ? interestString : "",
                      //       style: TextStyle(
                      //           color: Color(0xFF8803fc),
                      //           fontSize: screenF(13))),
                      // ),
                      Positioned(
                        left: screenW(265),
                        top: screenH(20),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(photoUrl),
                          radius: screenH(30),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ]),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
