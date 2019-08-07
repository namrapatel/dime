import 'dart:async';
import 'dart:convert';

import 'package:Dime/profPage.dart';
import 'package:Dime/profileScreen.dart';
import 'package:Dime/socialPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'login.dart';
import 'chatList.dart';
import 'chat.dart';
import 'inviteFriends.dart';
import 'explore.dart';
import 'userCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:rxdart/rxdart.dart';
import 'viewCards.dart';


class ScrollPage extends StatefulWidget {
  ScrollPage({Key key}) : super(key: key);
  @override
  _ScrollPageState createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage>
    with SingleTickerProviderStateMixin {

  List<UserTile> nearbyUsers = [
    UserTile(
      'Shehab Salem',
      'https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=2289214687839499&height=800&width=800&ext=1566518177&hash=AeTueft3VEa1Wdwq',
      'BrA8IqEL8RcUYylQz4GHgVD4jBx1',
      major: 'Computer Science, 2022',
      interests: ['Flutter', 'Basketball'],
    ),
    UserTile(
        'Dhruv Patel',
        'https://firebasestorage.googleapis.com/v0/b/dime-87d60.appspot.com/o/defaultprofile.png?alt=media&token=8cd5318b-9593-4837-a9f9-2a22c87463ef',
        "ocBp1teYqlQkimXXkpSp4Q35C5B3",
        major: 'Mechatronics Engineering, 2022',
        interests: ['Java', 'Badminton'])
  ];
  RubberAnimationController _controller;



  FocusNode _focus = new FocusNode();
  StreamController<List<DocumentSnapshot>> streamController = new StreamController();
  Geoflutterfire geo =Geoflutterfire();
  Stream<List<DocumentSnapshot>> stream;

  // Stream<List<DocumentSnapshot>> stream;
  var radius = BehaviorSubject<double>.seeded(1.0);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List<DocumentSnapshot> list=[];
  // getPermission() async {
  //   final GeolocationResult result =
  //       await Geolocation.requestLocationPermission(const LocationPermission(
  //           android: LocationPermissionAndroid.fine,
  //           ios: LocationPermissionIOS.always));
  //   return result;
  // }

  getPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler()
        .requestPermissions([PermissionGroup.locationAlways]);
  }

  final screenH = ScreenUtil.instance.setHeight;
  final screenW = ScreenUtil.instance.setWidth;
  final screenF = ScreenUtil.instance.setSp;

  // getPermission() async {
  //   final GeolocationResult result =
  //       await Geolocation.requestLocationPermission(const LocationPermission(
  //           android: LocationPermissionAndroid.fine,
  //           ios: LocationPermissionIOS.always));
  //   return result;
  // }

  ScrollController _scrollController = ScrollController();

  final Map<String, Marker> _markers = {};

  var rad = BehaviorSubject<double>.seeded(6.0);
  @override
  void initState() {

    var location = new Location();



    location.onLocationChanged().listen((LocationData currentLocation) async {


      GeoFirePoint userLoc = geo.point(latitude: currentLocation.latitude, longitude: currentLocation.longitude);

      Firestore.instance
          .collection('users')
          .document(currentUserModel.uid)
          .setData({
        'position': userLoc.data,
      }, merge: true);

//            DocumentSnapshot mine =await Firestore.instance.collection('users').document(currentUserModel.uid).get();
//            GeoFirePoint gp=mine.data['position'];
//
//            double radius = 6.0;
      String field = 'position';
      stream = radius.switchMap((rad) {
        var collectionReference = Firestore.instance.collection('users');
        return geo.collection(collectionRef: collectionReference).within(
            center: userLoc, radius: rad, field: 'position', strictMode: true);
      });

      changed(_value);
//              var collectionReference = Firestore.instance.collection('users');
//              stream= geo.collection(collectionRef: collectionReference).within(
//                  center: userLoc, radius: rad, field: 'position', strictMode: true);

//            DocumentSnapshot mine =await Firestore.instance.collection('users').document(currentUserModel.uid).get();
//            list.add(mine);

//             stream = geo.collection(collectionRef: collectionReference)
//                .within(center: userLoc, radius: radius, field: field,strictMode: true);


//     stream.listen((List<DocumentSnapshot> documentList){
//          print(documentList.length);
//          for(var doc in documentList){
//           GeoPoint point=doc.data['position']['geopoint'];
//           print(point.latitude);
//           print(point.longitude);
//           String name =doc.data['displayName'];
//           print(name);
//          }
//
//
//
//        });









    });

    _controller = RubberAnimationController(
        vsync: this,
        upperBoundValue: AnimationControllerValue(percentage: 0.95),
        initialValue: 0.40,
        lowerBoundValue: AnimationControllerValue(percentage: 0.40),
        duration: Duration(milliseconds: 200));
    super.initState();


    getPermission();
  }


