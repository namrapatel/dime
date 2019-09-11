import 'package:Dime/EditCardsScreen.dart';
import 'package:Dime/models/user.dart';
import 'package:Dime/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/cupertino.dart';
import 'login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_search_panel/flutter_search_panel.dart';
import 'package:flutter_search_panel/search_item.dart';
import 'viewCards.dart';
import 'package:flushbar/flushbar.dart';
import 'homePage.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';

import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as Im;

import 'package:cached_network_image/cached_network_image.dart';

class Profile extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomePageOne());
  }
}

class HomePageOne extends StatefulWidget {
  @override
  _HomePageOneState createState() => _HomePageOneState();
}

class _HomePageOneState extends State<HomePageOne> {

  File _image;
  String name;
  String major;
  String gradYear;
  String university;
  String bio;
  String profilePic;
  String relationshipStatus;

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.symmetric(
                vertical: screenH(30), horizontal: screenW(10)),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    //leading: new Icon(AntDesign.heart),
                    title: new Text('🔒   In a relationship'),
                    onTap: () {
                      setState(() {

                        relationshipStatus = '🔒';
                      });
                      Navigator.pop(context);
                    }),
                new ListTile(
                  //leading: new Icon(FontAwesome5Brands),
                  title: new Text('💎    Single'),
                  onTap: () {
                    setState(() {

                      relationshipStatus = '💎 ';
                    });
                    Navigator.pop(context);
                  },
                ),
                new ListTile(
                  //leading: new Icon(Icons.videocam),
                  title: new Text('✌️   Not interested'),
                  onTap: () {
                    setState(() {

                      relationshipStatus = '✌️';
                    });
                    Navigator.pop(context);
                  },
                ),
                new ListTile(
                  //leading: new Icon(Icons.videocam),
                  title: new Text('Empty Status'),
                  onTap: () {
                    setState(() {

                      relationshipStatus = null;
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  List<SearchItem<int>> data2 = [
//    SearchItem(0, 'University of Waterloo'),
//    SearchItem(1, 'Western University'),
//    SearchItem(2, "University of Alberta"),
//    SearchItem(3, "University of Calgary"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileInfo();
  }

  getProfileInfo() async {
    DocumentSnapshot document = await Firestore.instance
        .collection('variableData')
        .document('universities')
        .get();
    List<dynamic> unis = document['universities'];

    for (var i = 0; i < unis.length; i++) {
      setState(() {
        data2.add(SearchItem(i, unis[i]));
      });
    }

    DocumentSnapshot doc = await Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .get();
    setState(() {
      name = doc.data['displayName'];
      major = doc.data['major'];
      gradYear = doc.data['gradYear'];
      university = doc.data['university'];
      bio = doc.data['bio'];
      profilePic = doc.data['photoUrl'];
      relationshipStatus = doc.data['relationshipStatus'];
    });
  }

  updateProfile() async {
//  QuerySnapshot query = await Firestore.instance
//      .collection('users')
//      .document(currentUserModel.uid)
//      .collection('socialcard')
//      .getDocuments();
//
//  for (var document in query.documents) {
//    setState(() {
//      socialCardId = document.documentID;
//    });
//
//    QuerySnapshot query2 = await Firestore.instance
//        .collection('users')
//        .document(currentUserModel.uid)
//        .collection('profcard')
//        .getDocuments();
//
//    for (var document2 in query2.documents) {
//      setState(() {
//        profCardId = document2.documentID;
//      });
//    }

    Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .updateData({
      'displayName': name,
      'major': major,
      'university': university,
      'gradYear': gradYear,
      'bio': bio,
      'relationshipStatus': relationshipStatus,
      'photoUrl': profilePic,
    });

    DocumentSnapshot user = await Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .get();
    currentUserModel = User.fromDocument(user);

    DocumentSnapshot social = await Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .collection('socialcard')
        .document('social')
        .get();

    DocumentSnapshot prof = await Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .collection('profcard')
        .document('prof')
        .get();
    if (prof['photoUrl'] ==
            "https://firebasestorage.googleapis.com/v0/b/dime-87d60.appspot.com/o/defaultprofile.png?alt=media&token=8cd5318b-9593-4837-a9f9-2a22c87463ef" &&
        social['photoUrl'] ==
            'https://firebasestorage.googleapis.com/v0/b/dime-87d60.appspot.com/o/defaultprofile.png?alt=media&token=8cd5318b-9593-4837-a9f9-2a22c87463ef') {
      Firestore.instance
          .collection('users')
          .document(currentUserModel.uid)
          .collection('socialcard')
          .document('social')
          .setData({
        'photoUrl': profilePic,
      }, merge: true);
      Firestore.instance
          .collection('users')
          .document(currentUserModel.uid)
          .collection('profcard')
          .document('prof')
          .setData({
        'photoUrl': profilePic,
      }, merge: true);
    }
    Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .collection('socialcard')
        .document('social')
        .updateData({
      'displayName': name,
      'major': major,
      'university': university,
      'gradYear': gradYear,
      'bio': bio
    });

    Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .collection('profcard')
        .document('prof')
        .updateData({
      'displayName': name,
      'major': major,
      'university': university,
      'gradYear': gradYear,
      'bio': bio
    });
  }

  Future<void> uploadImage() async {
    String user = currentUserModel.uid + Timestamp.now().toString();
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('$user.jpg');
    StorageUploadTask task = firebaseStorageRef.putFile(_image);

    var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
    setState(() {
      profilePic = downloadUrl.toString();
    });
  }

  Future<void> setImage() async {
    var sampleImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = sampleImage;
    });

      print('starting compression');
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;
      String rand = Timestamp.now().toString();

      Im.Image image = Im.decodeImage(_image.readAsBytesSync());
//     Im.copyResize(image,width: 500,height: 500);

      //    image.format = Im.Image.RGBA;
      //    Im.Image newim = Im.remapColors(image, alpha: Im.LUMINANCE);

      var newim2 = File('$path/img_$rand.jpg')
        ..writeAsBytesSync(Im.encodeJpg(image));

      setState(() {
        _image = newim2;
      });
      print('done');

    uploadImage();
    Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      borderRadius: 15,
      messageText: Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Uploaded!',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              "Click 'Save' to confirm changes.",
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
        padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
        child: Icon(
          Icons.save_alt,
          size: 28.0,
          color: Color(0xFF1458EA),
        ),
      ),
      duration: Duration(seconds: 3),
    )..show(context);
  }

  @override
