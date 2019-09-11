import 'dart:io';
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
import 'socialTags.dart';
import 'professionalTags.dart';
import 'viewCards.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'homePage.dart';

String selectedItemString;
String selectedWItemString;

String selectedItemString2;
String selectedWItemString2;

//final screenH = ScreenUtil.instance.setHeight;
//final screenW = ScreenUtil.instance.setWidth;
//final screenF = ScreenUtil.instance.setSp;
List<SocialInterestTile> interestList = [
//  new SocialInterestTile("Music"),
//  new SocialInterestTile("Sports"),
//  new SocialInterestTile("Food"),
//  new SocialInterestTile("Travel"),
//  new SocialInterestTile("Athletics"),
//  new SocialInterestTile("Gaming"),
//  new SocialInterestTile("Winter Sports"),
//  new SocialInterestTile("Hiking"),
//  new SocialInterestTile("Movies"),
//  new SocialInterestTile("Art"),
//  new SocialInterestTile("Fasion"),
//  new SocialInterestTile("Adventure"),
//  new SocialInterestTile("Books"),
//  new SocialInterestTile("Anime"),
//  new SocialInterestTile("Theatre"),
//  new SocialInterestTile("Photography"),
//  new SocialInterestTile("Pets"),
//  new SocialInterestTile("Outdoors"),
//  new SocialInterestTile("Volunteering"),
//  new SocialInterestTile("Automotives"),
//  new SocialInterestTile("Cooking"),
//  new SocialInterestTile("Drama"),
//  new SocialInterestTile("E-Sports"),
//  new SocialInterestTile("Writing"),
//  new SocialInterestTile("Working Out"),
//  new SocialInterestTile("Partying"),
//  new SocialInterestTile("Band"),
//  new SocialInterestTile("Dance"),
//  new SocialInterestTile("TV Shows"),
//  new SocialInterestTile("Technology"),
//  new SocialInterestTile("Water Sports"),
//  new SocialInterestTile("Hip Hop"),
//  new SocialInterestTile("Pop"),
//  new SocialInterestTile("R&B"),
//  new SocialInterestTile("Guitar"),
//  new SocialInterestTile("Piano"),
//  new SocialInterestTile("Band"),
//  new SocialInterestTile("Camping"),
//  new SocialInterestTile("Classical"),
//  new SocialInterestTile("Jazz"),
//  new SocialInterestTile("K-Pop"),
//  new SocialInterestTile("Blues"),
//  new SocialInterestTile("Rock Music"),
//  new SocialInterestTile("Metal Music"),
//  new SocialInterestTile("Techno"),
//  new SocialInterestTile("Concerts"),
//  new SocialInterestTile("Music Festivals"),
//  new SocialInterestTile("Technology"),
//  new SocialInterestTile("Fiction Books"),
//  new SocialInterestTile("Swimming"),
//  new SocialInterestTile("Rowing"),
//  new SocialInterestTile("Mountain Climbing"),
//  new SocialInterestTile("Basketball"),
//  new SocialInterestTile("Baseball"),
//  new SocialInterestTile("Track and Field"),
//  new SocialInterestTile("Hockey"),
//  new SocialInterestTile("Golf"),
//  new SocialInterestTile("Lacrosse"),
//  new SocialInterestTile("Comics"),
//  new SocialInterestTile("Fishing"),
//  new SocialInterestTile("Horseback Riding"),
//  new SocialInterestTile("Badminton"),
//  new SocialInterestTile("Tennis"),
//  new SocialInterestTile("Volleyball"),
//  new SocialInterestTile("Biking"),
//  new SocialInterestTile("Soccer"),
//  new SocialInterestTile("ATV"),
//  new SocialInterestTile("Gymnastics"),
//  new SocialInterestTile("Cricket"),
//  new SocialInterestTile("Football"),
//  new SocialInterestTile("Rugby"),
//  new SocialInterestTile("NBA"),
//  new SocialInterestTile("NHL"),
//  new SocialInterestTile("MLB"),
//  new SocialInterestTile("NFL"),
//  new SocialInterestTile("Snowboarding"),
//  new SocialInterestTile("Skiing"),
//  new SocialInterestTile("Skating"),
//  new SocialInterestTile("Technology"),
//  new SocialInterestTile("Wine"),
//  new SocialInterestTile("Fine Dining"),
//  new SocialInterestTile("Backpacking"),
//  new SocialInterestTile("Classic Movies"),
//  new SocialInterestTile("Horror Films"),
//  new SocialInterestTile("Indie Films"),
//  new SocialInterestTile("Painting"),
//  new SocialInterestTile("Sneakerheads"),
//  new SocialInterestTile("Sculpting"),
//  new SocialInterestTile("Poetry"),
//  new SocialInterestTile("Cars"),
//  new SocialInterestTile("Baking"),
//  new SocialInterestTile("Cosmetics"),
];

