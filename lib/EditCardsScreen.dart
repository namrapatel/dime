import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:Dime/homePage.dart';
import 'package:Dime/profileScreen.dart';
import 'package:Dime/viewCards.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:flutter_search_panel/flutter_search_panel.dart';
import 'package:flutter_search_panel/search_item.dart';
import 'login.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'models/socialcard.dart';
import 'socialTags.dart';
import 'professionalTags.dart';


String selectedItemString;
String selectedWItemString;

String selectedItemString2;
String selectedWItemString2;
String socialCardId;
String profCardId;
final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;

class TabsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabs App',
      theme: ThemeData(primarySwatch: Colors.amber,

          primaryColor: Colors.black,
          fontFamily: 'Futura'

      ),
      home: CardEdit(),
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
String saved='';
  String name;
  String university;
   String major;
   String snapchat;
   String instagram;
   String twitter;

   String photoUrl;
String interestString="";



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
    List<dynamic> interests=[];
    QuerySnapshot query=await Firestore.instance.collection('users').document(
        currentUserModel.uid).collection('socialcard').getDocuments();

    for(var document in query.documents) {
      setState(() {
        socialCardId= document.documentID;



//      String photoUrl=document['photoUrl'];
        major=document['major'];
        name= document['displayName'];
        university=document['university'];
        snapchat= document['snapchat'];
        instagram= document['instagram'];
        twitter=document['twitter'];
        photoUrl=document['photoUrl'];
        interests=document['interests'];
      });

//      bio=document['bio'];

    }

    for(int i=0;i<interests.length;i++){
      if(i==interests.length-1){
        interestString=interestString+ interests[i];
      }else{
        interestString=interestString+ interests[i]+", ";
      }

    }
    print(interestString);

  }


  updateSocialCard(){
      Firestore.instance.collection('users').document(currentUserModel.uid).collection('socialcard').document(socialCardId)
          .updateData({

      'displayName':name,
        'major':major,
        'university':university,
        'snapchat':snapchat,
        'instagram':instagram,
        'twitter':twitter,
        'photoUrl':photoUrl





      });
  }
