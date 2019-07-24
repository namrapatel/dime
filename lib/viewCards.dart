
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/usercard.dart';

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;

class ViewCards extends StatefulWidget {
  const ViewCards({this.userId});
  final String userId;
  @override
  _ViewCardsState createState() => _ViewCardsState(this.userId);
}

class _ViewCardsState extends State<ViewCards> {
final String userId;
_ViewCardsState(this.userId);


Widget buildCards() {
  return FutureBuilder<List<UserCard>>(
      future: getCards(),
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



Future<List<UserCard>> getCards() async {
  List<UserCard> cardTiles = [];
  QuerySnapshot query= await Firestore.instance.collection('users').document(userId).collection('cards').getDocuments();

  for(var document in query.documents) {

   String type= document['type'];
   String photoUrl=document['photoUrl'];
  String major=document['major'];
  String displayName= document['displayName'];
  String university=document['university'];
  String snapchat= document['snapchat'];
  String instagram= document['instagram'];
  String  twitter=document['twitter'];
  String bio=document['bio'];
  String github=document['github'];
  String linkedIn= document['linkedIn'];
    cardTiles.add(UserCard(displayName:displayName,photoUrl:photoUrl,type: type,major:major,
        university: university,snapchat: snapchat,instagram: instagram,twitter: twitter,bio: bio,github: github,linkedIn: linkedIn,));

  }

  return cardTiles;
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
        SizedBox(
        height: 40,
      ),
      Row(
        children: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
          ),
        ],

      ),
       buildCards(),

    ],
        ),
      );
  }
}




