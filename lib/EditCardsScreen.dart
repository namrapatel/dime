import 'dart:io';
import 'package:Dime/models/largerPic.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:Dime/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_search_panel/search_item.dart';
import 'login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'homePage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as Im;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';

String selectedItemString;
String selectedWItemString;

String selectedItemString2;
String selectedWItemString2;


class TabsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CardEdit(),
    );
  }
}

String amount;

class SocialCardEdit extends StatefulWidget {
  @override
  _SocialCardEditState createState() => _SocialCardEditState();
}

class _SocialCardEditState extends State<SocialCardEdit> {
  File _image;
  @override
  void initState() {
    super.initState();
    getSocialInfo();
  }

  String vsco;
  String email;
  String gradYear;
  String interestString = "";
  String saved = '';
  String name;
  String university;
  String major;
  String snapchat;
  String instagram;
  String twitter;

  String photoUrl;

  Widget _buildAddButton() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.purple[400],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.add,
            color: Colors.white,
            size: 15.0,
          ),
          Text(
            "Request new tag",
            style: TextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ],
      ),
    );
  }

  getSocialInfo() async {
    List<dynamic> interests = [];
    DocumentSnapshot document = await Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .collection('socialcard')
        .document('social')
        .get();

//    for (var document in query.documents) {
    setState(() {
//        socialCardId = document.documentID;

//      String photoUrl=document['photoUrl'];
      vsco = document['vsco'];
      gradYear = document['gradYear'];
      major = document['major'];
      name = document['displayName'];
      university = document['university'];
      snapchat = document['snapchat'];
      instagram = document['instagram'];
      twitter = document['twitter'];
      photoUrl = document['photoUrl'];
      interests = document['interests'];
      isSwitched = document['socialToggled'];
      email = document['email'];
    });

//      bio=document['bio'];

//    }
    if (interests != null) {
      for (int i = 0; i < interests.length; i++) {
        if (i == interests.length - 1) {
          interestString = interestString + interests[i];
        } else {
          interestString = interestString + interests[i] + ", ";
        }
      }
    }
    print(interestString);
  }

  updateSocialCard() {
    Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .collection('socialcard')
        .document('social')
        .updateData({
      'displayName': name,
      'major': major,
      'university': university,
      'snapchat': snapchat,
      'instagram': instagram,
      'twitter': twitter,
      'photoUrl': photoUrl,
      'socialToggled': isSwitched,
      'email': email,
      'vsco': vsco
    });
  }

  Future<void> uploadImage() async {
    String user = currentUserModel.uid + Timestamp.now().toString();
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('$user.jpg');
    StorageUploadTask task = firebaseStorageRef.putFile(_image);

    var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
    setState(() {
      photoUrl = downloadUrl.toString();
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

  String text = "Nothing to show";
  bool isSwitched = true;
  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    return ListView(
      children: <Widget>[
        Column(children: <Widget>[
          Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                  padding: EdgeInsets.all(0),
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    Column(children: <Widget>[
                      SizedBox(
                        height: screenH(20),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: screenW(20),
                          ),
                          photoUrl != null
                              ? CircleAvatar(
                                  radius: screenH(45),
                                  backgroundImage:
                                      CachedNetworkImageProvider(photoUrl))
                              : CircularProgressIndicator(),
                          SizedBox(
                            width: screenW(20),
                          ),
                          FlatButton(
                            color: Color(0xFF1458EA),
                            child: Text(
                              "Edit Social Image",
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
                      SizedBox(
                        height: 10.0,
                        width: screenW(70),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: screenW(20),
                          ),
                          Text(
                            'Display Your Social Media?',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: screenW(75)),
                          Switch(
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                });
                              },
                              activeTrackColor: Colors.blue[200],
                              activeColor: Color(0xff1976d2)),
                        ],
                      ),
                      SizedBox(
                        height: screenH(10),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: <Widget>[
                            Theme(
                              data: new ThemeData(
                                  primaryColor: Colors.black,
                                  accentColor: Colors.black,
                                  hintColor: Colors.black),
                              child: TextField(
                                  inputFormatters: [
                                    BlacklistingTextInputFormatter(
                                        RegExp("[ ]"))
                                  ],
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        snapchat = value;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: snapchat == null
                                          ? "Snapchat"
                                          : snapchat,
                                      hintStyle: TextStyle(color: Colors.grey),
                                      prefixIcon: Icon(
                                        FontAwesome.snapchat_square,
                                        size: 30,
                                        color: Color(0xFFfffc00),
                                      ),
                                      prefixText: '@',
                                      prefixStyle:
                                          TextStyle(color: Colors.grey),
                                      labelStyle: TextStyle(
                                          fontSize: 15, color: Colors.blueGrey),
                                      contentPadding: EdgeInsets.all(20),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0),
                                        borderSide: new BorderSide(
                                          color: Color(0xFF1458EA),
                                        ),
                                      ),
                                      focusedBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0),
                                        borderSide: new BorderSide(
                                          color: Color(0xFF1458EA),
                                        ),
                                      ))),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: <Widget>[
                            Theme(
                              // data: theme.copyWith(primaryColor: Colors.black),
                              data: new ThemeData(
                                  primaryColor: Colors.black,
                                  accentColor: Colors.black,
                                  hintColor: Colors.black),
                              child: TextField(
                                inputFormatters: [
                                  BlacklistingTextInputFormatter(RegExp("[ ]"))
                                ],
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
                                    size: 30,
                                  ),
                                  hintText: instagram == null
                                      ? "Instagram"
                                      : instagram,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixText: '@',
                                  prefixStyle: TextStyle(color: Colors.grey),
                                  labelStyle: TextStyle(
                                      fontSize: 15, color: Colors.blueGrey),
                                  contentPadding: EdgeInsets.all(20),
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                      color: Color(0xFF1458EA),
                                    ),
                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                      color: Color(0xFF1458EA),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: <Widget>[
                            Theme(
                              // data: theme.copyWith(primaryColor: Colors.black),
                              data: new ThemeData(
                                  primaryColor: Colors.black,
                                  accentColor: Colors.black,
                                  hintColor: Colors.black),
                              child: TextField(
                                inputFormatters: [
                                  BlacklistingTextInputFormatter(RegExp("[ ]"))
                                ],
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
                                  labelStyle: TextStyle(
                                      fontSize: 15, color: Colors.blueGrey),
                                  contentPadding: EdgeInsets.all(20),
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                      color: Color(0xFF1458EA),
                                    ),
                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                      color: Color(0xFF1458EA),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenH(20.0),
                      ),
                    ]),
                    SizedBox(
                      height: screenH(20.0),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: screenW(250),
                          height: screenH(60),
                          child: FloatingActionButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0))),
                            elevation: screenH(5),
                            onPressed: () {
                              updateSocialCard();
                              Flushbar(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                borderRadius: 15,
                                messageText: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Saved!',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Your cards have now been updated.',
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
                                    Icons.save_alt,
                                    size: 28.0,
                                    color: Color(0xFF1458EA),
                                  ),
                                ),
                                duration: Duration(seconds: 3),
                              )..show(context);
                            },
                            backgroundColor: Color(0xFF1458EA),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  fontSize: screenF(20), color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(saved,
                                style: TextStyle(
                                    fontSize: screenF(15), color: Colors.grey)),
                          ],
                        ),
                      ],
                    )
                  ]))
        ])
      ],
    );
  }
}