Future<void> uploadImage() async{
    String user= currentUserModel.uid+Timestamp.now().toString();
  StorageReference firebaseStorageRef=
  FirebaseStorage.instance.ref().child('$user.jpg');
  StorageUploadTask task= firebaseStorageRef.putFile(_image);

  var downloadUrl=await (await task.onComplete).ref.getDownloadURL();
  setState(() {
    photoUrl=downloadUrl.toString();
  });




}



  Future<void> setImage() async {
    var sampleImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = sampleImage;
    });
    uploadImage();

  }

  String text = "Nothing to show";
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
      SearchItem(56, "University of Western Ontario"),
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

        Stack(children: <Widget>[
          Column(children: <Widget>[
            Container(
              color: Colors.white,
              height: screenH(310),
              width: screenW(600),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: screenH(30),
                  ),
                  Container(
                    height: screenH(250),
                    width: screenW(370),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.35),
                              blurRadius: (20),
                              spreadRadius: (5),
                              offset: Offset(0, 5)),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: socialCardId==null?CircularProgressIndicator():
                    Column(

                      children: <Widget>[
                        SizedBox(
                          height: screenH(20),
                        ),
                        Row(
                          children: <Widget>[

                            SizedBox(
                              width: screenW(20),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                name!=null?
                                Text(name,
                                    style: TextStyle(
                                      fontSize: screenF(18),
                                    )):
                                    SizedBox(height:screenH(1)),
                                SizedBox(
                                  height: screenH(2),
                                ),
                                university!=null?
                                Text(university,
                                    style: TextStyle(
                                        fontSize: screenF(13),
                                        color: Colors.purple)):
    SizedBox(height:screenH(1)),
                                SizedBox(
                                  height: screenH(2),
                                ),
                                major!=null?
                                Text(major,
                                    style: TextStyle(
                                        fontSize: screenF(13), color: Colors.grey)):
                                          SizedBox(height:screenH(1))
                              ],
                            ),
                            SizedBox(
                              width: screenW(50),
                            ),
                            Column(
                              children: <Widget>[
                                photoUrl!=null?
                                CircleAvatar(
                                  backgroundImage:
                                  NetworkImage(photoUrl),
                                  radius: 21,
                                ):CircularProgressIndicator(),

                                FlatButton(
                                  onPressed: (){
                                    setImage();
                                  },
                                  color: Colors.transparent,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.edit, size: 12, color: Colors.blueAccent[700],),
                                      SizedBox(width: 2,),
                                      Text("Edit", textAlign: TextAlign.left, style: TextStyle(fontSize: 12, color: Colors.blueAccent[700]),),
                                    ],
                                  ),
                                )

                              ],
                            ),

                            // IconButton(
                            //   onPressed: () {},
                            //   color: Colors.black,
                            //   icon: Icon(Icons.create),
                            // )
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenW(30.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              snapchat!=null?
                              Column(
                                children: <Widget>[
                                  Icon(
                                    FontAwesome.snapchat_square,
                                    color: Color(0xFFfffc00),
                                  ),
                                  SizedBox(
                                    width: screenW(10),
                                  ),
                                  Text(snapchat,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenF(12))),
                                ],
                              ):SizedBox(
                              height: screenH(1),
                              ),
                              instagram!=null?
                              Column(
                                children: <Widget>[
                                  Icon(
                                    MaterialCommunityIcons.instagram,
                                    color: Color(0xFF8803fc),
                                  ),
                                  SizedBox(
                                    width: screenW(10),
                                  ),
                                  Text(instagram,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenF(12))),
                                ],
                              )
                                  :SizedBox(
                                height: screenH(1),
                              ),
                              twitter!=null?
                              Column(
                                children: <Widget>[
                                  Icon(
                                    MaterialCommunityIcons.twitter_box,
                                    color: Colors.blue,
                                  ),
                                  Text(twitter,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenF(12))),
                                ],
                              ):SizedBox(
                                height: screenH(1),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenH(25),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 20.0),
                            Text(interestString!=null?interestString:"",
                                style: TextStyle(
                                    color: Color(0xFF8803fc), fontSize: screenF(13)))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
                color: Colors.white,
                height: screenH(415),
                child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      Column(children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(

                          height: 20.0,

                          width: screenW(70),

                        ),
                        Row(
                          children: <Widget>[

                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Name',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
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

                                  onSubmitted: (value){
                                    if(value!=''&&value!=null) {
                                      setState(() {
                                        name = value;
                                      });

                                    }
                                  },
                                  decoration: InputDecoration(
                                      border: new UnderlineInputBorder(
                                          borderSide:
                                          new BorderSide(color: Colors.black))),
                                  style: TextStyle(fontSize: 18, color: Colors.grey),
                                  cursorColor: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'University',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),

                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 800,
                              height: 70,
                              color: Colors.white,
                              child: FlutterSearchPanel<int>(
                                padding: EdgeInsets.all(10.0),
                                selected: 0,
                                title: 'Select University',
                                data: data2,
                                icon: new Icon(Icons.school, color: Colors.black),
                                color: Color(0xFFECE9E4),
                                textStyle: new TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                                onChanged: (int value){
                                  if(value!=null) {
                                    setState(() {university = data2[value].text;
                                    });

                                  }
                                },


                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Program',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
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
                                  onSubmitted: (value){
                                    if(value!=''&&value!=null) {
                                      setState(() {
                                        major = value;
                                      });

                                    }
                                  },
//
                                  decoration: InputDecoration(
                                      border: new UnderlineInputBorder(
                                          borderSide:
                                          new BorderSide(color: Colors.black))),
                                  style: TextStyle(fontSize: 18, color: Colors.grey),
                                  cursorColor: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Grad Year',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
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
                                  onSubmitted: (value){
                                    if(value!=''&&value!=null) {
                                      setState(() {
                                        major = major+', '+ value;
                                      });

                                    }
                                  },
//
                                  decoration: InputDecoration(
                                      border: new UnderlineInputBorder(
                                          borderSide:
                                          new BorderSide(color: Colors.black))),
                                  style: TextStyle(fontSize: 18, color: Colors.grey),
                                  cursorColor: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Snapchat',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
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
                                  onSubmitted: (value){
                                    if(value!=''&&value!=null) {
                                      setState(() {
                                        snapchat=value;
                                      });

                                    }
                                  },
                                  decoration: InputDecoration(
                                      prefixText: '@',
                                      prefixStyle: TextStyle(color: Colors.grey),
                                      border: new UnderlineInputBorder(
                                          borderSide:
                                          new BorderSide(color: Colors.black))),
                                  style: TextStyle(fontSize: 18, color: Colors.grey),
                                  cursorColor: Colors.black,
                                ),
                              )
                            ],

                          ),
                        ),

                        SizedBox(
                          height: 20.0,
                        ),

                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Instagram',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],

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
                                  onSubmitted: (value){
                                    if(value!=''&&value!=null) {
                                      setState(() {
                                        instagram=value;
                                      });

                                    }
                                  },
                                  decoration: InputDecoration(
                                      prefixText: '@',
                                      prefixStyle: TextStyle(color: Colors.grey),
                                      border: new UnderlineInputBorder(
                                          borderSide:
                                          new BorderSide(color: Colors.black))),
                                  style: TextStyle(fontSize: 18, color: Colors.grey),
                                  cursorColor: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Twitter',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
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
                                  onSubmitted: (value){
                                    if(value!=''&&value!=null) {
                                      setState(() {
                                        twitter=value;
                                      });

                                    }
                                  },
                                  decoration: InputDecoration(

                                      prefixText: '@',
                                      prefixStyle: TextStyle(color: Colors.grey),
                                      border: new UnderlineInputBorder(
                                          borderSide:
                                          new BorderSide(color: Colors.black))),
                                  style: TextStyle(fontSize: 18, color: Colors.grey),
                                  cursorColor: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                               Row(
                                 children: <Widget>[
                                   SizedBox(
                                     width: screenW(20),
                                   ),
                                   Text(
                              'Interests',
                              style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: screenW(30),
                            ),
                            new OutlineButton(
                              padding: EdgeInsets.all(15),
                              color: Color(0xFF8803fc),
                            child: new Text("Choose 3 social interest tags", style: TextStyle(color: Color(0xFF8803fc), fontSize: 15),),
                            onPressed: (){
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SocialTags()),
                              );
                            },
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                          )


                                 ],
                               ),
                      ]),
                      SizedBox(
                        height: 40.0,
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            width: 200,
                            height: 50,
                            child: FloatingActionButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                              elevation: screenH(5),
                              onPressed: () {
                                updateSocialCard();
                                setState(() {
                                  saved='Changes saved';
                                });
                              },
                              backgroundColor: Color(0xFFECE9E4),
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    fontSize: screenF(20), color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text(saved,style: TextStyle(
                              fontSize: screenF(20), color: Colors.black)),
                          SizedBox(height: 50,)
                        ],
                      )
                    ]))
          ]),
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