List<ProfInterestTile> profInterestList = [
//  new ProfInterestTile("Philosophy"),
//  new ProfInterestTile("Business"),
//  new ProfInterestTile("Finance"),
//  new ProfInterestTile("Social Work"),
//  new ProfInterestTile("Software"),
//  new ProfInterestTile("Chemistry"),
//  new ProfInterestTile("Health Care"),
//  new ProfInterestTile("Product Management"),
//  new ProfInterestTile("Law"),
//  new ProfInterestTile("Art"),
//  new ProfInterestTile("Technology"),
//  new ProfInterestTile("History"),
//  new ProfInterestTile("Management"),
//  new ProfInterestTile("Aviation"),
//  new ProfInterestTile("Data"),
//  new ProfInterestTile("Economics"),
//  new ProfInterestTile("Fitness"),
//  new ProfInterestTile("Math"),
//  new ProfInterestTile("Biology"),
//  new ProfInterestTile("Banking"),
//  new ProfInterestTile("Literature"),
//  new ProfInterestTile("Marketing"),
//  new ProfInterestTile("Computer Science"),
//  new ProfInterestTile("Research"),
//  new ProfInterestTile("Physics"),
//  new ProfInterestTile("Startups"),
//  new ProfInterestTile("Design"),
//  new ProfInterestTile("Trading"),
//  new ProfInterestTile("Commerce"),
//  new ProfInterestTile("Linguistics"),
//  new ProfInterestTile("Politics"),
//  new ProfInterestTile("Supply Chain"),
//  new ProfInterestTile("Software"),
//  new ProfInterestTile("Neuroscience"),
//  new ProfInterestTile("Engineering"),
//  new ProfInterestTile("Film"),
//  new ProfInterestTile("Accounting"),
//  new ProfInterestTile("Agriculture"),
//  new ProfInterestTile("Anthropology"),
//  new ProfInterestTile("Architecture"),
//  new ProfInterestTile("Archaeology"),
//  new ProfInterestTile("Bioengineering"),
//  new ProfInterestTile("Geosciences"),
//  new ProfInterestTile("Statistics"),
//  new ProfInterestTile("Kinesiology"),
//  new ProfInterestTile("Microbiology"),
//  new ProfInterestTile("E-Commerce"),
//  new ProfInterestTile("Political Science"),
//  new ProfInterestTile("Pre-medicine"),
//  new ProfInterestTile("Sociology"),
//  new ProfInterestTile("Machine Learning"),
//  new ProfInterestTile("Artificial Intelligence"),
//  new ProfInterestTile("Design"),
//  new ProfInterestTile("Construction"),
//  new ProfInterestTile("Higher Education"),
//  new ProfInterestTile("Economics"),
//  new ProfInterestTile("Entrepreneurship"),
//  new ProfInterestTile("Economics"),
//  new ProfInterestTile("Investmenting"),
//  new ProfInterestTile("Trading"),
//  new ProfInterestTile("Cosmetics"),
];

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
    vsco=document['vsco'];
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
      'vsco':vsco
    });

    Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .updateData({'photoUrl': photoUrl});
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
    List<SearchItem<int>> data2 = [
      SearchItem(0, 'Please select your university'),
      SearchItem(1, 'Athabasca University'),
      SearchItem(2, 'MacEwan University'),
      SearchItem(3, 'Mount Royal University'),
      SearchItem(4, 'University of Alberta'),
      SearchItem(5, 'University of Calgary'),
      SearchItem(6, 'University of Lethbridge'),
      SearchItem(7, 'Capilano University'),
      SearchItem(8, 'Emily Carr University of Art and Design'),
      SearchItem(9, 'Kwantlen Polytechnic University'),
      SearchItem(10, 'Royal Roads University'),
      SearchItem(11, 'Simon Fraser University'),
      SearchItem(12, 'Thompson Rivers University'),
      SearchItem(13, 'University of British Columbia'),
      SearchItem(14, 'University of Victoria'),
      SearchItem(15, 'University of the Fraser Valley'),
      SearchItem(16, 'University of Northern British Columbia'),
      SearchItem(17, 'Vancouver Island University'),
      SearchItem(18, 'Brandon University'),
      SearchItem(19, 'University College of the North'),
      SearchItem(20, 'University of Manitoba'),
      SearchItem(21, 'University of Winnipeg'),
      SearchItem(22, 'Université de Saint-Boniface'),
      SearchItem(23, 'Mount Allison University'),
      SearchItem(24, 'St. Thomas University'),
      SearchItem(25, 'University of New Brunswick'),
      SearchItem(26, 'Université de Moncton'),
      SearchItem(27, 'Memorial University of Newfoundland'),
      SearchItem(28, 'Acadia University'),
      SearchItem(29, 'Cape Breton University'),
      SearchItem(30, 'Dalhousie University'),
      SearchItem(31, "University of King's College"),
      SearchItem(32, 'Mount Saint Vincent University'),
      SearchItem(33, 'Saint Francis Xavier University'),
      SearchItem(34, "Saint Mary's University"),
      SearchItem(35, 'Université Sainte-Anne'),
      SearchItem(36, "Algoma University"),
      SearchItem(37, 'Brock University'),
      SearchItem(38, 'Carleton University'),
      SearchItem(39, "Dominican University College"),
      SearchItem(40, 'Lakehead University'),
      SearchItem(41, "Laurentian University"),
      SearchItem(42, 'McMaster University'),
      SearchItem(43, 'Nipissing University'),
      SearchItem(44, "OCAD University"),
      SearchItem(45, "Queen's University"),
      SearchItem(46, "Saint Paul University"),
      SearchItem(47, 'Royal Military College of Canada'),
      SearchItem(48, 'Ryerson University'),
      SearchItem(49, "Trent University"),
      SearchItem(50, 'University of Guelph'),
      SearchItem(51, "University of Ontario Institute of Technology"),
      SearchItem(52, 'University of Ottawa'),
      SearchItem(53, 'University of Toronto'),
      SearchItem(54, "Huron University College"),
      SearchItem(55, 'University of Waterloo'),
      SearchItem(56, "Western University"),
      SearchItem(57, 'University of Windsor'),
      SearchItem(58, 'Wilfrid Laurier University'),
      SearchItem(59, "York University"),
      SearchItem(60, 'University of Prince Edward Island'),
      SearchItem(61, "Bishop's University"),
      SearchItem(62, 'Concordia University'),
      SearchItem(63, 'University of Regina'),
      SearchItem(64, "University of Saskatchewan"),
      SearchItem(65, "The King's University"),
      SearchItem(66, "HEC Montréal"),
      SearchItem(67, 'Concordia University of Edmonton'),
      SearchItem(68, 'McGill University'),
      SearchItem(69, "Université de Montréal"),
    ];
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
          // Container(
          //   color: Colors.white,
          //   height: screenH(310),
          //   width: screenW(600),
          //   child: Column(
          //     children: <Widget>[
          //       SizedBox(
          //         height: screenH(30),
          //       ),
          //       Container(
          //         height: screenH(250),
          //         width: screenW(370),
          //         decoration: BoxDecoration(
          //             boxShadow: [
          //               BoxShadow(
          //                   color: Colors.black.withOpacity(0.35),
          //                   blurRadius: (15),
          //                   spreadRadius: (5),
          //                   offset: Offset(0, 5)),
          //             ],
          //             color: Colors.white,
          //             borderRadius: BorderRadius.all(Radius.circular(15))),
          //         child: socialCardId == null
          //             ? CircularProgressIndicator()
          //             : Column(
          //                 children: <Widget>[
          //                   SizedBox(
          //                     height: screenH(20),
          //                   ),
          //                   Row(
          //                     children: <Widget>[
          //                       SizedBox(
          //                         width: screenW(20),
          //                       ),
          //                       Column(
          //                         crossAxisAlignment:
          //                             CrossAxisAlignment.start,
          //                         children: <Widget>[
          //                           name != null
          //                               ? Text(name,
          //                                   style: TextStyle(
          //                                     fontSize: screenF(18),
          //                                   ))
          //                               : SizedBox(height: screenH(1)),
          //                           SizedBox(
          //                             height: screenH(2),
          //                           ),
          //                           university != null
          //                               ? Text(university,
          //                                   style: TextStyle(
          //                                       fontSize: screenF(13),
          //                                       color: Colors.purple))
          //                               : SizedBox(height: screenH(1)),
          //                           SizedBox(
          //                             height: screenH(2),
          //                           ),
          //                           major != null && gradYear != null
          //                               ? Text(major + ", " + gradYear,
          //                                   style: TextStyle(
          //                                       fontSize: screenF(13),
          //                                       color: Colors.grey))
          //                               : Text(major != null ? major : "",
          //                                   style: TextStyle(
          //                                       fontSize: screenF(13),
          //                                       color: Colors.grey)),
          //                           email != null
          //                               ? Text(email,
          //                                   style: TextStyle(
          //                                       fontSize: screenF(13),
          //                                       color: Colors.grey))
          //                               : SizedBox(height: screenH(1))
          //                         ],
          //                       ),
          //                       SizedBox(
          //                         width: screenW(50),
          //                       ),
          //                       Column(
          //                         children: <Widget>[
          //                           photoUrl != null
          //                               ? CircleAvatar(
          //                                   backgroundImage:
          //                                       NetworkImage(photoUrl),
          //                                   radius: 21,
          //                                 )
          //                               : CircularProgressIndicator(),
          //                           FlatButton(
          //                             onPressed: () {
          //                               setImage();
          //                             },
          //                             color: Colors.transparent,
          //                             child: Row(
          //                               children: <Widget>[
          //                                 Icon(
          //                                   Icons.edit,
          //                                   size: 12,
          //                                   color: Colors.blueAccent[700],
          //                                 ),
          //                                 SizedBox(
          //                                   width: 2,
          //                                 ),
          //                                 Text(
          //                                   "Edit",
          //                                   textAlign: TextAlign.left,
          //                                   style: TextStyle(
          //                                       fontSize: 12,
          //                                       color:
          //                                           Colors.blueAccent[700]),
          //                                 ),
          //                               ],
          //                             ),
          //                           )
          //                         ],
          //                       ),

          //                       // IconButton(
          //                       //   onPressed: () {},
          //                       //   color: Colors.black,
          //                       //   icon: Icon(Icons.create),
          //                       // )
          //                     ],
          //                   ),
          //                   Padding(
          //                     padding: EdgeInsets.symmetric(
          //                         horizontal: screenW(30.0)),
          //                     child: Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       children: <Widget>[
          //                         snapchat != null
          //                             ? isSwitched == true
          //                                 ? Column(
          //                                     children: <Widget>[
          //                                       Icon(
          //                                         FontAwesome.snapchat_square,
          //                                         color: Color(0xFFfffc00),
          //                                       ),
          //                                       SizedBox(
          //                                         width: screenW(10),
          //                                       ),
          //                                       Text(snapchat,
          //                                           style: TextStyle(
          //                                               color: Colors.black,
          //                                               fontSize:
          //                                                   screenF(12))),
          //                                     ],
          //                                   )
          //                                 : SizedBox(
          //                                     height: screenH(1),
          //                                   )
          //                             : SizedBox(
          //                                 height: screenH(1),
          //                               ),
          //                         instagram != null
          //                             ? isSwitched == true
          //                                 ? Column(
          //                                     children: <Widget>[
          //                                       Icon(
          //                                         MaterialCommunityIcons
          //                                             .instagram,
          //                                         color: Color(0xFF8803fc),
          //                                       ),
          //                                       SizedBox(
          //                                         width: screenW(10),
          //                                       ),
          //                                       Text(instagram,
          //                                           style: TextStyle(
          //                                               color: Colors.black,
          //                                               fontSize:
          //                                                   screenF(12))),
          //                                     ],
          //                                   )
          //                                 : SizedBox(
          //                                     height: screenH(1),
          //                                   )
          //                             : SizedBox(
          //                                 height: screenH(1),
          //                               ),
          //                         twitter != null
          //                             ? isSwitched == true
          //                                 ? Column(
          //                                     children: <Widget>[
          //                                       Icon(
          //                                         MaterialCommunityIcons
          //                                             .twitter_box,
          //                                         color: Colors.blue,
          //                                       ),
          //                                       Text(twitter,
          //                                           style: TextStyle(
          //                                               color: Colors.black,
          //                                               fontSize:
          //                                                   screenF(12))),
          //                                     ],
          //                                   )
          //                                 : SizedBox(
          //                                     height: screenH(1),
          //                                   )
          //                             : SizedBox(
          //                                 height: screenH(1),
          //                               )
          //                       ],
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: screenH(25),
          //                   ),
          //                   Row(
          //                     children: <Widget>[
          //                       SizedBox(width: 20.0),
          //                       Text(
          //                           interestString != null
          //                               ? interestString
          //                               : "",
          //                           style: TextStyle(
          //                               color: Color(0xFF8803fc),
          //                               fontSize: screenF(13)))
          //                     ],
          //                   )
          //                 ],
          //               ),
          //       )
          //     ],
          //   ),
          // ),
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
                                  backgroundImage: NetworkImage(photoUrl),
                                  radius: screenH(45),
                                )
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
//                     Row(
//                       children: <Widget>[
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           'Name',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 20.0),
//                       child: Column(
//                         children: <Widget>[
//                           Theme(
//                             // data: theme.copyWith(primaryColor: Colors.black),
//                             data: new ThemeData(
//                                 primaryColor: Colors.black,
//                                 accentColor: Colors.black,
//                                 hintColor: Colors.black),
//                             child: TextField(
//                               onSubmitted: (value) {
//                                 if (value != '' && value != null) {
//                                   setState(() {
//                                     name = value;
//                                   });
//                                 }
//                               },
//                               decoration: InputDecoration(
//                                   border: new UnderlineInputBorder(
//                                       borderSide:
//                                           new BorderSide(color: Colors.black))),
//                               style:
//                                   TextStyle(fontSize: 18, color: Colors.grey),
//                               cursorColor: Colors.black,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                       width: screenW(70),
//                     ),
//                     Row(
//                       children: <Widget>[
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           'Email',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 20.0),
//                       child: Column(
//                         children: <Widget>[
//                           Theme(
//                             // data: theme.copyWith(primaryColor: Colors.black),
//                             data: new ThemeData(
//                                 primaryColor: Colors.black,
//                                 accentColor: Colors.black,
//                                 hintColor: Colors.black),
//                             child: TextField(
//                               onSubmitted: (value) {
//                                 if (value != '' && value != null) {
//                                   setState(() {
//                                     email = value;
//                                   });
//                                 }
//                               },
//                               decoration: InputDecoration(
//                                   border: new UnderlineInputBorder(
//                                       borderSide:
//                                           new BorderSide(color: Colors.black))),
//                               style:
//                                   TextStyle(fontSize: 18, color: Colors.grey),
//                               cursorColor: Colors.black,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     Row(
//                       children: <Widget>[
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           'University',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(20),
//                       child: Align(
//                         alignment: Alignment.topLeft,
//                         child: Container(
//                           width: 800,
//                           height: 70,
//                           color: Colors.white,
//                           child: FlutterSearchPanel<int>(
//                             padding: EdgeInsets.all(10.0),
//                             selected: 0,
//                             title: 'Select University',
//                             data: data2,
//                             icon: new Icon(Icons.school, color: Colors.black),
//                             color: Color(0xFFECE9E4),
//                             textStyle: new TextStyle(
//                               color: Colors.black,
//                               fontSize: 15.0,
//                             ),
//                             onChanged: (int value) {
//                               if (value != null) {
//                                 setState(() {
//                                   university = data2[value].text;
//                                 });
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     Row(
//                       children: <Widget>[
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           'Program',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 20.0),
//                       child: Column(
//                         children: <Widget>[
//                           Theme(
//                             // data: theme.copyWith(primaryColor: Colors.black),
//                             data: new ThemeData(
//                                 primaryColor: Colors.black,
//                                 accentColor: Colors.black,
//                                 hintColor: Colors.black),
//                             child: TextField(
//                               onSubmitted: (value) {
//                                 if (value != '' && value != null) {
//                                   setState(() {
//                                     major = value;
//                                   });
//                                 }
//                               },
// //
//                               decoration: InputDecoration(
//                                   border: new UnderlineInputBorder(
//                                       borderSide:
//                                           new BorderSide(color: Colors.black))),
//                               style:
//                                   TextStyle(fontSize: 18, color: Colors.grey),
//                               cursorColor: Colors.black,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     Row(
//                       children: <Widget>[
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           'Grad Year',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 20.0),
//                       child: Column(
//                         children: <Widget>[
//                           Theme(
//                             // data: theme.copyWith(primaryColor: Colors.black),
//                             data: new ThemeData(
//                                 primaryColor: Colors.black,
//                                 accentColor: Colors.black,
//                                 hintColor: Colors.black),
//                             child: TextField(
//                               onSubmitted: (value) {
//                                 if (value != '' && value != null) {
//                                   setState(() {
//                                     major = major + ', ' + value;
//                                   });
//                                 }
//                               },
//                               decoration: InputDecoration(
//                                   border: new UnderlineInputBorder(
//                                       borderSide:
//                                           new BorderSide(color: Colors.black))),
//                               style:
//                                   TextStyle(fontSize: 18, color: Colors.grey),
//                               cursorColor: Colors.black,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),

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
//                      new OutlineButton(
//                          padding: EdgeInsets.all(screenH(16)),
//                          color: Color(0xFF8803fc),
//                          child: new Text(
//                            "Choose 3 social interest tags",
//                            style: TextStyle(
//                                color: Color(0xFF8803fc),
//                                fontSize: screenF(16)),
//                          ),
//                          onPressed: () async {
//                            DocumentSnapshot doc = await Firestore.instance
//                                .collection('variableData')
//                                .document('interests')
//                                .get();
//                            List<dynamic> socialInterests =
//                                doc['socialInterests'];
//                            setState(() {
//                              for (int i = 0; i < socialInterests.length; i++) {
//                                interestList.add(
//                                    new SocialInterestTile(socialInterests[i]));
//                              }
//                            });
//                            showSearch(
//                                context: context, delegate: SocialDataSearch());
//                          },
//                          shape: new RoundedRectangleBorder(
//                              side: BorderSide(
//                                color: Color(0xFF1458EA),
//                              ),
//                              borderRadius: new BorderRadius.circular(30.0))),
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

    DocumentSnapshot social = await Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .collection('socialcard')
        .document('social')
        .get();
    if (social['photoUrl'] ==
        "https://firebasestorage.googleapis.com/v0/b/dime-87d60.appspot.com/o/defaultprofile.png?alt=media&token=8cd5318b-9593-4837-a9f9-2a22c87463ef") {
      Firestore.instance
          .collection('users')
          .document(currentUserModel.uid)
          .updateData({'photoUrl': photoUrl});
    }
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

  String text = "Nothing to show";
  bool isSwitched2 = true;

  @override
  Widget build(BuildContext context) {
    List<SearchItem<int>> data2 = [
      SearchItem(0, 'Please select your university'),
      SearchItem(1, 'Athabasca University'),
      SearchItem(2, 'MacEwan University'),
      SearchItem(3, 'Mount Royal University'),
      SearchItem(4, 'University of Alberta'),
      SearchItem(5, 'University of Calgary'),
      SearchItem(6, 'University of Lethbridge'),
      SearchItem(7, 'Capilano University'),
      SearchItem(8, 'Emily Carr University of Art and Design'),
      SearchItem(9, 'Kwantlen Polytechnic University'),
      SearchItem(10, 'Royal Roads University'),
      SearchItem(11, 'Simon Fraser University'),
      SearchItem(12, 'Thompson Rivers University'),
      SearchItem(13, 'University of British Columbia'),
      SearchItem(14, 'University of Victoria'),
      SearchItem(15, 'University of the Fraser Valley'),
      SearchItem(16, 'University of Northern British Columbia'),
      SearchItem(17, 'Vancouver Island University'),
      SearchItem(18, 'Brandon University'),
      SearchItem(19, 'University College of the North'),
      SearchItem(20, 'University of Manitoba'),
      SearchItem(21, 'University of Winnipeg'),
      SearchItem(22, 'Université de Saint-Boniface'),
      SearchItem(23, 'Mount Allison University'),
      SearchItem(24, 'St. Thomas University'),
      SearchItem(25, 'University of New Brunswick'),
      SearchItem(26, 'Université de Moncton'),
      SearchItem(27, 'Memorial University of Newfoundland'),
      SearchItem(28, 'Acadia University'),
      SearchItem(29, 'Cape Breton University'),
      SearchItem(30, 'Dalhousie University'),
      SearchItem(31, "University of King's College"),
      SearchItem(32, 'Mount Saint Vincent University'),
      SearchItem(33, 'Saint Francis Xavier University'),
      SearchItem(34, "Saint Mary's University"),
      SearchItem(35, 'Université Sainte-Anne'),
      SearchItem(36, "Algoma University"),
      SearchItem(37, 'Brock University'),
      SearchItem(38, 'Carleton University'),
      SearchItem(39, "Dominican University College"),
      SearchItem(40, 'Lakehead University'),
      SearchItem(41, "Laurentian University"),
      SearchItem(42, 'McMaster University'),
      SearchItem(43, 'Nipissing University'),
      SearchItem(44, "OCAD University"),
      SearchItem(45, "Queen's University"),
      SearchItem(46, "Saint Paul University"),
      SearchItem(47, 'Royal Military College of Canada'),
      SearchItem(48, 'Ryerson University'),
      SearchItem(49, "Trent University"),
      SearchItem(50, 'University of Guelph'),
      SearchItem(51, "University of Ontario Institute of Technology"),
      SearchItem(52, 'University of Ottawa'),
      SearchItem(53, 'University of Toronto'),
      SearchItem(54, "Huron University College"),
      SearchItem(55, 'University of Waterloo'),
      SearchItem(56, "Western University"),
      SearchItem(57, 'University of Windsor'),
      SearchItem(58, 'Wilfrid Laurier University'),
      SearchItem(59, "York University"),
      SearchItem(60, 'University of Prince Edward Island'),
      SearchItem(61, "Bishop's University"),
      SearchItem(62, 'Concordia University'),
      SearchItem(63, 'University of Regina'),
      SearchItem(64, "University of Saskatchewan"),
      SearchItem(65, "The King's University"),
      SearchItem(66, "HEC Montréal"),
      SearchItem(67, 'Concordia University of Edmonton'),
      SearchItem(68, 'McGill University'),
      SearchItem(69, "Université de Montréal"),
    ];
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
          // Container(
          //   color: Colors.white,
          //   height: screenH(310),
          //   width: screenW(600),
          //   child: Column(
          //     children: <Widget>[
          //       SizedBox(
          //         height: screenH(30),
          //       ),
          //       Container(
          //         height: screenH(250),
          //         width: screenW(370),
          //         decoration: BoxDecoration(
          //             boxShadow: [
          //               BoxShadow(
          //                   color: Colors.black.withOpacity(0.35),
          //                   blurRadius: (15),
          //                   spreadRadius: (5),
          //                   offset: Offset(0, 5)),
          //             ],
          //             color: Colors.white,
          //             borderRadius: BorderRadius.all(Radius.circular(15))),
          //         child: profCardId == null
          //             ? CircularProgressIndicator()
          //             : Column(
          //                 children: <Widget>[
          //                   SizedBox(
          //                     height: screenH(20),
          //                   ),
          //                   Row(
          //                     children: <Widget>[
          //                       SizedBox(
          //                         width: screenW(20),
          //                       ),
          //                       Column(
          //                         crossAxisAlignment:
          //                             CrossAxisAlignment.start,
          //                         children: <Widget>[
          //                           name != null
          //                               ? Text(name,
          //                                   style: TextStyle(
          //                                     fontSize: screenF(18),
          //                                   ))
          //                               : SizedBox(height: screenH(1)),
          //                           SizedBox(
          //                             height: screenH(2),
          //                           ),
          //                           university != null
          //                               ? Text(university,
          //                                   style: TextStyle(
          //                                       fontSize: screenF(13),
          //                                       color: Color(0xFF1976d2)))
          //                               : SizedBox(height: screenH(1)),
          //                           SizedBox(
          //                             height: screenH(2),
          //                           ),
          //                           major != null && gradYear != null
          //                               ? Text(major + ", " + gradYear,
          //                                   style: TextStyle(
          //                                       fontSize: screenF(13),
          //                                       color: Colors.grey))
          //                               : Text(major != null ? major : "",
          //                                   style: TextStyle(
          //                                       fontSize: screenF(13),
          //                                       color: Colors.grey)),
          //                           email != null
          //                               ? Text(email,
          //                                   style: TextStyle(
          //                                       fontSize: screenF(13),
          //                                       color: Colors.grey))
          //                               : SizedBox(height: screenH(1))
          //                         ],
          //                       ),
          //                       SizedBox(
          //                         width: screenW(50),
          //                       ),
          //                       Column(
          //                         children: <Widget>[
          //                           photoUrl != null
          //                               ? CircleAvatar(
          //                                   backgroundImage:
          //                                       NetworkImage(photoUrl),
          //                                   radius: 21,
          //                                 )
          //                               : CircularProgressIndicator(),
          //                           FlatButton(
          //                             onPressed: () {
          //                               setImage();
          //                             },
          //                             color: Colors.transparent,
          //                             child: Row(
          //                               children: <Widget>[
          //                                 Icon(
          //                                   Icons.edit,
          //                                   size: 12,
          //                                   color: Colors.blueAccent[700],
          //                                 ),
          //                                 SizedBox(
          //                                   width: 2,
          //                                 ),
          //                                 Text(
          //                                   "Edit",
          //                                   textAlign: TextAlign.left,
          //                                   style: TextStyle(
          //                                       fontSize: 12,
          //                                       color:
          //                                           Colors.blueAccent[700]),
          //                                 ),
          //                               ],
          //                             ),
          //                           )
          //                         ],
          //                       ),
          //                     ],
          //                   ),
          //                   Padding(
          //                     padding: EdgeInsets.symmetric(
          //                         horizontal: screenW(30.0)),
          //                     child: Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       children: <Widget>[
          //                         linkedIn != null
          //                             ? isSwitched2 == true
          //                                 ? Column(
          //                                     children: <Widget>[
          //                                       Icon(
          //                                         FontAwesome.linkedin_square,
          //                                         color: Color(0xFF0077B5),
          //                                       ),
          //                                       SizedBox(
          //                                         width: screenW(10),
          //                                       ),
          //                                       Text(linkedIn,
          //                                           style: TextStyle(
          //                                               color: Colors.black,
          //                                               fontSize:
          //                                                   screenF(12))),
          //                                     ],
          //                                   )
          //                                 : SizedBox(
          //                                     height: screenH(1),
          //                                   )
          //                             : SizedBox(
          //                                 height: screenH(1),
          //                               ),
          //                         github != null
          //                             ? isSwitched2 == true
          //                                 ? Column(
          //                                     children: <Widget>[
          //                                       Icon(
          //                                         MaterialCommunityIcons
          //                                             .github_box,
          //                                         color: Colors.black,
          //                                       ),
          //                                       SizedBox(
          //                                         width: screenW(10),
          //                                       ),
          //                                       Text(github,
          //                                           style: TextStyle(
          //                                               color: Colors.black,
          //                                               fontSize:
          //                                                   screenF(12))),
          //                                     ],
          //                                   )
          //                                 : SizedBox(
          //                                     height: screenH(1),
          //                                   )
          //                             : SizedBox(
          //                                 height: screenH(1),
          //                               ),
          //                         twitter != null
          //                             ? isSwitched2 == true
          //                                 ? Column(
          //                                     children: <Widget>[
          //                                       Icon(
          //                                         MaterialCommunityIcons
          //                                             .twitter_box,
          //                                         color: Colors.blue,
          //                                       ),
          //                                       Text(twitter,
          //                                           style: TextStyle(
          //                                               color: Colors.black,
          //                                               fontSize:
          //                                                   screenF(12))),
          //                                     ],
          //                                   )
          //                                 : SizedBox(
          //                                     height: screenH(1),
          //                                   )
          //                             : SizedBox(
          //                                 height: screenH(1),
          //                               )
          //                       ],
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: screenH(25),
          //                   ),
          //                   Row(
          //                     children: <Widget>[
          //                       SizedBox(width: 20.0),
          //                       Text(
          //                           interestString != null
          //                               ? interestString
          //                               : "",
          //                           style: TextStyle(
          //                               color: Color(0xFF1976d2),
          //                               fontSize: screenF(13)))
          //                     ],
          //                   )
          //                 ],
          //               ),
          //       )
          //     ],
          //   ),
          // ),
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
                          photoUrl != null
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(photoUrl),
                                  radius: screenH(45),
                                )
                              : CircularProgressIndicator(),
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
//                     Row(
//                       children: <Widget>[
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           'Name',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 20.0),
//                       child: Column(
//                         children: <Widget>[
//                           Theme(
//                             // data: theme.copyWith(primaryColor: Colors.black),
//                             data: new ThemeData(
//                                 primaryColor: Colors.black,
//                                 accentColor: Colors.black,
//                                 hintColor: Colors.black),
//                             child: TextField(
//                               onSubmitted: (value) {
//                                 if (value != '' && value != null) {
//                                   setState(() {
//                                     name = value;
//                                   });
//                                 }
//                               },
//                               decoration: InputDecoration(
//                                   border: new UnderlineInputBorder(
//                                       borderSide:
//                                           new BorderSide(color: Colors.black))),
//                               style:
//                                   TextStyle(fontSize: 18, color: Colors.grey),
//                               cursorColor: Colors.black,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                       width: screenW(70),
//                     ),
//                     Row(
//                       children: <Widget>[
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           'Email',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 20.0),
//                       child: Column(
//                         children: <Widget>[
//                           Theme(
//                             // data: theme.copyWith(primaryColor: Colors.black),
//                             data: new ThemeData(
//                                 primaryColor: Colors.black,
//                                 accentColor: Colors.black,
//                                 hintColor: Colors.black),
//                             child: TextField(
//                               onSubmitted: (value) {
//                                 if (value != '' && value != null) {
//                                   setState(() {
//                                     email = value;
//                                   });
//                                 }
//                               },
//                               decoration: InputDecoration(
//                                   border: new UnderlineInputBorder(
//                                       borderSide:
//                                           new BorderSide(color: Colors.black))),
//                               style:
//                                   TextStyle(fontSize: 18, color: Colors.grey),
//                               cursorColor: Colors.black,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),