class ProfessionalCardEdit extends StatefulWidget {
  @override
  _ProfessionalCardEditState createState() => _ProfessionalCardEditState();
}

class _ProfessionalCardEditState extends State<ProfessionalCardEdit> {
  @override
  void initState() {
    super.initState();
    getProfInfo();
  }

  String interestString = '';
  String email;
  String saved = '';
  String name;
  String university;
  String major;
  String linkedIn;
  String github;
  String twitter;
  String gradYear;
  String photoUrl;

  File _image;
  getProfInfo() async {
    List<dynamic> interests = [];
    DocumentSnapshot document = await Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .collection('profcard')
        .document('prof')
        .get();

//    for (var document in query.documents) {
    setState(() {
//        profCardId = document.documentID;
      gradYear = document['gradYear'];
      major = document['major'];
      name = document['displayName'];
      university = document['university'];
      github = document['github'];
      linkedIn = document['linkedIn'];
      twitter = document['twitter'];
      photoUrl = document['photoUrl'];
      isSwitched2 = document['socialToggled'];
      email = document['email'];
      interests = document['interests'];
    });

//      bio=document['bio'];

//    }
    if (interests != null) {
      for (int i = 0; i < interests.length; i++) {
        if (i == interests.length - 1) {
          interestString = interestString + interests[i];
        } else {
          interestString = interestString + interests[i] + ", ";
        }
      }
    }
    print(interestString);
  }

  updateProfCard() async {
    Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .collection('profcard')
        .document('prof')
        .updateData({
      'displayName': name,
      'major': major,
      'university': university,
      'github': github,
      'linkedIn': linkedIn,
      'twitter': twitter,
      'photoUrl': photoUrl,
      'socialToggled': isSwitched2,
      'email': email
    });
  }