String saved='';
  String name;
  String university;
  String major;
  String linkedIn;
  String github;
  String twitter;
  String interestString="";
  String photoUrl;

  File _image;
  getProfInfo() async {
List<dynamic> interests=[];
    QuerySnapshot query=await Firestore.instance.collection('users').document(
        currentUserModel.uid).collection('profcard').getDocuments();

    for(var document in query.documents) {
      setState(() {
        profCardId= document.documentID;




        major=document['major'];
        name= document['displayName'];
        university=document['university'];
        github= document['github'];
        linkedIn= document['linkedIn'];
        twitter=document['twitter'];
        photoUrl=document['photoUrl'];
        interests=document['interests'];
      });

//      bio=document['bio'];

    }

    for(int i=0;i<interests.length;i++){
      if(i==interests.length-1){
        interestString=interestString+ interests[i];
      }else{
        interestString=interestString+ interests[i]+", ";
      }

    }
    print(interestString);

  }

  updateProfCard(){
    Firestore.instance.collection('users').document(currentUserModel.uid).collection('profcard').document(profCardId)
        .updateData({

      'displayName':name,
      'major':major,
      'university':university,
      'github':github,
      'linkedIn':linkedIn,
      'twitter':twitter,
      'photoUrl':photoUrl





    });
  }
  Future<void> uploadImage() async{
    String user= currentUserModel.uid+Timestamp.now().toString();
    StorageReference firebaseStorageRef=
    FirebaseStorage.instance.ref().child('$user.jpg');
    StorageUploadTask task= firebaseStorageRef.putFile(_image);

    var downloadUrl=await (await task.onComplete).ref.getDownloadURL();
    setState(() {
      photoUrl=downloadUrl.toString();
    });




  }



  Future<void> setImage() async {
    var sampleImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = sampleImage;
    });
    uploadImage();

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
      SearchItem(56, "University of Western Ontario"),
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

        Stack(children: <Widget>[
          Column(children: <Widget>[
            Container(
              color: Colors.white,
              height: screenH(310),
              width: screenW(600),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: screenH(30),
                  ),
                  Container(
                    height: screenH(250),
                    width: screenW(370),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.35),
                              blurRadius: (20),
                              spreadRadius: (5),
                              offset: Offset(0, 5)),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: profCardId==null?CircularProgressIndicator():
                    Column(

                      children: <Widget>[
                        SizedBox(
                          height: screenH(20),
                        ),
                        Row(
                          children: <Widget>[

                            SizedBox(
                              width: screenW(20),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                name!=null?
                                Text(name,
                                    style: TextStyle(
                                      fontSize: screenF(18),
                                    )):
                                SizedBox(height:screenH(1)),
                                SizedBox(
                                  height: screenH(2),
                                ),
                                university!=null?
                                Text(university,
                                    style: TextStyle(
                                        fontSize: screenF(13),
                                        color: Colors.purple)):
                                SizedBox(height:screenH(1)),
                                SizedBox(
                                  height: screenH(2),
                                ),
                                major!=null?
                                Text(major,
                                    style: TextStyle(
                                        fontSize: screenF(13), color: Colors.grey)):
                                SizedBox(height:screenH(1))
                              ],
                            ),
                            SizedBox(
                              width: screenW(50),
                            ),
                            Column(
                              children: <Widget>[
                                photoUrl!=null?
                                CircleAvatar(
                                  backgroundImage:
                                  NetworkImage(photoUrl),
                                  radius: 21,
                                ):CircularProgressIndicator(),

                                FlatButton(
                                  onPressed: (){
                                    setImage();
                                  },
                                  color: Colors.transparent,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.edit, size: 12, color: Colors.blueAccent[700],),
                                      SizedBox(width: 2,),
                                      Text("Edit", textAlign: TextAlign.left, style: TextStyle(fontSize: 12, color: Colors.blueAccent[700]),),
                                    ],
                                  ),
                                )

                              ],
                            ),

                            // IconButton(
                            //   onPressed: () {},
                            //   color: Colors.black,
                            //   icon: Icon(Icons.create),
                            // )
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenW(30.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              linkedIn!=null?
                              Column(
                                children: <Widget>[
                                  Icon(
                                    FontAwesome.linkedin_square,
                                    color: Color(0xFF0077B5),
                                  ),
                                  SizedBox(
                                    width: screenW(10),
                                  ),
                                  Text(linkedIn,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenF(12))),
                                ],
                              ):SizedBox(
                                height: screenH(1),
                              ),
                              github!=null?
                              Column(
                                children: <Widget>[
                                  Icon(
                                    MaterialCommunityIcons.github_box,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: screenW(10),
                                  ),
                                  Text(github,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenF(12))),
                                ],
                              )
                                  :SizedBox(
                                height: screenH(1),
                              ),
                              twitter!=null?
                              Column(
                                children: <Widget>[
                                  Icon(
                                    MaterialCommunityIcons.twitter_box,
                                    color: Colors.blue,
                                  ),
                                  Text(twitter,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenF(12))),
                                ],
                              ):SizedBox(
                                height: screenH(1),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenH(25),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 20.0),
                            Text(interestString!=null?interestString:"",
                                style: TextStyle(
                                    color: Color(0xFF1976d2), fontSize: screenF(13)))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
                color: Colors.white,
                height: screenH(415),
                child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      Column(children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(

                          height: 20.0,

                          width: screenW(70),

                        ),
                        Row(
                          children: <Widget>[

                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Name',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
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

                                  onSubmitted: (value){
                                    if(value!=''&&value!=null) {
                                      setState(() {
                                        name = value;
                                      });

                                    }
                                  },
                                  decoration: InputDecoration(
                                      border: new UnderlineInputBorder(
                                          borderSide:
                                          new BorderSide(color: Colors.black))),
                                  style: TextStyle(fontSize: 18, color: Colors.grey),
                                  cursorColor: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'University',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 800,
                              height: 70,
                              color: Colors.white,
                              child: FlutterSearchPanel<int>(
                                padding: EdgeInsets.all(10.0),
                                selected: 0,
                                title: 'Select University',
                                data: data2,
                                icon: new Icon(Icons.school, color: Colors.black),
                                color: Color(0xFFECE9E4),
                                textStyle: new TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                                onChanged: (int value){
                                  if(value!=null) {
                                    setState(() {university = data2[value].text;
                                    });

                                  }
                                },


                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.symmetric(horizontal: 20.0),
                        //   child: Column(
                        //     children: <Widget>[
                        //       Theme(
                        //         // data: theme.copyWith(primaryColor: Colors.black),
                        //         data: new ThemeData(
                        //             primaryColor: Colors.black,
                        //             accentColor: Colors.black,
                        //             hintColor: Colors.black),
                        //         child: TextField(
                        //           decoration: InputDecoration(
                        //               border: new UnderlineInputBorder(
                        //                   borderSide:
                        //                       new BorderSide(color: Colors.black))),
                        //           style: TextStyle(fontSize: 18, color: Colors.grey),
                        //           cursorColor: Colors.black,
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Program',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
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
                                  onSubmitted: (value){
                                    if(value!=''&&value!=null) {
                                      setState(() {
                                        major = value;
                                      });

                                    }
                                  },
//
                                  decoration: InputDecoration(
                                      border: new UnderlineInputBorder(
                                          borderSide:
                                          new BorderSide(color: Colors.black))),
                                  style: TextStyle(fontSize: 18, color: Colors.grey),
                                  cursorColor: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Grad Year',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
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
                                   onSubmitted: (value){
                                     if(value!=''&&value!=null) {
                                       setState(() {
                                         major = major+', '+ value;
                                       });

                                     }
                                   },
//
                                  decoration: InputDecoration(
                                      border: new UnderlineInputBorder(
                                          borderSide:
                                          new BorderSide(color: Colors.black))),
                                  style: TextStyle(fontSize: 18, color: Colors.grey),
                                  cursorColor: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'LinkedIn',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
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
                                  onSubmitted: (value){
                                    if(value!=''&&value!=null) {
                                      setState(() {
                                        linkedIn=value;
                                      });

                                    }
                                  },
                                  decoration: InputDecoration(
                                      prefixText: '@',
                                      prefixStyle: TextStyle(color: Colors.grey),
                                      border: new UnderlineInputBorder(
                                          borderSide:
                                          new BorderSide(color: Colors.black))),
                                  style: TextStyle(fontSize: 18, color: Colors.grey),
                                  cursorColor: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Github',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
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
                                  onSubmitted: (value){
                                    if(value!=''&&value!=null) {
                                      setState(() {
                                        github=value;
                                      });

                                    }
                                  },
                                  decoration: InputDecoration(
                                      prefixText: '@',
                                      prefixStyle: TextStyle(color: Colors.grey),
                                      border: new UnderlineInputBorder(
                                          borderSide:
                                          new BorderSide(color: Colors.black))),
                                  style: TextStyle(fontSize: 18, color: Colors.grey),
                                  cursorColor: Colors.black,
                                ),
                              )
                            ],

                          ),
                        ),
                        SizedBox(
                          height: 20.0,

                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Twitter',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
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
                                  onSubmitted: (value){
                                    if(value!=''&&value!=null) {
                                      setState(() {
                                        twitter=value;
                                      });

                                    }
                                  },
                                  decoration: InputDecoration(

                                      prefixText: '@',
                                      prefixStyle: TextStyle(color: Colors.grey),
                                      border: new UnderlineInputBorder(
                                          borderSide:
                                          new BorderSide(color: Colors.black))),
                                  style: TextStyle(fontSize: 18, color: Colors.grey),
                                  cursorColor: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),

                               Row(
                                 children: <Widget>[
                                   SizedBox(
                                     width: screenW(20),
                                   ),
                                   Text(
                              'Interests',
                              style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: screenW(30),
                            ),
                            new OutlineButton(
                              padding: EdgeInsets.all(15),
                              color: Color(0xFF1976d2),
                            child: new Text("Choose 3 professional interest tags", style: TextStyle(color: Color(0xFF1976d2), fontSize: 15),),
                            onPressed: (){
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProfTags()),
                              );
                            },
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                          )


                                 ],
                               ),
                        

                      ]
                      ),
                      SizedBox(
                        height: 50.0,
                      ),

                      Column(
                        children: <Widget>[
                          Container(
                            width: 200,
                            height: 50,
                            child: FloatingActionButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                              elevation: screenH(5),
                              onPressed: () {
                                updateProfCard();
                                setState(() {
                                  saved='Changes saved';
                                });

                              },
                              backgroundColor: Color(0xFFECE9E4),
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    fontSize: screenF(20), color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text(saved,style: TextStyle(
                              fontSize: screenF(20), color: Colors.black)),
                          SizedBox(height: 50,)
                        ],
                      )
                    ]))
          ]),
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
                width: 8,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                color: Colors.black,
                icon: Icon(Icons.arrow_back_ios),
              ),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Color(0xFFECE9E4),
          title: Text(' '),
          bottom: TabBar(
            indicatorColor: Colors.black,
            tabs: <Widget>[
              Tab(
                child: Text(
                  'Social',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              ),
              Tab(
                child: Text(
                  'Professional',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [new SocialCardEdit(),new  ProfessionalCardEdit()],
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