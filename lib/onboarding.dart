import 'package:Dime/profile.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'viewCards.dart';

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;

String snapchat;
String instagram;
String twitter;
String linkedIn;
String github;

class onBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    return WillPopScope(
      onWillPop: () {
        print('hello');
      },
      child: Scaffold(
        //title of app

        body: Builder(
          builder: (context) => IntroViewsFlutter(
                [
                  PageViewModel(
                    pageColor: const Color(0xFF1458EA),
                    body: Padding(
                      padding: EdgeInsets.all(screenH(8.0)),
                      child: Text(
                        'Find people around your location, read their interests, and chat or connect with their medias!',
                        style: TextStyle(
                            fontFamily: 'futura',
                            color: Colors.white,
                            fontSize: screenF(18.0)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    title: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text('People around you',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: screenF(36.0),
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'futura')),
                    ),
                    mainImage: Image.asset(
                      'assets/darkpeoplearoundyou.png',
                      height: screenH(600.0),
                      width: screenW(600.0),
                      alignment: Alignment.center,
                    ),
                  ),
                  PageViewModel(
                    pageColor: const Color(0xFF1458EA),
                    body: Padding(
                      padding: EdgeInsets.all(screenH(8.0)),
                      child: Text(
                        'All your online media handles and a small glimpse into who you are are easily accessible through your personal cards.',
                        style: TextStyle(
                            fontFamily: 'futura',
                            color: Colors.white,
                            fontSize: screenF(18.0)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    title: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text('Clickable Cards',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: screenF(36.0),
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'futura')),
                    ),
                    mainImage: Image.asset(
                      'assets/clickablecards.png',
                      height: screenH(600.0),
                      width: screenW(600.0),
                      alignment: Alignment.center,
                    ),
                  ),
                  PageViewModel(
                      pageColor: Colors.white,
                      body: OnboardingSave(),
                      title: Padding(
                        padding: EdgeInsets.only(top: screenH(22.0)),
                        child: Column(
                          children: <Widget>[
                            Text('Enter your handles!',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenF(36.0),
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: 'futura')),
                            SizedBox(
                              height: screenH(2.5),
                            ),
                            Text(
                              'Handles are clickable on cards',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: screenF(16.0),
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: 'futura'),
                            )
                          ],
                        ),
                      ),
                      mainImage: MediaForm()),
                  PageViewModel(
                    pageColor: const Color(0xFF1458EA),
                    body: Padding(
                      padding: EdgeInsets.all(screenH(8.0)),
                      child: Text(
                        'A full list of the people who go to your university, put faces to names.',
                        style: TextStyle(
                            fontFamily: 'futura',
                            color: Colors.white,
                            fontSize: screenF(18.0)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    title: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text('University Directory',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: screenF(36.0),
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'futura')),
                    ),
                    mainImage: Image.asset(
                      'assets/darkdirectory.png',
                      height: screenH(600.0),
                      width: screenW(600.0),
                      alignment: Alignment.center,
                    ),
                  ),
                  PageViewModel(
                    pageColor: const Color(0xFF1458EA),
                    body: Padding(
                      padding: EdgeInsets.all(screenH(8.0)),
                      child: Text(
                        "We're constantly working to make your experience on our platform as seamless as possible. Stay tuned for new features!",
                        style: TextStyle(
                            fontFamily: 'futura',
                            color: Colors.white,
                            fontSize: screenF(18.0)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    title: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text('More to come',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: screenF(36.0),
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'futura')),
                    ),
                    mainImage: Image.asset(
                      'assets/improvingDrawing.png',
                      height: screenH(600.0),
                      width: screenW(600.0),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
                showSkipButton: false,
                onTapDoneButton: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => Profile()));
                },
                pageButtonTextStyles: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ), //IntroViewsFlutter
        ), //Builder
      ),
    ); //Material App
  }
}

class MediaForm extends StatefulWidget {
  @override
  _MediaFormState createState() => _MediaFormState();
}

