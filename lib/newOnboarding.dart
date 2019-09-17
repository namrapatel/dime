import 'package:flutter/material.dart';
import 'package:Dime/profile.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'viewCards.dart';
import 'homePage.dart';

String snapchat;
String instagram;
String twitter;
String vsco;
String linkedIn;
String github;

class Onboarding1 extends StatefulWidget {
  @override
  _Onboarding1State createState() => _Onboarding1State();
}

class _Onboarding1State extends State<Onboarding1> {
  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    return Scaffold(
      backgroundColor: Color(0xFF1458EA),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: screenH(55.0)),
              child: Text('"Like" people around you',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenF(28.0),
                      // fontWeight: FontWeight.bold,
                      fontFamily: 'futura')),
            ),
            SizedBox(
              height: screenH(25),
            ),
            Image.asset(
              'assets/darkpeoplearoundyou.png',
              height: screenH(600.0),
              width: screenW(600.0),
              alignment: Alignment.center,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  screenH(16.0), screenH(8.0), screenH(16.0), screenH(8.0)),
              child: Text(
                "Discover people around you, and send them a casual or network 'like' notification.",
                style: TextStyle(
                    fontFamily: 'futura',
                    color: Colors.white,
                    fontSize: screenF(18.0)),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: screenW(320),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => LikeBack()));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LikeBack extends StatefulWidget {
  @override
  _LikeBackState createState() => _LikeBackState();
}

class _LikeBackState extends State<LikeBack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1458EA),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: screenH(55.0)),
              child: Text('Return a like to chat',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenF(28.0),
                      // fontWeight: FontWeight.bold,
                      fontFamily: 'futura')),
            ),
            SizedBox(
              height: screenH(25),
            ),
            Image.asset(
              'assets/dark.png',
              height: screenH(600.0),
              width: screenW(600.0),
              alignment: Alignment.center,
            ),
            Padding(
              padding: EdgeInsets.all(screenH(1.0)),
              child: Text(
                'Reveal people who liked you, by returning their likes!',
                style: TextStyle(
                    fontFamily: 'futura',
                    color: Colors.white,
                    fontSize: screenF(18.0)),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: screenH(20.0),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: screenW(320),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => Onboarding2()));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Onboarding2 extends StatefulWidget {
  @override
  _Onboarding2State createState() => _Onboarding2State();
}

class _Onboarding2State extends State<Onboarding2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1458EA),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: screenH(55.0)),
              child: Text('Clickable Cards',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenF(28.0),
                      // fontWeight: FontWeight.bold,
                      fontFamily: 'futura')),
            ),
            SizedBox(
              height: screenH(5),
            ),
            Image.asset(
              'assets/Group.png',
              height: screenH(600.0),
              width: screenW(600.0),
              alignment: Alignment.center,
            ),
            Padding(
              padding: EdgeInsets.all(screenH(1.0)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenW(10)),
                child: Text(
                  'All your online media handles and a small glimpse into who you are are easily accessible through your personal cards.',
                  style: TextStyle(
                      fontFamily: 'futura',
                      color: Colors.white,
                      fontSize: screenF(18.0)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: screenW(320),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => Handles()));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Handles extends StatefulWidget {
  @override
  _HandlesState createState() => _HandlesState();
}

class _HandlesState extends State<Handles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
                  children: <Widget>[ Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: screenH(50.0)),
                child: Text('Enter your handles',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: screenF(36.0),
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'futura')),
              ),
              SizedBox(
                height: screenH(30),
              ),
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
                        labelStyle: TextStyle(
                            fontSize: screenF(16), color: Colors.blueGrey),
                        contentPadding: EdgeInsets.all(screenH(16)),
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
                height: screenH(17.5),
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
                    contentPadding: EdgeInsets.all(screenH(16)),
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
                height: screenH(17.5),
              ),
              Container(
                width: screenW(370),
                child: TextField(
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        vsco = value;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Image(
                      width: screenW(40),
                      height: screenH(40),
                      image: AssetImage('assets/vsco.png'),
                    ),
                    hintText: vsco == null ? "VSCO" : vsco,
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixText: '@',
                    prefixStyle: TextStyle(color: Colors.grey),
                    labelStyle:
                        TextStyle(fontSize: screenF(16), color: Colors.blueGrey),
                    contentPadding: EdgeInsets.all(screenH(16)),
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
                height: screenH(17.5),
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
                    contentPadding: EdgeInsets.all(16),
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
                height: screenH(17.5),
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
                    contentPadding: EdgeInsets.all(screenH(16)),
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
                height: screenH(17.5),
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
                    contentPadding: EdgeInsets.all(screenH(16)),
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
                height: screenH(20),
              ),
              NewOnboardingSave(),
              SizedBox(
                height: screenH(40),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: screenW(320),
                  ),
                  FloatingActionButton(
                    heroTag: "btn1",
                    backgroundColor: Colors.black,
                    child: Icon(Icons.arrow_forward),
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => Onboarding3()));
                    },
                  ),
                ],
              )
            ],
          ),]
        ),
      ),
    );
  }
}

