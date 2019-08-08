import 'dart:async';
import 'models/user.dart';
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
import 'package:latlong/latlong.dart' as Lat;
import 'package:rxdart/rxdart.dart';
import 'viewCards.dart';

class ScrollPage extends StatefulWidget {
  ScrollPage({Key key}) : super(key: key);
  @override
  _ScrollPageState createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage>
    with SingleTickerProviderStateMixin {
//  List<UserTile> nearbyUsers = [
//    UserTile(
//      'Shehab Salem',
//      'https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=2289214687839499&height=800&width=800&ext=1566518177&hash=AeTueft3VEa1Wdwq',
//      'BrA8IqEL8RcUYylQz4GHgVD4jBx1',
//      major: 'Computer Science, 2022',
//      interests: ['Flutter', 'Basketball'],
//    ),
//    UserTile(
//        'Dhruv Patel',
//        'https://firebasestorage.googleapis.com/v0/b/dime-87d60.appspot.com/o/defaultprofile.png?alt=media&token=8cd5318b-9593-4837-a9f9-2a22c87463ef',
//        "ocBp1teYqlQkimXXkpSp4Q35C5B3",
//        major: 'Mechatronics Engineering, 2022',
//        interests: ['Java', 'Badminton'])
//  ];
  RubberAnimationController _controller;

  FocusNode _focus = new FocusNode();
  StreamController<List<DocumentSnapshot>> streamController =
      new StreamController();
  Geoflutterfire geo = Geoflutterfire();
  Stream<List<DocumentSnapshot>> stream;

  // Stream<List<DocumentSnapshot>> stream;
  var radius = BehaviorSubject<double>.seeded(1.0);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List<DocumentSnapshot> list = [];
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
  GeoPoint userLoc;

  @override
  void initState() {
    var location = new Location();

    location.onLocationChanged().listen((LocationData currentLocation) async {
      userLoc =
          new GeoPoint(currentLocation.latitude, currentLocation.longitude);

      Firestore.instance
          .collection('users')
          .document(currentUserModel.uid)
          .setData({
        'currentLocation': userLoc,
      }, merge: true);
      DocumentSnapshot userRecord = await Firestore.instance
          .collection('users')
          .document(currentUserModel.uid)
          .get();
      currentUserModel = User.fromDocument(userRecord);
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
        backgroundColor: Color(0xFF48A9A6),
        title: Row(
          children: <Widget>[
            Text(
              "Hey " + currentUserModel.displayName + "!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: ProfilePage()));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: InviteFriends()));
              },
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF48A9A6),
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
          //upperLayer: _getUpperLayer(),
          animationController: _controller,
        ),
      ),
    );
  }

  //map goes here
  Widget _getLowerLayer() {
    return new Stack(
      children: <Widget>[
        ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width / 20,
                  MediaQuery.of(context).size.height / 18,
                  0,
                  0),
              child: Align(
                child: Row(
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
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width / 35,
                  MediaQuery.of(context).size.height / 18,
                  0,
                  0),
              child: Align(
                child: Row(
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
          padding: EdgeInsets.fromLTRB(
              0, MediaQuery.of(context).size.height / 2.5, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
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
                child: Icon(
                  MaterialCommunityIcons.account_tie,
                  color: Color(0xFF1976d2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<List<UserTile>> getUsers() async {
    List<UserTile> userList = [];

    final Lat.Distance distance = new Lat.Distance();
    QuerySnapshot query =
        await Firestore.instance.collection('users').getDocuments();
    final docs = query.documents;
    for (var doc in docs) {
      if (doc.data['currentLocation'] != null) {
        final double distanceInMeters = distance(
            new Lat.LatLng(userLoc.latitude, userLoc.longitude),
            new Lat.LatLng(doc.data['currentLocation'].latitude,
                doc.data['currentLocation'].longitude));
//
        print(doc.data['displayName']);
        print('distance away is');
        print(distanceInMeters);
        if (distanceInMeters <= 6000.0 &&
            doc.documentID != currentUserModel.uid) {
          userList.add(new UserTile(
              doc.data['displayName'], doc.data['photoUrl'], doc.documentID,
              major: doc.data['major'],
              profInterests: doc.data['profInterests'],
              socialInterests: doc.data['socialInterests'],
              university: doc.data['university'],
              gradYear: doc.data['gradYear']));
        }
      }
    }
    return userList;
  }

  Widget _getUpperLayer() {
    return Container(
        color: Colors.white,
        child: FutureBuilder<List<UserTile>>(
            future: getUsers(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Container(
                    alignment: FractionalOffset.center,
                    child: CircularProgressIndicator());

              return Column(children: snapshot.data);
            }));
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
}

class UserTile extends StatelessWidget {
  UserTile(this.contactName, this.personImage, this.uid,
      {this.major,
      this.university,
      this.gradYear,
      this.profInterests,
      this.socialInterests});
  final String contactName, personImage, major, uid, university, gradYear;
  final List<dynamic> profInterests, socialInterests;
  Widget buildProfInterests() {
    String interests = "";
    if (profInterests != null) {
      for (int i = 0; i < profInterests.length; i++) {
        if (i == profInterests.length - 1) {
          interests = interests + profInterests[i];
        } else {
          interests = interests + profInterests[i] + ", ";
        }
      }
      return Row(
        children: <Widget>[
          Text(interests,
              style: TextStyle(color: Color(0xFF1976d2), fontSize: 13))
        ],
      );
    } else {
      return SizedBox(
        height: (1.0),
      );
    }
  }

  Widget buildSocialInterests() {
    String interests = "";
    if (socialInterests != null) {
      for (int i = 0; i < socialInterests.length; i++) {
        if (i == socialInterests.length - 1) {
          interests = interests + socialInterests[i];
        } else {
          interests = interests + socialInterests[i] + ", ";
        }
      }
      return Row(
        children: <Widget>[
          Text(
            interests,
            style: TextStyle(color: Color(0xFF8803fc), fontSize: 13),
          )
        ],
      );
    } else {
      return SizedBox(
        height: (0.0),
      );
    }
  }

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
                child: Text(university != null ? university : ""),
              ),
              major != null && gradYear != null
                  ? Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(major + ", " + gradYear),
                    )
                  : Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(major != null ? major : ""),
                    ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height / 70, 0, 0),
              ),
              Column(
                children: <Widget>[
                  buildSocialInterests(),
                  socialInterests != null
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height / 300,
                        )
                      : SizedBox(
                          height: (0.0),
                        ),
                  buildProfInterests()
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