class _MediaFormState extends State<MediaForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: screenW(370),
          child: TextField(
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    snapchat = value;
                  });
                }
              },
              decoration: InputDecoration(
                  hintText: snapchat == null ? "Snapchat" : snapchat,
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    FontAwesome.snapchat_square,
                    size: screenH(33),
                    color: Color(0xFFfffc00),
                  ),
                  prefixText: '@',
                  prefixStyle: TextStyle(color: Colors.grey),
                  labelStyle:
                      TextStyle(fontSize: screenF(16), color: Colors.blueGrey),
                  contentPadding: EdgeInsets.all(screenH(22)),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                      color: Color(0xFF1458EA),
                    ),
                  ),
                  focusedBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                      color: Color(0xFF1458EA),
                    ),
                  ))),
        ),
        SizedBox(
          height: screenH(10.0),
        ),
        Container(
          width: screenW(370),
          child: TextField(
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  instagram = value;
                });
              }
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                MaterialCommunityIcons.instagram,
                color: Color(0xFF8803fc),
                size: screenH(33),
              ),
              hintText: instagram == null ? "Instagram" : instagram,
              hintStyle: TextStyle(color: Colors.grey),
              prefixText: '@',
              prefixStyle: TextStyle(color: Colors.grey),
              labelStyle:
                  TextStyle(fontSize: screenF(16), color: Colors.blueGrey),
              contentPadding: EdgeInsets.all(screenH(22)),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                  color: Color(0xFF1458EA),
                ),
              ),
              focusedBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                  color: Color(0xFF1458EA),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: screenH(10.0),
        ),
        Container(
          width: screenW(370),
          child: TextField(
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  twitter = value;
                });
              }
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                MaterialCommunityIcons.twitter_box,
                color: Colors.blue,
                size: screenH(33),
              ),
              hintText: twitter == null ? "Twitter" : twitter,
              hintStyle: TextStyle(color: Colors.grey),
              prefixText: '@',
              prefixStyle: TextStyle(color: Colors.grey),
              labelStyle:
                  TextStyle(fontSize: screenF(16), color: Colors.blueGrey),
              contentPadding: EdgeInsets.all(screenH(22)),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                  color: Color(0xFF1458EA),
                ),
              ),
              focusedBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                  color: Color(0xFF1458EA),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: screenH(10.0),
        ),
        Container(
          width: screenW(370),
          child: TextField(
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  linkedIn = value;
                });
              }
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                FontAwesome.linkedin_square,
                size: screenH(33),
                color: Color(0xFF0077b5),
              ),
              hintText: linkedIn == null ? "LinkedIn" : linkedIn,
              hintStyle: TextStyle(color: Colors.grey),
              prefixText: '@',
              prefixStyle: TextStyle(color: Colors.grey),
              labelStyle:
                  TextStyle(fontSize: screenF(16), color: Colors.blueGrey),
              contentPadding: EdgeInsets.all(20),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                  color: Color(0xFF1458EA),
                ),
              ),
              focusedBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                  color: Color(0xFF1458EA),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: screenH(10.0),
        ),
        Container(
          width: screenW(370),
          child: TextField(
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  github = value;
                });
              }
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                MaterialCommunityIcons.github_box,
                color: Color(0xFF3c3744),
                size: screenH(33),
              ),
              hintText: github == null ? "GitHub" : github,
              hintStyle: TextStyle(color: Colors.grey),
              prefixText: '@',
              prefixStyle: TextStyle(color: Colors.grey),
              labelStyle:
                  TextStyle(fontSize: screenF(16), color: Colors.blueGrey),
              contentPadding: EdgeInsets.all(screenH(22)),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                  color: Color(0xFF1458EA),
                ),
              ),
              focusedBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                  color: Color(0xFF1458EA),
                ),
              ),
            ),
          ),
        ),

        // Container(
        //   width: screenW(250),
        //   height: screenH(60),
        //   child: FloatingActionButton(
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.all(Radius.circular(16.0))),
        //     elevation: screenH(5),
        //     onPressed: () {
        //       updateSocialCard();
        //       Flushbar(
        //         //  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        //         borderRadius: 15,
        //         messageText: Padding(
        //           padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: <Widget>[
        //               Text(
        //                 'Saved!',
        //                 style: TextStyle(
        //                     color: Colors.black, fontWeight: FontWeight.bold),
        //               ),
        //               Text(
        //                 'Swipe right! Your cards have now been updated.',
        //                 style: TextStyle(color: Colors.grey),
        //               )
        //             ],
        //           ),
        //         ),
        //         backgroundColor: Colors.white,
        //         boxShadows: [
        //           BoxShadow(
        //               color: Colors.black12.withOpacity(0.1),
        //               blurRadius: (15),
        //               spreadRadius: (5),
        //               offset: Offset(0, 3)),
        //         ],
        //         flushbarPosition: FlushbarPosition.TOP,
        //         icon: Padding(
        //           padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
        //           child: Icon(
        //             Icons.save_alt,
        //             size: 28.0,
        //             color: Color(0xFF1458EA),
        //           ),
        //         ),
        //         duration: Duration(seconds: 3),
        //       )..show(context);
        //     },
        //     backgroundColor: Color(0xFF1458EA),
        //     child: Text(
        //       "Save",
        //       style: TextStyle(fontSize: screenF(20), color: Colors.white),
        //     ),
        //   ),
        // )
      ],
    );
  }
}

class OnboardingSave extends StatefulWidget {
  @override
  _OnboardingSaveState createState() => _OnboardingSaveState();
}

class _OnboardingSaveState extends State<OnboardingSave> {
  updateSocialCard() {
    Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .collection('socialcard')
        .document('social')
        .setData({
      'snapchat': snapchat,
      'instagram': instagram,
      'twitter': twitter,
    });
  }

  updateProfCard() {
    Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .collection('profcard')
        .document('prof')
        .setData({
      'github': github,
      'linkedIn': linkedIn,
      'twitter': twitter,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenW(250),
      height: screenH(60),
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        elevation: screenH(5),
        onPressed: () {
          updateSocialCard();
          updateProfCard();
          Flushbar(
            margin: EdgeInsets.symmetric(
                horizontal: screenH(15), vertical: screenH(5)),
            borderRadius: 15,
            messageText: Padding(
              padding: EdgeInsets.fromLTRB(screenH(15), 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Saved!',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Swipe right! Your cards have now been updated.',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            backgroundColor: Colors.white,
            boxShadows: [
              BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  blurRadius: (15),
                  spreadRadius: (5),
                  offset: Offset(0, 3)),
            ],
            flushbarPosition: FlushbarPosition.TOP,
            icon: Padding(
              padding: EdgeInsets.fromLTRB(
                  screenH(15), screenH(8), screenH(8), screenH(8)),
              child: Icon(
                Icons.save_alt,
                size: screenH(30.0),
                color: Color(0xFF1458EA),
              ),
            ),
            duration: Duration(seconds: 3),
          )..show(context);
        },
        backgroundColor: Color(0xFF1458EA),
        child: Text(
          "Save",
          style: TextStyle(fontSize: screenF(20), color: Colors.white),
        ),
      ),
    );
  }
}
