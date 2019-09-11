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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'login.dart';
import 'chatList.dart';
import 'chat.dart';
import 'explore.dart';
import 'userCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart' as Lat;
import 'package:rxdart/rxdart.dart';
import 'viewCards.dart';
import 'package:geolocator/geolocator.dart' as geoLoc;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flushbar/flushbar.dart';
import 'package:Dime/models/localnotif.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'profComments.dart';
import 'socialComments.dart';

String currentToken = "";
final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;

class ScrollPage extends StatefulWidget {
  ScrollPage({Key key}) : super(key: key);
  @override
  _ScrollPageState createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage>
    with SingleTickerProviderStateMixin {
  RubberAnimationController _controller;
  int unread = 0;
  FocusNode _focus = new FocusNode();
  StreamController<List<DocumentSnapshot>> streamController =
      new StreamController();
  Geoflutterfire geo = Geoflutterfire();
  Stream<List<DocumentSnapshot>> stream;

  // Stream<List<DocumentSnapshot>> stream;
  var radius = BehaviorSubject<double>.seeded(6.0);

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

  getUnreadMessages() async {
    QuerySnapshot query = await Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .collection('messages')
        .where('unread', isEqualTo: true)
        .getDocuments();
    setState(() {
      unread = query.documents.length;
    });
  }

  // getPermission() async {
  //   final GeolocationResult result =
  //       await Geolocation.requestLocationPermission(const LocationPermission(
  //           android: LocationPermissionAndroid.fine,
  //           ios: LocationPermissionIOS.always));
  //   return result;
  // }

  ScrollController _scrollController = ScrollController();

  GeoPoint userLoc;

  LocationData position;
  GeoPoint current;
  getLocation() async {
    var location = new Location();
    LocationData currentLocation = await location.getLocation();
    DocumentSnapshot distance = await Firestore.instance
        .collection('distance')
        .document('distance')
        .get();
    int firebaseRadius = distance['radius'];
    bool strictmode = distance['strictmode'];
    double radius = firebaseRadius.toDouble();
    print('radius is');
    print(radius);
//    location.onLocationChanged().listen((LocationData currentLocation) async {

    current = new GeoPoint(currentLocation.latitude, currentLocation.longitude);

//    geoLoc.Position idiot = await geoLoc.Geolocator().getCurrentPosition(desiredAccuracy: geoLoc.LocationAccuracy.high);

    setState(() {
      position = currentLocation;
    });
    GeoFirePoint userLoc =
        geo.point(latitude: position.latitude, longitude: position.longitude);
    print(position.latitude);
    print(position.longitude);
//    double distanceInMeters = await geoLoc.Geolocator().distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
//    print('distance is');
//    print(distanceInMeters);
//    current =
//    new GeoPoint(position.latitude, position.longitude);
    Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .setData({
      'position': userLoc.data,
    }, merge: true);

//    DocumentSnapshot userRecord = await Firestore.instance
//        .collection('users')
//        .document(currentUserModel.uid)
//        .get();
//    currentUserModel = User.fromDocument(userRecord);
//    });
//
    stream = geo
        .collection(collectionRef: Firestore.instance.collection('users'))
        .within(
            center: userLoc,
            radius: radius,
            field: 'position',
            strictMode: strictmode);
//    stream = radius.switchMap((rad) {
//      var collectionReference = Firestore.instance.collection('users');
//      return geo.collection(collectionRef: collectionReference).within(
//          center: userLoc, radius: rad, field: 'position', strictMode: true);
//    });

//    changed(_value);
//    print(distanceInMeters);
  }

  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  _saveDeviceToken() async {
    String uid = currentUserModel.uid;

    String fcmToken = await _fcm.getToken();
    print(fcmToken);
    if (fcmToken != null) {
      currentToken = fcmToken;
      await _db.collection('users').document(uid).get().then((document) {
        if (document['tokens'] == null) {
          List<String> newTokenList = [fcmToken];
          _db
              .collection('users')
              .document(uid)
              .updateData({'tokens': newTokenList});
        } else {
          var initTokens = document.data['tokens'];
          var tokenList = new List<String>.from(initTokens);
          if (!tokenList.contains(fcmToken)) {
            tokenList.add(fcmToken);
            _db
                .collection('users')
                .document(uid)
                .updateData({'tokens': tokenList});
          }
        }
      });
    }
  }

  @override
  void initState() {
    getUnreadMessages();
    getLocation();
    firebaseCloudMessaging_Listeners();
    _controller = RubberAnimationController(
        vsync: this,
        upperBoundValue: AnimationControllerValue(percentage: 0.95),
        initialValue: 0.40,
        lowerBoundValue: AnimationControllerValue(percentage: 0.40),
        duration: Duration(milliseconds: 200));
    super.initState();

    getPermission();
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print(token);
      _saveDeviceToken();
    });

    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        if (message['notifType'] == "chat") {
          LocalNotifcation(context, message['aps']['alert']['title'],
              message['aps']['alert']['body'], "chat", message);
        } else if (message['notifType'] == "postNotif") {
          if (message['type'] == "prof") {
            LocalNotifcation(context, message['aps']['alert']['title'],
                message['aps']['alert']['body'], "postNotifProf", message);
          } else {
            LocalNotifcation(context, message['aps']['alert']['title'],
                message['aps']['alert']['body'], "postNotifSocial", message);
          }
        } else if (message['notifType'] == "streamNotif" &&
            message['ownerId'] != currentUserModel.uid) {
          LocalNotifcation(context, message['aps']['alert']['title'],
              message['aps']['alert']['body'], "streamNotif", message);
        }
      } else {
        if (message['data']['notifType'] == "chat") {
          LocalNotifcation(context, message['notification']['title'],
              message['notification']['body'], "chat", message);
        } else if (message['data']['notifType'] == "postNotif") {
          if (message['data']['type'] == "prof") {
            LocalNotifcation(context, message['notification']['title'],
                message['notification']['body'], "postNotifProf", message);
          } else {
            LocalNotifcation(context, message['notification']['title'],
                message['notification']['body'], "postNotifSocial", message);
          }
        } else if (message['data']['notifType'] == 'streamNotif' &&
            message['data']['ownerId'] != currentUserModel.uid) {
          LocalNotifcation(context, message['notification']['title'],
              message['notification']['body'], "streamNotif", message);
        }
      }
    }, onResume: (Map<String, dynamic> message) async {
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        if (message['notifType'] == "chat") {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => Chat(
                        fromUserId: currentUserModel.uid,
                        toUserId: message['senderId'],
                      )));
        } else if (message['notifType'] == "postNotif") {
          if (message['type'] == "prof") {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => ProfComments(
                          postId: message['postId'],
                        )));
          } else {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => SocialComments(
                          postId: message['postId'],
                        )));
          }
        } else if (message['notifType'] == "streamNotif") {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => ProfPage(stream: message['title'])));
        }
      } else {
        if (message['data']['notifType'] == "chat") {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => Chat(
                        fromUserId: currentUserModel.uid,
                        toUserId: message['data']['senderId'],
                      )));
        } else if (message['data']['notifType'] == "postNotif") {
          if (message['data']['type'] == "prof") {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => ProfComments(
                          postId: message['data']['postId'],
                        )));
          } else {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => SocialComments(
                          postId: message['data']['postId'],
                        )));
          }
        } else if (message['data']['notifType'] == "streamNotif") {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) =>
                      ProfPage(stream: message['data']['title'])));
        }
      }
    }, onLaunch: (Map<String, dynamic> message) async {
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        if (message['notifType'] == "chat") {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => Chat(
                        fromUserId: currentUserModel.uid,
                        toUserId: message['senderId'],
                      )));
        } else if (message['notifType'] == "postNotif") {
          if (message['type'] == "prof") {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => ProfComments(
                          postId: message['postId'],
                        )));
          } else {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => SocialComments(
                          postId: message['postId'],
                        )));
          }
        } else if (message['notifType'] == "streamNotif") {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => ProfPage(stream: message['title'])));
        }
      } else {
        if (message['data']['notifType'] == "chat") {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => Chat(
                        fromUserId: currentUserModel.uid,
                        toUserId: message['data']['senderId'],
                      )));
        } else if (message['data']['notifType'] == "postNotif") {
          if (message['data']['type'] == "prof") {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => ProfComments(
                          postId: message['data']['postId'],
                        )));
          } else {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => SocialComments(
                          postId: message['data']['postId'],
                        )));
          }
        } else if (message['data']['notifType'] == "streamNotif") {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) =>
                      ProfPage(stream: message['data']['title'])));
        }
      }
    });
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  @override
  Widget build(BuildContext context) {
    var string = currentUserModel.displayName.split(" ");
    String firstName = string[0];
    if (firstName == null) {
      firstName = "";
    }

    return WillPopScope(
      onWillPop: () {
        print('Hello');
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF1458EA),
          title: Row(
            children: <Widget>[
              // RaisedButton(
              //   child: Text("Local Notif UI"),
              //   onPressed: (){

              //   Flushbar(
              //     margin: EdgeInsets.all(8),
              //     borderRadius: 15,
              //     messageText: Padding(
              //       padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Text("New message from Dhruv Patel",
              //           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              //           ),
              //           Text("Hey, how's it going? I'm a big baller",
              //           style: TextStyle(color: Colors.grey),
              //           )
              //         ],
              //       ),
              //     ),
              //     backgroundColor: Colors.white,
              //      flushbarPosition: FlushbarPosition.TOP,
              //               icon: Padding(
              //                 padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
              //                 child: Icon(
              //                   Icons.info_outline,
              //                   size: 28.0,
              //                   color: Color(0xFF1458EA),
              //                   ),
              //               ),
              //               duration: Duration(seconds: 3),
              //             )..show(context);
              //   }
              // ),
              firstName != "No"
                  ? Container(
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: currentUserModel.displayName == null
                          ? AutoSizeText(
                              "Hey!",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              minFontSize: 12,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : AutoSizeText(
                              "Hey " + firstName + "!",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              minFontSize: 12,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                    )
                  : Row(
                      children: <Widget>[
                        AutoSizeText(
                          "Hey!",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          minFontSize: 12,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 20,
                        ),
                        FlatButton(
                          color: Colors.white,
                          child: Text(
                            "Set up Profile",
                            style: TextStyle(color: Color(0xFF1458EA)),
                          ),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => ProfilePage()));
                          },
                        ),
                      ],
                    ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Feather.settings,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => ProfilePage()));
                },
              ),
              IconButton(
                icon: Icon(Feather.user),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => UserCard(
                                userId: currentUserModel.uid,
                                userName: currentUserModel.displayName,
                              )));
                },
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xFF1458EA),
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
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height / 122),
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
            headerHeight: MediaQuery.of(context).size.height / 6.5,
            upperLayer: _getUpperLayer(),
            animationController: _controller,
          ),
        ),
      ),
    );
  }

  //map goes here
  Widget _getLowerLayer() {
    return new Stack(
      children: <Widget>[
        ListView(
          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
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
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => SocialPage()));
                },
                elevation: 3,
                heroTag: 'btn1',
                backgroundColor: Colors.white,
                child: Icon(
                  Entypo.drink,
                  color: Color(0xFF8803fc),
                ),
              ),
              Stack(
                children: <Widget>[
                  FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    onPressed: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => ChatList()));
                    },
                    elevation: 3,
                    heroTag: 'btn2',
                    backgroundColor: Colors.white,
                    child: Icon(
                      Feather.message_circle,
                      color: Colors.black,
                      size: 25.0,
                    ),
                  ),
                  unread > 0
                      ? Positioned(
                          top: MediaQuery.of(context).size.height / 70,
                          left: MediaQuery.of(context).size.width / 13,
                          child: CircleAvatar(
                            child: Text(
                              unread.toString(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            ),
                            backgroundColor: Colors.red,
                            radius: 8.2,
                          ))
                      : SizedBox(
                          height: 0.0,
                        )
                ],
              ),
              FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => Explore()));
                },
                elevation: 3,
                heroTag: 'btn3',
                backgroundColor: Colors.white,
                child: Icon(
                  Ionicons.md_search,
                  color: Colors.black,
                  size: 27.5,
                ),
              ),
              FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => ProfPage(
                                stream: 'Subscriptions',
                              )));
                },
                elevation: 3,
                heroTag: 'btn4',
                backgroundColor: Colors.white,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 30,
                    ),
                    Icon(
                      FontAwesome.graduation_cap,
                      color: Color(0xFF096664),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

//  Future<List<UserTile>> getUsers() async {
//    List<UserTile> userList = [];
//
//    final Lat.Distance distance = new Lat.Distance();
//    QuerySnapshot query =
//    await Firestore.instance.collection('users').getDocuments();
//    final docs = query.documents;
//    for (var doc in docs) {
//      if (doc.data['currentLocation'] != null) {
//
////
////        geoLat.LatLng point2=  geoLat.LatLng(doc.data['currentLocation'].latitude,
////            doc.data['currentLocation'].longitude);
//
//        double distanceInMeters = await geoLoc.Geolocator().distanceBetween(position. latitude, position.longitude, doc.data['currentLocation'].latitude,  doc.data['currentLocation'].longitude);
////        final double distanceInMeters =geoLat.computeDistanceHaversine(userLoc,point2);
//
//        print(doc.documentID);
//        print('distance away is');
//        print(distanceInMeters);
//        if (distanceInMeters <= 6000.0 &&
//            doc.documentID != currentUserModel.uid) {
//          userList.add(new UserTile(
//              doc.data['displayName'], doc.data['photoUrl'], doc.documentID,
//              major: doc.data['major'],
//              profInterests: doc.data['profInterests'],
//              socialInterests: doc.data['socialInterests'],
//              university: doc.data['university'],
//              gradYear: doc.data['gradYear']));
//        }
//      }
//    }
//    return userList;
//  }

  Widget _getUpperLayer() {
    return Container(
        color: Colors.white,
        child: ListView(children: <Widget>[
          StreamBuilder(
            stream: stream,
            builder:
                (context, AsyncSnapshot<List<DocumentSnapshot>> snapshots) {
              if (!snapshots.hasData) {
                return Container(
                    alignment: FractionalOffset.center,
                    child: CircularProgressIndicator());
              } else {
                if (snapshots.data.length != 0) {
                  snapshots.data.removeWhere((DocumentSnapshot doc) =>
                      doc.documentID == currentUserModel.uid);
                }

                return Container(
                    child: Container(
                  child: (snapshots.data.length == 0)
                      ? Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20.0,
                            ),
                            Image.asset(
                                'assets/img/undraw_peoplearoundyou.png'),
                            Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.height / 20),
                              child: Text(
                                "There's nobody around. \n Go get a walk in and find some new people!",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 2 / 3,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              DocumentSnapshot doc = snapshots.data[index];
                              print(
                                  'doc with id ${doc.documentID} distance ${doc.data['distance']}');
                              GeoPoint point = doc.data['position']['geopoint'];
                              if (doc.data['blocked${currentUserModel.uid}'] ==
                                  true) {
                                return UserTile(blocked: true);
                              } else {
                                return UserTile(
                                    contactName: doc.data['displayName'],
                                    personImage: doc.data['photoUrl'],
                                    uid: doc.documentID,
                                    major: doc.data['major'],
                                    profInterests: doc.data['profInterests'],
                                    socialInterests:
                                        doc.data['socialInterests'],
                                    university: doc.data['university'],
                                    gradYear: doc.data['gradYear'],
                                    bio: doc.data['bio']);
                              }
                            },
                            itemCount: snapshots.data.length,
                          ),
                        ),
                ));
//              else {
//                snapshots.data.removeWhere((DocumentSnapshot doc) =>
//                doc.documentID == currentUserModel.uid);
//                print('data ${snapshots.data}');
//                return Container(
//                  height: MediaQuery
//                      .of(context)
//                      .size
//                      .height * 2 / 3,
//                  child: ListView.builder(
//                    itemBuilder: (context, index) {
//                      DocumentSnapshot doc = snapshots.data[index];
//                      print(
//                          'doc with id ${doc.documentID} distance ${doc
//                              .data['distance']}');
//                      GeoPoint point = doc.data['position']['geopoint'];
//
//                      return UserTile(
//                          doc.data['displayName'], doc.data['photoUrl'],
//                          doc.documentID,
//                          major: doc.data['major'],
//                          profInterests: doc.data['profInterests'],
//                          socialInterests: doc.data['socialInterests'],
//                          university: doc.data['university'],
//                          gradYear: doc.data['gradYear']);
//                    },
//                    itemCount: snapshots.data.length,
//                  ),
//                );
//              }
////            else {
////              return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ]));
  }

//  Widget _getUpperLayer() {
//    return Container(
//        color: Colors.white,
//        child: ListView(
//          children: <Widget>[
//
//            FutureBuilder<List<UserTile>>(
//            future: getUsers(),
//            builder: (context, snapshot) {
//              if (!snapshot.hasData)
//                return Container(
//                    alignment: FractionalOffset.center,
//                    child: CircularProgressIndicator());
//
//              return Container(
//                child:
//                snapshot.data.length == 0?
//                Column(
//                  children: <Widget>[
//                    Padding(
//                      padding: EdgeInsets.all(MediaQuery.of(context).size.height/20),
//                      child: Text("There's nobody around. \n Go get a walk in and meet new people!",
//                      textAlign: TextAlign.center,
//                      style: TextStyle(fontSize: 20),
//                      ),
//                    ),
//                    Image.asset('assets/img/undraw_peoplearoundyou.png')
//                  ],
//                ):
//                Column(children:
//                snapshot.data),
//              );
//            })
//          ],
//        )
//
//            );
//  }

  double _value = 6.0;
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
  UserTile(
      {this.contactName,
      this.personImage,
      this.uid,
      this.major,
      this.university,
      this.gradYear,
      this.profInterests,
      this.socialInterests,
      this.blocked,
      this.bio});
  final bool blocked;
  final String contactName, personImage, major, uid, university, gradYear, bio;
  final List<dynamic> profInterests, socialInterests;
  Widget buildProfInterests(BuildContext context) {
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
          // Text(interests,
          //     style: TextStyle(color: Color(0xFF1976d2), fontSize: 13))
          Container(
            width: MediaQuery.of(context).size.width / 1.8,
            child: AutoSizeText(
              interests,
              style: TextStyle(color: Color(0xFF096664), fontSize: 13),
              minFontSize: 13,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      );
    } else {
      return SizedBox(
        height: (1.0),
      );
    }
  }

  Widget buildSocialInterests(BuildContext context) {
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
          // Text(
          //   interests,
          //   style: TextStyle(color: Color(0xFF8803fc), fontSize: 13),
          // )
          Container(
            width: MediaQuery.of(context).size.width / 1.8,
            child: AutoSizeText(
              interests,
              style: TextStyle(color: Color(0xFF8803fc), fontSize: 13),
              minFontSize: 13,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
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
        SizedBox(
          height: 5.0,
        ),
        InkWell(
          onTap: () {
            if (blocked != true) {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => UserCard(
                            userId: uid,
                            userName: contactName,
                          )));
            } else {
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
                        "You can't interact with a blocked user",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
                flushbarPosition: FlushbarPosition.TOP,
                icon: Padding(
                  padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                  child: Icon(
                    Icons.info_outline,
                    size: 28.0,
                    color: Color(0xFF1458EA),
                  ),
                ),
                duration: Duration(seconds: 3),
              )..show(context);
            }
          },
          child: ListTile(
            title: Text(
              blocked == true ? "Blocked User" : contactName,
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.height / 1000, 0, 0),
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
                      0, MediaQuery.of(context).size.height / 600, 0, 0),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: <Widget>[
                      Text(
                        bio != null ? bio : "",
                        style: TextStyle(
                          color: Color(0xFF1458EA),
                        ),
                        textAlign: TextAlign.start,
                      )
                      // buildSocialInterests(context),
                      // socialInterests != null
                      //     ? SizedBox(
                      //         height: MediaQuery.of(context).size.height / 300,
                      //       )
                      //     : SizedBox(
                      //         height: (0.0),
                      //       ),
                      // buildProfInterests(context)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, MediaQuery.of(context).size.height / 50, 0),
                )
              ],
            ),
            leading: Stack(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(blocked == true
                      ? "https://firebasestorage.googleapis.com/v0/b/dime-87d60.appspot.com/o/defaultprofile.png?alt=media&token=8cd5318b-9593-4837-a9f9-2a22c87463ef"
                      : personImage),
                  radius: screenH(30),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width / 10000000,
                  top: MediaQuery.of(context).size.height / 23.5,
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.height / 80,
                    backgroundColor: Colors.white,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 600,
                        ),
                        Text(
                          "🔒",
                          style: TextStyle(fontSize: screenH(11.5)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                blocked != true
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Colors.grey[100],
                        ),
                        child: IconButton(
                          icon: Icon(Feather.message_circle),
                          color: Colors.black,
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => Chat(
                                          fromUserId: currentUserModel.uid,
                                          toUserId: uid,
                                        )));
                          },
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        )
      ],
    );
  }
}