  Future<void> uploadImage() async {
    String user = currentUserModel.uid + Timestamp.now().toString();
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('$user.jpg');
    StorageUploadTask task = firebaseStorageRef.putFile(_image);

    var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
    setState(() {
      photoUrl = downloadUrl.toString();
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

  String text = "Nothing to show";
  bool isSwitched2 = true;

  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    return ListView(
      children: <Widget>[
        Column(children: <Widget>[
          Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                  padding: EdgeInsets.all(0),
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    Column(children: <Widget>[
                      SizedBox(
                        height: 20.0,
                        width: screenW(70),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: screenW(20),
                          ),
                          GestureDetector(
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
                            child: photoUrl != null
                                ? CircleAvatar(
                                    radius: screenH(45),
                                    backgroundImage:
                                        CachedNetworkImageProvider(photoUrl))
                                : CircularProgressIndicator(),
                          ),
                          SizedBox(
                            width: screenW(20),
                          ),
                          FlatButton(
                            color: Color(0xFF1458EA),
                            child: Text(
                              "Edit Professional Image",
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
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: screenW(20),
                          ),
                          Text(
                            'Display Your Social Media?',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: screenW(75)),
                          Switch(
                            value: isSwitched2,
                            onChanged: (value) {
                              setState(() {
                                isSwitched2 = value;
                              });
                            },
                            activeTrackColor: Colors.blue[200],
                            activeColor: Color(0xFF1458EA),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: <Widget>[
                            Theme(
                              data: new ThemeData(
                                  primaryColor: Colors.black,
                                  accentColor: Colors.black,
                                  hintColor: Colors.black),
                              child: TextField(
                                inputFormatters: [
                                  BlacklistingTextInputFormatter(RegExp("[ ]"))
                                ],
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
                                    size: 30,
                                    color: Color(0xFF0077b5),
                                  ),
                                  hintText:
                                      linkedIn == null ? "LinkedIn" : linkedIn,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixText: '@',
                                  prefixStyle: TextStyle(color: Colors.grey),
                                  labelStyle: TextStyle(
                                      fontSize: 15, color: Colors.blueGrey),
                                  contentPadding: EdgeInsets.all(20),
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                      color: Color(0xFF1458EA),
                                    ),
                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                      color: Color(0xFF1458EA),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: <Widget>[
                            Theme(
                              data: new ThemeData(
                                  primaryColor: Colors.black,
                                  accentColor: Colors.black,
                                  hintColor: Colors.black),
                              child: TextField(
                                inputFormatters: [
                                  BlacklistingTextInputFormatter(RegExp("[ ]"))
                                ],
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
                                    size: 30,
                                  ),
                                  hintText: github == null ? "GitHub" : github,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixText: '@',
                                  prefixStyle: TextStyle(color: Colors.grey),
                                  labelStyle: TextStyle(
                                      fontSize: 15, color: Colors.blueGrey),
                                  contentPadding: EdgeInsets.all(20),
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                      color: Color(0xFF1458EA),
                                    ),
                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                      color: Color(0xFF1458EA),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: <Widget>[
                            Theme(
                              data: new ThemeData(
                                  primaryColor: Colors.black,
                                  accentColor: Colors.black,
                                  hintColor: Colors.black),
                              child: TextField(
                                inputFormatters: [
                                  BlacklistingTextInputFormatter(RegExp("[ ]"))
                                ],
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
                                    size: 30,
                                  ),
                                  hintText:
                                      twitter == null ? "Twitter" : twitter,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixText: '@',
                                  prefixStyle: TextStyle(color: Colors.grey),
                                  labelStyle: TextStyle(
                                      fontSize: 15, color: Colors.blueGrey),
                                  contentPadding: EdgeInsets.all(20),
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                      color: Color(0xFF1458EA),
                                    ),
                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                      color: Color(0xFF1458EA),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenH(20.0),
                      ),
                    ]),
                    SizedBox(
                      height: screenH(20.0),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: screenW(250),
                          height: screenH(60),
                          child: FloatingActionButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0))),
                            elevation: screenH(5),
                            onPressed: () {
                              updateProfCard();
                              Flushbar(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                // message: "hello",
                                borderRadius: 15,
                                messageText: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Saved!',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Your cards have now been updated.',
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
                                    Icons.save_alt,
                                    size: 28.0,
                                    color: Color(0xFF1458EA),
                                  ),
                                ),
                                duration: Duration(seconds: 3),
                              )..show(context);
                            },
                            backgroundColor: Color(0xFF1458EA),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  fontSize: screenF(20), color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(saved,
                            style: TextStyle(
                                fontSize: screenF(15), color: Colors.grey)),
                      ],
                    )
                  ]))
        ])
      ],
    );
  }
}

class CardEdit extends StatefulWidget {
  @override
  _CardEditState createState() => _CardEditState();
}

class _CardEditState extends State<CardEdit> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Row(
            children: <Widget>[
              SizedBox(
                width: screenW(8),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.white,
                icon: Icon(Icons.arrow_back_ios),
              ),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Color(0xFF1458EA),
          title: Text(
            'Edit Cards',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                child: Text(
                  'Social',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              Tab(
                child: Text(
                  'Professional',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [SocialCardEdit(), ProfessionalCardEdit()],
        ),
      ),
    );
  }
}

class TagSearchService {
  static Future<List> getSuggestions(String query) async {
    await Future.delayed(Duration(milliseconds: 400), null);
    List<dynamic> tagList = <dynamic>[];
    tagList.add({'name': "Flutter", 'value': 1});
    tagList.add({'name': "HummingBird", 'value': 2});
    tagList.add({'name': "Dart", 'value': 3});
    tagList.add({'name': "Watching movies", 'value': 4});
    List<dynamic> filteredTagList = <dynamic>[];
    if (query.isNotEmpty) {
      filteredTagList.add({'name': query, 'value': 0});
    }
    for (var tag in tagList) {
      if (tag['name'].toLowerCase().contains(query)) {
        filteredTagList.add(tag);
      }
    }
    return filteredTagList;
  }
}
