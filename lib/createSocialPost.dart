import 'package:Dime/viewCards.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'homePage.dart';
import 'login.dart';
import 'socialAtEvent.dart';
import 'EditCardsScreen.dart';
import 'inviteFriends.dart';
import 'profileScreen.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;
final _firestore = Firestore.instance;

class CreateSocialPost extends StatefulWidget {
  @override
  _CreateSocialPostState createState() => _CreateSocialPostState();
}

class _CreateSocialPostState extends State<CreateSocialPost> {


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
      backgroundColor: Colors.grey[200],
      body: ListView(
children: <Widget>[
Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 50, 0, 0),
                child: Text("Cancel",
                style: TextStyle(color: Color(0xFF8803fc),
                fontSize: 16
                ),
                ),
              ),
              onTap: (){
                Navigator.pop(context);
              },
        ),
        Spacer(),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                  child: FloatingActionButton.extended(
                    backgroundColor: Color(0xFF8803fc),
                  onPressed: () {},
                  icon: Icon(Ionicons.ios_send),
                  label: Text("Post"),
                ),
                ),
            ],
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: Text("This post will be anonymous, however comments on the post are not.",
            textAlign: TextAlign.center,
            ),
          ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: <Widget>[
                            FloatingActionButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                              onPressed: () {
                              },
                              elevation: 3,
                              heroTag: 'imgbtn',
                              backgroundColor: Colors.white,
                              child: Icon(
                                SimpleLineIcons.picture ,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
          //   Card(
          //     color: Colors.grey[200],
          //     elevation: 0,
          //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.stretch,
          //       children: <Widget>[
          //         Row(
          //           children: <Widget>[
          //             IconButton(
          //               icon: Icon(Icons.close),
          //               onPressed: (){},
          //               color: Colors.black,
          //             )
          //           ],
          //         ),
          //         ClipRRect(
          //           borderRadius: BorderRadius.all(Radius.circular(15.0),),

          //           child: Image(
          //             image: AssetImage('assets/img/trip.png'),
          //             width: 200,
          //             height: 250,
          //             fit: BoxFit.fill,
          //           ),
          //         ),
          //       ],
          //     )
          // ),
           Padding(
             padding: const EdgeInsets.all(15.0),
             child: TextField(
                 keyboardType: TextInputType.multiline,
                 maxLines: 2,
               decoration: InputDecoration(
                 border: InputBorder.none,
                 hintText: "What's going on?"
               ),
          autofocus: true,
        ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               children: <Widget>[
                 Text("Max. 140 characters",
                 style: TextStyle(color: Colors.grey),
                 ),
               ],
             ),
           )
           
        ],
      ),
],
      )
    );
  }
}