//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     Row(
//                       children: <Widget>[
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           'University',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(20),
//                       child: Align(
//                         alignment: Alignment.topLeft,
//                         child: Container(
//                           width: 800,
//                           height: 70,
//                           color: Colors.white,
//                           child: FlutterSearchPanel<int>(
//                             padding: EdgeInsets.all(10.0),
//                             selected: 0,
//                             title: 'Select University',
//                             data: data2,
//                             icon: new Icon(Icons.school, color: Colors.black),
//                             color: Color(0xFFECE9E4),
//                             textStyle: new TextStyle(
//                               color: Colors.black,
//                               fontSize: 15.0,
//                             ),
//                             onChanged: (int value) {
//                               if (value != null) {
//                                 setState(() {
//                                   university = data2[value].text;
//                                 });
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Container(
//                     //   margin: EdgeInsets.symmetric(horizontal: 20.0),
//                     //   child: Column(
//                     //     children: <Widget>[
//                     //       Theme(
//                     //         // data: theme.copyWith(primaryColor: Colors.black),
//                     //         data: new ThemeData(
//                     //             primaryColor: Colors.black,
//                     //             accentColor: Colors.black,
//                     //             hintColor: Colors.black),
//                     //         child: TextField(
//                     //           decoration: InputDecoration(
//                     //               border: new UnderlineInputBorder(
//                     //                   borderSide:
//                     //                       new BorderSide(color: Colors.black))),
//                     //           style: TextStyle(fontSize: 18, color: Colors.grey),
//                     //           cursorColor: Colors.black,
//                     //         ),
//                     //       )
//                     //     ],
//                     //   ),
//                     // ),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     Row(
//                       children: <Widget>[
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           'Program',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),

