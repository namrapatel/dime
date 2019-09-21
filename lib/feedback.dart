import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Feedback extends StatefulWidget {
  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: <Widget>[
          SizedBox(
            height: screenH(50.0),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: MediaQuery.of(context).size.width / 25),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.black,
                icon: Icon(Icons.arrow_back_ios),
              ),
            ],
          ),
          SizedBox(
            height: screenH(30.0),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 17, 0, 0, 0),
              ),
              Text(
                "Feedback",
                style: TextStyle(
                  fontSize: screenF(40),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenH(10.0),
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: screenW(25.0),
              ),
              Text(
                "Provide us with your thoughts, report bugs",
                style:
                    TextStyle(fontSize: screenF(17), color: Colors.grey[600]),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: screenW(25.0),
              ),
              Text(
                "you've noticed or submit anything you'd like us",
                style:
                    TextStyle(fontSize: screenF(17), color: Colors.grey[600]),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: screenW(25.0),
              ),
              Text(
                "to hear.",
                style:
                    TextStyle(fontSize: screenF(17), color: Colors.grey[600]),
              ),
            ],
          ),
          SizedBox(
            height: screenH(30.0),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 30),
            child: TextField(
              onChanged: (value) {
                if (value != null) {
                  setState(() {});
                }
              },
              textCapitalization: TextCapitalization.sentences,
              // controller: descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: 15,
              maxLengthEnforced: true,
              decoration: InputDecoration(
                hintText: "Leave us your thoughts...",
                hintStyle: TextStyle(color: Colors.grey[600]),
                contentPadding: EdgeInsets.all(20),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(color: Colors.grey[600]),
                ),
                focusedBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenH(30.0),
          ),
          Container(
            width: screenW(200),
            height: screenH(50),
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              elevation: screenH(5),
              onPressed: () {
                Flushbar(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  // message: "hello",
                  borderRadius: 15,
                  messageText: Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Done!',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'The Dime team will review your submission shortly.',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  backgroundColor: Colors.white,
                  // boxShadows: [
                  //   BoxShadow(
                  //       color: Colors.black12.withOpacity(0.1),
                  //       blurRadius: (15),
                  //       spreadRadius: (5),
                  //       offset: Offset(0, 3)),
                  // ],
                  flushbarPosition: FlushbarPosition.TOP,
                  icon: Padding(
                    padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                    child: Icon(
                      Icons.send,
                      size: 28.0,
                      color: Color(0xFF1458EA),
                    ),
                  ),
                  duration: Duration(seconds: 3),
                )..show(context);
              },
              backgroundColor: Color(0xFF1458EA),
              child: Text(
                "Send",
                style: TextStyle(fontSize: screenF(20), color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