Widget LocalNotifcation(BuildContext context, String titleMessage,
    String bodyMessage, String notifType, Map<String, dynamic> message) {
  return Flushbar(
    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    borderRadius: 15,
    onTap: (Flushbar) {
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        if (message['notifType'] == "chat") {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => Chat(
                        fromUserId: currentUserModel.uid,
                        toUserId: message['senderId'],
                      )));
        } else if (message['notifType'] == "postNotif") {
          if (message['type'] == "prof") {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => ProfComments(
                          postId: message['postId'],
                        )));
          } else {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => SocialComments(
                          postId: message['postId'],
                        )));
          }
        } else if (message['notifType'] == "streamNotif") {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => ProfPage(stream: message['title'])));
        }
      } else {
        if (message['data']['notifType'] == "chat") {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => Chat(
                        fromUserId: currentUserModel.uid,
                        toUserId: message['data']['senderId'],
                      )));
        } else if (message['data']['notifType'] == "postNotif") {
          if (message['data']['type'] == "prof") {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => ProfComments(
                          postId: message['data']['postId'],
                        )));
          } else {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => SocialComments(
                          postId: message['data']['postId'],
                        )));
          }
        } else if (message['data']['notifType'] == "streamNotif") {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) =>
                      ProfPage(stream: message['data']['title'])));
        }
      }
    },
    messageText: Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            titleMessage,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            bodyMessage,
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    ),
    backgroundColor: Colors.white,
    flushbarPosition: FlushbarPosition.TOP,
    icon: Padding(
      padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
      child: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Color(0xFF1458EA),
      ),
    ),
    duration: Duration(seconds: 3),
  )..show(context);
}
