import 'package:Dime/EditCardsScreen.dart';
import 'package:Dime/blockedusers.dart';
import 'package:Dime/feedback.dart' as prefix0;
import 'package:Dime/models/largerPic.dart';
import 'package:Dime/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'login.dart';
import 'package:flutter/cupertino.dart';
import 'package:Dime/feedback.dart';
import 'package:page_transition/page_transition.dart';
import 'homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // String displayName = currentUserModel.displayName;
  // String bio = currentUserModel.bio;

  // String url = currentUserModel.photoUrl;
  // String uid = currentUserModel.uid;
  // SharedPreferences pref;

  final screenH = ScreenUtil.instance.setHeight;
  final screenW = ScreenUtil.instance.setWidth;
  final screenF = ScreenUtil.instance.setSp;
  String displayName;
  String university;
  String major;
  String gradYear;
  String photoUrl;

  _launchPrivacy() async {
    const url = 'https://www.getdime.ca/privacy';
    launch(url);
  }

  _launchChangelog() async {
    const url1 = 'https://headwayapp.co/dime-changelog';
    launch(url1);
  }

  //Initializes the state when the page first loads and retrieves the users data from firestore
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  getProfile() async {
    DocumentSnapshot doc = await Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .get();

    setState(() {
      displayName = doc['displayName'];
      university = doc['university'];
      major = doc['major'];
      gradYear = doc['gradYear'];
      photoUrl = doc['photoUrl'];
    });
  }

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
      body: Stack(
        children: <Widget>[
          Container(
            height: screenH(850),
            width: double.infinity,
          ),
          Container(
            height: screenH(350),
            width: double.infinity,
            color: Color(0xFF1458EA),
          ),
          Positioned(
              top: (MediaQuery.of(context).size.height / 15),
              //top: 70,
              left: (MediaQuery.of(context).size.width / 30),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => ScrollPage(social: true)));
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              )),
          Positioned(
            top: (MediaQuery.of(context).size.height / 4.5),
            left: (MediaQuery.of(context).size.width / 21),
            //top: 155.0,
            //left: 20.0,
            right: (MediaQuery.of(context).size.width / 21),
            child: Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                height: screenH(610),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height / 6.5),
            left: (MediaQuery.of(context).size.width / 2 - 55.0),
            child: GestureDetector(
              onTap: () {
                if (photoUrl != null) {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => LargePic(
                                largePic: photoUrl,
                              )));
                }
              },
              child: photoUrl == null
                  ? SizedBox(
                      height: 0.0,
                    )
                  : CircleAvatar(
                      radius: screenW(60),
                      backgroundImage: CachedNetworkImageProvider(photoUrl)),
            ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height / 4.4),
            //top: 220,
            left: (MediaQuery.of(context).size.width / 1.23),
            child: Column(
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      print("HERE");
                      print(currentUserModel.uid);
                      _removeDeviceToken();
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.pushReplacement(context,
                            CupertinoPageRoute(builder: (context) => Login()));
                      });
                    },
                    icon: Icon(AntDesign.logout)),
                SizedBox(
                  height: screenH(15),
                ),
                SizedBox(
                  height: screenH(125),
                ),
              ],
            ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height / 2.9),
            //top: 220,
            left: (MediaQuery.of(context).size.width / 3.2),
            right: (MediaQuery.of(context).size.width / 3.2),
            child: Column(
              children: <Widget>[
                displayName == null
                    ? SizedBox(
                        height: 0.0,
                      )
                    : Text(
                        displayName,
                        style: TextStyle(
                          fontSize: screenF(24),
                        ),
                        textAlign: TextAlign.center,
                      ),
                SizedBox(
                  height: screenH(50),
                ),
              ],
            ),
          ),
          Positioned(
              top: (MediaQuery.of(context).size.height / 2.35),
              //top: 300,
              //left: 20,
              left: (MediaQuery.of(context).size.width / 22),
              child: Column(
                children: <Widget>[
                  Container(
                      width: screenW(378),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Profile()));
                        },
                        title: Text(
                          "Basic Info",
                        ),
                        leading: Icon(
                          SimpleLineIcons.user,
                          color: Colors.grey[700],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[700],
                        ),
                      )),
                  Container(
                      width: screenW(378),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => TabsApp()));
                        },
                        title: Text(
                          "Edit Cards",
                        ),
                        leading: Icon(
                          AntDesign.idcard,
                          color: Colors.grey[700],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[700],
                        ),
                      )),
                  // Container(
                  //     width: screenW(378),
                  //     child: ListTile(
                  //       onTap: () {
                  //         Navigator.push(
                  //             context,
                  //             PageTransition(
                  //                 type: PageTransitionType.rightToLeft,
                  //                 child: TabsApp()));
                  //       },
                  //       title: Text(
                  //         "Terms and Conditions",
                  //       ),
                  //       leading: Icon(
                  //         SimpleLineIcons.doc,
                  //         color: Colors.grey[700],
                  //       ),
                  //       trailing: Icon(
                  //         Icons.arrow_forward_ios,
                  //         color: Colors.grey[700],
                  //       ),
                  //     )),

                  Container(
                      width: screenW(378),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => BlockedUsers()));
                        },
                        title: Text(
                          "Blocked Users",
                        ),
                        leading: Icon(
                          Entypo.block,
                          color: Colors.grey[700],
                          size: 23.0,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[700],
                        ),
                      )),
                  Container(
                      width: screenW(378),
                      child: ListTile(
                        onTap: () {
                          _launchChangelog();
                        },
                        title: Text(
                          "Changelog",
                        ),
                        leading: Icon(
                          SimpleLineIcons.star,
                          color: Colors.grey[700],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[700],
                        ),
                      )),
                  Container(
                      width: screenW(378),
                      child: ListTile(
                        onTap: () {
                          _launchPrivacy();
                        },
                        title: Text(
                          "Privacy and Security",
                        ),
                        leading: Icon(
                          SimpleLineIcons.shield,
                          color: Colors.grey[700],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[700],
                        ),
                      )),
                  Container(
                      width: screenW(378),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => prefix0.Feedback()));
                        },
                        title: Text(
                          "Feedback",
                        ),
                        leading: Icon(
                          SimpleLineIcons.exclamation,
                          color: Colors.grey[700],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[700],
                        ),
                      )),
                ],
              )),
        ],
      ),
    );
  }
}