class Onboarding3 extends StatefulWidget {
  @override
  _Onboarding3State createState() => _Onboarding3State();
}

class _Onboarding3State extends State<Onboarding3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1458EA),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: screenH(45.0)),
              child: Text('Campus Feeds',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenF(28.0),
                      // fontWeight: FontWeight.bold,
                      fontFamily: 'futura')),
            ),
            SizedBox(
              height: screenH(25),
            ),
            Image.asset(
              'assets/campusfeeds.png',
              height: screenH(600.0),
              width: screenW(600.0),
              alignment: Alignment.center,
            ),
            Padding(
              padding: EdgeInsets.all(screenH(1.0)),
              child: Text(
                'A feed to mess around with your university, and a collection of streams for your more professional interests',
                style: TextStyle(
                    fontFamily: 'futura',
                    color: Colors.white,
                    fontSize: screenF(18.0)),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: screenW(30),
                ),
                FlatButton(
                  child: Text("SKIP"),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => Profile()));
                  },
                ),
                SizedBox(
                  width: screenW(200),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => Onboarding4()));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Onboarding4 extends StatefulWidget {
  @override
  _Onboarding4State createState() => _Onboarding4State();
}

class _Onboarding4State extends State<Onboarding4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1458EA),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: screenH(45.0)),
              child: Text('University Directory',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenF(28.0),
                      // fontWeight: FontWeight.bold,
                      fontFamily: 'futura')),
            ),
            SizedBox(
              height: screenH(25),
            ),
            Image.asset(
              'assets/darkdirectory.png',
              height: screenH(600.0),
              width: screenW(600.0),
              alignment: Alignment.center,
            ),
            Padding(
              padding: EdgeInsets.all(screenH(8.0)),
              child: Text(
                'A full list of the people who go to your university, put names to faces.',
                style: TextStyle(
                    fontFamily: 'futura',
                    color: Colors.white,
                    fontSize: screenF(18.0)),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: <Widget>[
                 SizedBox(
                  width: screenW(30),
                ),
                FlatButton(
                  child: Text("SKIP"),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => Profile()));
                  },
                ),
                SizedBox(
                  width: screenW(200),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => Profile()));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}



class NewOnboardingSave extends StatefulWidget {
  @override
  _NewOnboardingSaveState createState() => _NewOnboardingSaveState();
}

class _NewOnboardingSaveState extends State<NewOnboardingSave> {
  updateSocialCard() {
    Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .collection('socialcard')
        .document('social')
        .setData({'snapchat': snapchat, 'instagram': instagram, 'vsco': vsco},
            merge: true);
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
    }, merge: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenW(250),
      height: screenH(60),
      child: FloatingActionButton(
        heroTag: "btn2",
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
