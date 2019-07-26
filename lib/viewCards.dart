

import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/profcard.dart';
import 'models/socialcard.dart';

import 'package:Dime/socialPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sticky_infinite_list/sticky_infinite_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'profAtEvent.dart';
import 'package:circular_splash_transition/circular_splash_transition.dart';
import 'package:page_transition/page_transition.dart';
import 'homePage.dart';
import 'login.dart';


final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;

class ViewCards extends StatefulWidget {

  const ViewCards({this.userId,this.type});
  final String userId,type;

  @override
  _ViewCardsState createState() => _ViewCardsState(this.userId,this.type);
}

class _ViewCardsState extends State<ViewCards> {
final String userId,type;

_ViewCardsState(this.userId,this.type);

Widget buildSocialCard() {
  return FutureBuilder<List<SocialCard>>(
      future: getSocialCard(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Container(
              alignment: FractionalOffset.center,
              child: CircularProgressIndicator());

        return ListView(
          children: snapshot.data,
          padding: EdgeInsets.only(
            bottom: screenH(15.0),
          ),

          shrinkWrap: true,
          scrollDirection: Axis.vertical,
        );
      });
}



Future<List<SocialCard>> getSocialCard() async {

  List<SocialCard> cardTiles = [];

  QuerySnapshot query=await Firestore.instance.collection('users').document(
        userId).collection('socialcard').getDocuments();

  for(var document in query.documents) {


    String photoUrl=document['photoUrl'];
    String major=document['major'];
    String displayName= document['displayName'];
    String university=document['university'];
    String snapchat= document['snapchat'];
    String instagram= document['instagram'];
    String  twitter=document['twitter'];
    String bio=document['bio'];

    cardTiles.add(SocialCard(displayName:displayName,photoUrl:photoUrl,type: type,major:major,
      university: university,snapchat: snapchat,instagram: instagram,twitter: twitter,bio: bio,));
  }
  return cardTiles;
}

Widget buildProfCard() {
  return FutureBuilder<List<ProfCard>>(
      future: getProfCard(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Container(
              alignment: FractionalOffset.center,
              child: CircularProgressIndicator());

        return ListView(
          children: snapshot.data,
          padding: EdgeInsets.only(
            bottom: screenH(15.0),
          ),

          shrinkWrap: true,
          scrollDirection: Axis.vertical,
        );
      });
}



Future<List<ProfCard>> getProfCard() async {

  List<ProfCard> cardTiles = [];

  QuerySnapshot query=await Firestore.instance.collection('users').document(
      userId).collection('profcard').getDocuments();
  if(query.documents.isEmpty){
    Firestore.instance.collection('users').document(
        userId).collection('profcard').add({
      'photoUrl':currentUserModel.photoUrl,
      'displayName':currentUserModel.displayName
    });


  }
    for (var document in query.documents) {
      String photoUrl = document['photoUrl'];
      String major = document['major'];
      String displayName = document['displayName'];
      String university = document['university'];

      String twitter = document['twitter'];
      String bio = document['bio'];
      String github = document['github'];
      String linkedIn = document['linkedIn'];
      cardTiles.add(ProfCard(displayName: displayName,
        photoUrl: photoUrl,
        type: type,
        major: major,
        university: university,
        twitter: twitter,
        bio: bio,
        github: github,
        linkedIn: linkedIn,));

  }
  return cardTiles;
}

Widget buildCards() {
  print(type);
  print(userId);
  if (type == 'social') {
    return
        buildSocialCard();

} else if (type == 'prof') {
    return
        buildProfCard();


  }else{
    return Column(
      children: <Widget>[
        Text('Social Card', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        buildSocialCard(),
        Text("Professional Card", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        buildProfCard()
      ],
    );

  }
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

      backgroundColor: Color(0xFFECE9E4),
        body: Column(
    children: <Widget>[
      //   SizedBox(
      //   height: 40,
      // ),
      // Row(
      //   children: <Widget>[
      //     // IconButton(
      //     //   onPressed: (){
      //     //     Navigator.pop(context);
      //     //   },
      //     //   icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
      //     // ),

      //   ],

      // ),
      buildCards()

    ],
        ),
      );
  }
}





