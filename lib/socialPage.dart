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
import 'createSocialPost.dart';
import 'socialComments.dart';

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;
final _firestore = Firestore.instance;

class SocialPage extends StatefulWidget {
  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {


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
            elevation: 0,
            backgroundColor: Color(0xFF8803fc),
            automaticallyImplyLeading: false,
            title: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20 ,
                  ),
                  Text("University of Waterloo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                  ),
 
                ],
              ),
              Spacer(),
              Column(
                children: <Widget>[
                     SizedBox(
                    height: 8,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20,),
                    onPressed: (){
                         Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft, child: ScrollPage()));
                    },
                  ),
                ],
              ),

            ],
          ),
          )
        ),
      backgroundColor: Color(0xFF8803fc),
      floatingActionButton: FloatingActionButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                        onPressed: () {
                     Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: CreateSocialPost()));
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
        
          Container(
          margin:EdgeInsets.all(8.0),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  title: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting."),
                  subtitle: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(FontAwesome.comments, color: Colors.black,),
                        onPressed: (){
                       Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: SocialComments()));

                        },
                      ),
                      Text("310 comments"),
                      Spacer(),
                      Text("2 hours ago")
                    ],
                  )
                ),
              ],
            )
          )
      ),
                Container(
          margin:EdgeInsets.all(8.0),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),

                  child: Image(
                    image: AssetImage('assets/img/trip.png'),
                    width: 200,
                    height: 250,
                    fit: BoxFit.fill,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  title: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting."),
                  subtitle: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(FontAwesome.comments, color: Colors.black,),
                        onPressed: (){},
                      ),
                      Text("310 comments"),
                      Spacer(),
                      Text("2 hours ago")
                    ],
                  )
                ),
              ],
            )
          )
      ),

                Container(
          margin:EdgeInsets.all(8.0),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),

                  child: Image(
                    image: AssetImage('assets/img/family.png'),
                    width: 200,
                    height: 250,
                    fit: BoxFit.fill,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  subtitle: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(FontAwesome.comments, color: Colors.black,),
                        onPressed: (){},
                      ),
                      Text("310 comments"),
                      Spacer(),
                      Text("2 hours ago")
                    ],
                  )
                ),
              ],
            )
          )
      )



        ],
        
      ),

    );
  }
}


