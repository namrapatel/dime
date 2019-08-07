import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/profcard.dart';
import 'models/socialcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login.dart';

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;
String socialCardId;
String profCardId;
class ViewCards extends StatefulWidget {
  const ViewCards({this.userId, this.type});
  final String userId, type;

  @override
  _ViewCardsState createState() => _ViewCardsState(this.userId, this.type);
}

class _ViewCardsState extends State<ViewCards> {
  final String userId, type;

  _ViewCardsState(this.userId, this.type);

  Widget buildSocialCard() {
    return FutureBuilder<List<SocialCard>>(
        future: getSocialCard(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
                alignment: FractionalOffset.center,
                child: CircularProgressIndicator());

          return Row(children: snapshot.data);
        });
  }

  Future<List<SocialCard>> getSocialCard() async {
    List<SocialCard> cardTiles = [];

    QuerySnapshot query = await Firestore.instance
        .collection('users')
        .document(userId)
        .collection('socialcard')
        .getDocuments();

    for (var document in query.documents) {
socialCardId= document.documentID;

      cardTiles.add(SocialCard.fromDocument(document)
        );
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

          return Row(children: snapshot.data);
        });
  }

  Future<List<ProfCard>> getProfCard() async {
    List<ProfCard> cardTiles = [];

    QuerySnapshot query = await Firestore.instance
        .collection('users')
        .document(userId)
        .collection('profcard')
        .getDocuments();
    if (query.documents.isEmpty) {
      Firestore.instance
          .collection('users')
          .document(userId)
          .collection('profcard')
          .add({
        'photoUrl': currentUserModel.photoUrl,
        'displayName': currentUserModel.displayName
      });
    }
    for (var document in query.documents) {
profCardId=document.documentID;
      cardTiles.add(ProfCard.fromDocument(document)

      );
    }
    return cardTiles;
  }

  Widget buildCards() {
    print(type);
    print(userId);
    if (type == 'social') {
      return buildSocialCard();
    } else if (type == 'prof') {
      return buildProfCard();
    } else {
      return Column(
        children: <Widget>[
          Text(
            'Social Card',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: screenH(20),
          ),
          buildSocialCard(),
          SizedBox(
            height: screenH(40),
          ),
          Text(
            "Professional Card",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: screenH(20),
          ),
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
    return buildCards();
    // return Scaffold(

    //   backgroundColor: Color(0xFFECE9E4),
    //   body: buildCards(),
    // //     body: Column(
    // // children: <Widget>[
    // //   //   SizedBox(
    // //   //   height: 40,
    // //   // ),
    // //   // Row(
    // //   //   children: <Widget>[
    // //   //     // IconButton(
    // //   //     //   onPressed: (){
    // //   //     //     Navigator.pop(context);
    // //   //     //   },
    // //   //     //   icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
    // //   //     // ),

    // //   //   ],

    // //   // ),
    // //   buildCards()

    // // ],
    // //     ),
    //   );
  }
}