_removeDeviceToken() {
  print("HERE");
  final Firestore _db = Firestore.instance;
  _db.collection('users').document(currentUserModel.uid).get().then((document) {
    var initTokens = document.data['tokens'];
    var tokenList = new List<String>.from(initTokens);
    print("oldTokenList -> $tokenList");
    tokenList.remove(currentToken);
    print("newTokenList -> $tokenList");
    currentToken = "";
    _db
        .collection('users')
        .document(currentUserModel.uid)
        .setData({'tokens': tokenList}, merge: true);
  });
}

//       Container(

//     child: Center(
//   child: Column(
//     children: <Widget>[
//       SizedBox(
//         height: 70.0,
//       ),
//       IconButton(
//       iconSize: ScreenUtil.instance.setHeight(25.0),
//       color: Colors.black,
//       icon: Icon(Icons.settings),
//       onPressed: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => EditProfilePage(),
//             ));
//       },
//     ),
//       RaisedButton(
//             color: Colors.greenAccent[700],
//             child: Text('Logout'),
//             onPressed: () async{
//               pref = await SharedPreferences.getInstance();

//               await pref.clear();
//               FirebaseAuth.instance.signOut().then((value) {
//                 Navigator.of(context).pushReplacementNamed('/loginpage');

//               }).catchError((e) {
//                 print(e);
//               });
//             }),
//       SizedBox(height: 30.0),
//       url==null
//             ?CircularProgressIndicator()

//             :CircleAvatar(
//             backgroundImage: NetworkImage(url),
//             radius: 150.0),
//       // Change AssetImage to NetworkImage and within the brackets of the
//       // constructor you'll be able to place a link to the location of the image file
//       // that you wish to put inside the CircleAvatar.
//       SizedBox(
//         height: 15.0,
//       ),
//       //checks if data has been received, if not shows a progress indicator until profile is set up
//       //should set a default image for new users in user management so it displays that the first time user
//       //clicks on their profile
//       displayName == null

//           ? CircularProgressIndicator()
//           : Text('$displayName',
//               style: TextStyle(
//                 fontSize: 30.0,
//               ))
//     ],
//   ),
// ))