//  List<SearchItem<int>> data2 = [
////    SearchItem(0, 'University of Waterloo'),
////    SearchItem(1, 'Western University'),
////    SearchItem(2, "University of Alberta"),
////    SearchItem(3, "University of Calgary"),
//  ];

  Widget build(BuildContext context) {
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return Scaffold(
        body: ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Column(children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width / 40,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => ProfilePage()));
                },
                color: Colors.black,
                icon: Icon(Icons.arrow_back_ios),
                iconSize: 25.0,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: screenH(85),
                    ),
                    OutlineButton(
                      color: Color(0xFF1458EA),
                      child: Text(
                        "Edit Cards",
                        style: TextStyle(
                            color: Color(0xFF1458EA), fontSize: screenF(15)),
                      ),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => TabsApp()));
                      },
                    ),
                    SizedBox(
                      width: screenW(20),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3.8,
                      height: MediaQuery.of(context).size.height / 22,
                      // decoration: BoxDecoration(
                      //   boxShadow: [
                      //     BoxShadow(
                      //         color: Color(0xFF1458EA).withOpacity(0.35),
                      //         blurRadius: (15),
                      //         spreadRadius: (5),
                      //         offset: Offset(0, 3)),
                      //   ],
                      // ),
                      child: FlatButton(
                        color: Color(0xFF1458EA),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        onPressed: () {
                          updateProfile();
                          Flushbar(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            borderRadius: 15,
                            messageText: Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Saved!',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Your basic information has been updated.',
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
                              padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                              child: Icon(
                                Icons.save_alt,
                                size: 28.0,
                                color: Color(0xFF1458EA),
                              ),
                            ),
                            duration: Duration(seconds: 3),
                          )..show(context);
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(
                              fontSize: screenF(15), color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 100),
          SizedBox(height: MediaQuery.of(context).size.height / 100),
          Row(
            children: <Widget>[
              SizedBox(width: MediaQuery.of(context).size.width / 12.5),
              Text(
                'Edit profile',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: screenF(22),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
              ),
              // InkWell(
              //     onTap: updateProfile,
              //     child: Container(
              //         padding: EdgeInsets.all(8),
              //         height: 25,
              //         width: 45,
              //         child: Center(
              //             child: Text(
              //           'Save',
              //           style: TextStyle(color: Colors.white),
              //         )),
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(40),
              //           color: Color(0xFF1458EA),
              //         )))
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenH(25.0), horizontal: screenW(10)),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: screenW(20),
                ),
                profilePic != null
                    ? CircleAvatar(
    radius: screenH(45),
    backgroundImage: CachedNetworkImageProvider(
    profilePic
    )):
                     CircularProgressIndicator(),
                SizedBox(
                  width: screenW(20),
                ),
                FlatButton(
                  color: Color(0xFF1458EA),
                  child: Text(
                    "Edit Image",
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  onPressed: () {
                    setImage();
                  },
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 15),
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      name = value;
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: name == "No Display Name" ? "Name" : name,
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
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
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: MediaQuery.of(context).size.height / 10,
                  child: data2.length != 0
                      ? FlutterSearchPanel<int>(
                          padding: EdgeInsets.all(10.0),
                          selected: university == null
                              ? 0
                              : data2.indexWhere((SearchItem element) =>
                                  element.text == currentUserModel.university),
                          title: "Select your university",
                          data: data2,
                          color: Colors.white,
                          icon: new Icon(Icons.school, color: Colors.black),
                          textStyle: new TextStyle(
                            color: Color(0xFF1458EA),
                            fontSize: 15.0,
                          ),
                          onChanged: (int value) {
                            if (value != null) {
                              if (data2[value].text.isNotEmpty &&
                                  data2[value].text != null &&
                                  data2[value].text !=
                                      "Select Your University") {
                                setState(() {
                                  university = data2[value].text;
                                });
                              }
                            }
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        )),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width / 3.5, 0, 0, 0),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _settingModalBottomSheet(context);
                  },
                  child: Text(
                          relationshipStatus==null?
    "Relationship Status":

                          relationshipStatus == "🔒"
                              ? "🔒 In a Relationship"
                              : relationshipStatus == "💎 "
                                  ? "💎   Single"
                                  : relationshipStatus == "✌️"
                                      ? "✌️  Not interested"
                              :""

                      ,style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  onPressed: () {
                    _settingModalBottomSheet(context);
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 15),
              child: TextField(
                textCapitalization: TextCapitalization.words,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      major = value;
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: major == null ? "Program" : major,
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
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
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 15),
              child: TextField(
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      gradYear = "" + value;
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: gradYear == null ? "Graduation Year" : gradYear,
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
                  contentPadding: EdgeInsets.all(20),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                      color: Color(0xFF1458EA),
                    ),
                  ),
                ),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 15),
            child: TextField(
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    bio = value;
                  });
                }
              },
              textCapitalization: TextCapitalization.sentences,
              // controller: descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              maxLength: 50,
              maxLengthEnforced: true,
              decoration: InputDecoration(
                hintText: bio == null ? " Your Bio" : bio,
                hintStyle: TextStyle(color: Colors.grey),
                labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
                contentPadding: EdgeInsets.all(20),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(color: Colors.grey),
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
          Row(
            children: <Widget>[
              SizedBox(
                width: screenW(17.5),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Tell people around you who you are with a quote, joke,",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "your job title, hobbies, or whatever you can think of!",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 60,
          ),
        ]),
      ],
    ));
  }
}