  @override
  void dispose() {
    streamController.close(); //Streams must be closed when not needed
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF0078FF), 
        title: Row(
            children: <Widget>[
              Text("Hey " + currentUserModel.displayName + "!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
              ),
              Spacer(),

              IconButton(
                icon: Icon(Icons.settings, color: Colors.white, size: 20,),
                onPressed: (){
                     Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: ProfilePage()));
                },
              ),
              IconButton(
                icon: Icon(Icons.add, color: Colors.white, size: 25,),
                onPressed: (){
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: InviteFriends()));
                },
              ),

            ],
          ),
      ),
      
      backgroundColor: Color(0xFF0078FF),
      body: Container(
        child: RubberBottomSheet(
          scrollController: _scrollController,
          lowerLayer: _getLowerLayer(),
          header: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                )),
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height / 122),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 7.5,
                  height: MediaQuery.of(context).size.height / 110,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.width / 32.5, 0, 0),
                ),

                Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height / 52, 0, 0)),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width / 4.2, 0, 0, 0),
                    ),
                    Icon(Icons.people, color: Colors.black),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width / 52,
                          MediaQuery.of(context).size.height / 52,
                          0,
                          0),
                    ),
                    Text(
                      "People around you",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width / 52, 0, 0, 0),
                    ),

                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.height / 109, 0, 0),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(75, 8, 75, 0),

                ),
              ],
            ),
          ),
          headerHeight: MediaQuery.of(context).size.height / 8,
          upperLayer: _getUpperLayer(),
          animationController: _controller,
        ),
      ),
    );
  }

  Widget _getLowerLayer() {
    return new Stack(
      children: <Widget>[
            ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: <Widget>[
                      Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 20,
                MediaQuery.of(context).size.height / 18, 0, 0),
            child: Align(
              child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: ViewCards(
                          userId: currentUserModel.uid,
                          type: 'social',
                        )),
                      ],
                    ),

              alignment: Alignment.topCenter,
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 35,
                MediaQuery.of(context).size.height / 18, 0, 0),
            child: Align(
              child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: ViewCards(
                          userId: currentUserModel.uid,
                          type: 'prof',
                        )),
                      ],
                    ),

              alignment: Alignment.topCenter,
            ),
          ),

            ],
          ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height/2.5, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FloatingActionButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.leftToRight,
                                  child: SocialPage()));
                        },
                        elevation: 3,
                        heroTag: 'btn1',
                        backgroundColor: Colors.white,
                        child: Icon(
                          Entypo.drink,
                          color: Color(0xFF8803fc),
                        ),
                      ),


                      FloatingActionButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                        onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: ChatList()));
                        },
                        elevation: 3,
                        heroTag: 'btn2',
                        backgroundColor: Colors.white,
                        child: Icon(
                          MaterialCommunityIcons.chat,
                          color: Colors.black,
                        ),
                      ),

                      FloatingActionButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                        onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Explore()));
                        },
                        elevation: 3,
                        heroTag: 'btn3',
                        backgroundColor: Colors.white,
                        child: Icon(
                          Ionicons.md_search,
                          color: Colors.black,
                        ),
                      ),



                      FloatingActionButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: ProfPage()));
                        },
                        elevation: 3,
                        heroTag: 'btn4',
                        backgroundColor: Colors.white,
                        child: Icon(MaterialCommunityIcons.account_tie,
                            color: Color(0xFF1976d2),),
                      ),
                    ],
                  ),
                ),
        

        
      ],
    );
  }



  Widget _getUpperLayer() {
    return   Container(
      color: Colors.white,
      child: StreamBuilder(

        stream: stream,
        builder: ( context,
            AsyncSnapshot<List<DocumentSnapshot>> snapshots) {
          if (
          snapshots.hasData) {
            print('data ${snapshots.data}');
            return  ListView.builder(


              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshots.data[index];
                print(
                    'doc with id ${doc.documentID} distance ${doc.data['distance']}');
                GeoPoint point = doc.data['position']['geopoint'];
                return UserTile(doc.data['displayName'],doc.data['photoUrl'],doc.documentID,major: 'dumbness',interests: ['idiots'],);
              },
              itemCount: snapshots.data.length,
            );

          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
  double _value = 5.0;
  String _label = '';

  changed(value) {
    setState(() {
      _value = value;
      print(_value);
      _label = '${_value.toInt().toString()} kms';
    });
    radius.add(value);
  }




//    return  StreamBuilder<List<DocumentSnapshot>>(
//    stream:stream,
//    builder: (context,  snapshot) {
//    if (snapshot.hasData ) {
//      var docs = snapshot.data;
//      print(docs.runtimeType);
//      List<UserTile> nearbyUsers = [];
//      for (var snap in docs) {
//        print('inside');
//        print(snap.runtimeType);
//        String userId = snap.documentID;
//        String userName = snap.data['displayName'];
//        String photoUrl = snap.data['photoUrl'];
//        String major = snap.data['major'];
//        List<String> interests = snap.data['interests'];
//        nearbyUsers.add(new UserTile(userName, photoUrl, userId,));
//      }
//
//
//      return Container(
//        height: screenH(165),
//        child: ListView.builder(
//            padding: EdgeInsets.only(
//              bottom: screenH(15.0),
//            ),
//            shrinkWrap: true,
//            scrollDirection: Axis.vertical,
//            itemCount: nearbyUsers.length,
//            itemBuilder: (BuildContext context, int index) {
//              return nearbyUsers[index];
//            }),
//      );
//    }return CircularProgressIndicator();
//    }
//    );}


}

class UserTile extends StatelessWidget {
  UserTile(this.contactName, this.personImage, this.uid,
      {this.major, this.interests});
  final String contactName, personImage, major, uid;
  final List<String> interests;

  List<Widget> buildInterests(List interestsList, context) {
    List<Widget> interestWidgets = [];

    for (var interest in interestsList) {
      interestWidgets.add(Column(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 30,
          width: MediaQuery.of(context).size.width / 6,
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 40,
              MediaQuery.of(context).size.height / 150, 0, 0),
          child: Text(interest,
              style: TextStyle(color: Colors.white, fontSize: 10)),
          decoration: BoxDecoration(
              color: Color(0xFF8803fc),
              borderRadius: BorderRadius.circular(20)),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
        ),
      ]));
    }
    return interestWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            contactName,
            style: TextStyle(fontSize: 18),
          ),
          subtitle: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height / 100, 0, 0),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(major),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height / 70, 0, 0),
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Philosophy, Flutter, Basketball",
                        style: TextStyle(
                            color: Color(0xFF8803fc), fontSize: 13),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/300,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Startups, Painting, Tech Companies",
                          style: TextStyle(
                              color: Color(0xFF1976d2), fontSize: 13)
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0,
                    MediaQuery.of(context).size.height / 50,
                    MediaQuery.of(context).size.height / 50,
                    0),
              )
            ],
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(personImage),
            radius: 20,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(MaterialCommunityIcons.chat),
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: Chat(
                            fromUserId: currentUserModel.uid,
                            toUserId: uid,
                          )));
                },
              ),
              IconButton(
                icon: Icon(MaterialCommunityIcons.card_bulleted),
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: UserCard(
                            userId: uid,
                          )));
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}