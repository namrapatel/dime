import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import '../viewCards.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Dime/homePage.dart';
import 'package:Dime/profComments.dart';
import 'package:page_transition/page_transition.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:Dime/login.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LargePic extends StatefulWidget {
  final String largePic;

  const LargePic({
    this.largePic,
  });
  @override
  _LargePicState createState() => _LargePicState(largePic: largePic);
}

class _LargePicState extends State<LargePic> {
  List<dynamic> likes;
  String largePic;
  _LargePicState({this.largePic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        body: Column(
          children: <Widget>[
            SizedBox(
                height: screenH(
              60.0,
            )),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Feather.x),
                  color: Colors.white,
                  iconSize: screenH(30.0),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
            SizedBox(
                height: screenH(
              100.0,
            )),
            Center(
              child: CircleAvatar(
                radius: screenH(150),
                backgroundImage: CachedNetworkImageProvider(largePic),
              ),
            ),
          ],
        ));
  }
}
