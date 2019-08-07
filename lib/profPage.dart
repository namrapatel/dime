import 'package:Dime/viewCards.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'homePage.dart';
import 'login.dart';
import 'EditCardsScreen.dart';
import 'inviteFriends.dart';
import 'profileScreen.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'createProfPost.dart';
import 'profComments.dart';
import 'models/profPost.dart';



final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;
final _firestore = Firestore.instance;

class ProfPage extends StatefulWidget {
  @override
  _ProfPageState createState() => _ProfPageState();
}

class _ProfPageState extends State<ProfPage> {


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
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0), // here the desired height
          child: AppBar(
            backgroundColor: Color(0xFF1976d2),
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: (){
                     Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRight, child: ScrollPage()));
              },
            ),
            title: Text("University of Waterloo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                  ),
          )
        ),
      backgroundColor: Color(0xFF1976d2),
      floatingActionButton: FloatingActionButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                        onPressed: () {
                     Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: CreateProfPost()));
                        },
                        elevation: 50,
                        heroTag: 'btn1',
                        backgroundColor: Color(0xFF3c3744),
                        child: Icon(
                          Icons.add,
                          // color: Color(0xFF8803fc),
                          color: Colors.white,
                        ),
                      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[

        // SizedBox(
        //   height: MediaQuery.of(context).size.height/70,
        // ),
        
         ProfPost(
           caption: "This is the professional side",
           comments: 76,
           timeStamp: "1 hour ago",
         ),
           ProfPost(
           caption: "I'm Namra and I'm a big faggot.",
           comments: 76,
           timeStamp: "1 hour ago",
           postPic: 'https://firebasestorage.googleapis.com/v0/b/dime-87d60.appspot.com/o/lakersnation.jpeg?alt=media&token=faa5b297-fdf2-470c-a207-19c38e5aa840'
         ),
           ProfPost(
           comments: 76,
           timeStamp: "1 hour ago",
           postPic: 'https://firebasestorage.googleapis.com/v0/b/dime-87d60.appspot.com/o/lakersnation.jpeg?alt=media&token=faa5b297-fdf2-470c-a207-19c38e5aa840'
         ),



        ],
        
      ),

    );
  }
}