//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 20.0),
//                       child: Column(
//                         children: <Widget>[
//                           Theme(
//                             // data: theme.copyWith(primaryColor: Colors.black),
//                             data: new ThemeData(
//                                 primaryColor: Colors.black,
//                                 accentColor: Colors.black,
//                                 hintColor: Colors.black),
//                             child: TextField(
//                               onSubmitted: (value) {
//                                 if (value != '' && value != null) {
//                                   setState(() {
//                                     major = value;
//                                   });
//                                 }
//                               },
// //
//                               decoration: InputDecoration(
//                                   border: new UnderlineInputBorder(
//                                       borderSide:
//                                           new BorderSide(color: Colors.black))),
//                               style:
//                                   TextStyle(fontSize: 18, color: Colors.grey),
//                               cursorColor: Colors.black,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                     ),

//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     Row(
//                       children: <Widget>[
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           'Grad Year',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 20.0),
//                       child: Column(
//                         children: <Widget>[
//                           Theme(
//                             // data: theme.copyWith(primaryColor: Colors.black),
//                             data: new ThemeData(
//                                 primaryColor: Colors.black,
//                                 accentColor: Colors.black,
//                                 hintColor: Colors.black),
//                             child: TextField(
//                               onSubmitted: (value) {
//                                 if (value != '' && value != null) {
//                                   setState(() {
//                                     major = major + ', ' + value;
//                                   });
//                                 }
//                               },
// //
//                               decoration: InputDecoration(
//                                   border: new UnderlineInputBorder(
//                                       borderSide:
//                                           new BorderSide(color: Colors.black))),
//                               style:
//                                   TextStyle(fontSize: 18, color: Colors.grey),
//                               cursorColor: Colors.black,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
                      SizedBox(
                        height: 10.0,
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
                              // data: theme.copyWith(primaryColor: Colors.black),
                              data: new ThemeData(
                                  primaryColor: Colors.black,
                                  accentColor: Colors.black,
                                  hintColor: Colors.black),
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
                              // data: theme.copyWith(primaryColor: Colors.black),
                              data: new ThemeData(
                                  primaryColor: Colors.black,
                                  accentColor: Colors.black,
                                  hintColor: Colors.black),
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
//                      new OutlineButton(
//                          padding: EdgeInsets.all(screenH(16)),
//                          color: Color(0xFF1458EA),
//                          child: new Text(
//                            "Choose 3 professional interest tags",
//                            style: TextStyle(
//                                color: Color(0xFF1458EA), fontSize: 15),
//                          ),
//                          onPressed: () async {
//                            DocumentSnapshot doc = await Firestore.instance
//                                .collection('variableData')
//                                .document('interests')
//                                .get();
//                            List<dynamic> profInterests = doc['profInterests'];
//                            setState(() {
//                              for (int i = 0; i < profInterests.length; i++) {
//                                profInterestList.add(
//                                    new ProfInterestTile(profInterests[i]));
//                              }
//                            });
//
//                            showSearch(
//                                context: context, delegate: ProfDataSearch());
//                          },
//                          shape: new RoundedRectangleBorder(
//                              borderRadius: new BorderRadius.circular(30.0))),
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
