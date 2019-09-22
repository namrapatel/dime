import 'dart:async';
import 'package:Dime/models/largerPic.dart';
import 'package:Dime/notifcations.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
import 'dart:io';
import 'package:package_info/package_info.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
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
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

String currentToken = "";
final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;

class ScrollPage extends StatefulWidget {
  final bool social;
//  const ScrollPage({this.social});
  ScrollPage({Key key, this.social}) : super(key: key);
  @override
  _ScrollPageState createState() => _ScrollPageState(socialPressed: social);
}

class _ScrollPageState extends State<ScrollPage>
    with SingleTickerProviderStateMixin {
//  bool liked=false;

  String likeType = 'social';
  _ScrollPageState({this.socialPressed});
  bool socialPressed;
//  bool profPressed=false;
  bool goodProfileStandard = false;
  RubberAnimationController _controller;
  int unreadMessages = 0;
  int unread = 0;
  FocusNode _focus = new FocusNode();
  StreamController<List<DocumentSnapshot>> streamController;
  StreamSubscription subscription;
  Geoflutterfire geo = Geoflutterfire();
//  Stream<List<DocumentSnapshot>> stream;
  Stream<List<DocumentSnapshot>> socStream;
  Stream<List<DocumentSnapshot>> proStream;

  Stream<List<DocumentSnapshot>> stream;
  var typeStream = BehaviorSubject<String>.seeded("socialVisible");

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
      unreadMessages = query.documents.length;
    });
  }

  getUnreadNotifs() async {
    QuerySnapshot query = await Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .collection('likes')
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
  bool appearOnSocial = false;
  bool appearOnProf = false;
  LocationData position;
  GeoPoint current;
  getVisibilityPrefs() async {
    DocumentSnapshot userDoc = await Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .get();
    print(currentUserModel.verified);
    print('verified checkkk');

    setState(() {
      if ((userDoc['displayName'] != 'New User' &&
              userDoc['displayName'] != 'No Display Name') &&
          userDoc['university'] != null &&
          userDoc['gradYear'] != null &&
          userDoc['major'] != null &&
          userDoc['bio'] != null) {
        goodProfileStandard = true;
      }

      if (userDoc['profVisible'] != null && goodProfileStandard == true) {
        appearOnProf = userDoc['profVisible'];
      }
      if (userDoc['socialVisible'] != null && goodProfileStandard == true) {
        appearOnSocial = userDoc['socialVisible'];
      }
      if (userDoc['profVisible'] == null && goodProfileStandard == true) {
        Firestore.instance
            .collection('users')
            .document(currentUserModel.uid)
            .updateData({'profVisible': true});
      }
      if (userDoc['socialVisible'] == null && goodProfileStandard == true) {
        Firestore.instance
            .collection('users')
            .document(currentUserModel.uid)
            .updateData({'socialVisible': true});
      }
    });
  }

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

//    setState(() {
//      socStream = geo
//          .collection(collectionRef: Firestore.instance.collection('users').where('socialVisible',isEqualTo: true))
//          .within(
//          center: userLoc,
//          radius: radius,
//          field: 'position',
//          strictMode: strictmode);
//
//      proStream = geo
//          .collection(collectionRef: Firestore.instance.collection('users').where('profVisible',isEqualTo: true))
//          .within(
//          center: userLoc,
//          radius: radius,
//          field: 'position',
//          strictMode: strictmode);
//    });

    stream = typeStream.switchMap((String streamType) {
      return geo
          .collection(
              collectionRef: Firestore.instance
                  .collection('users')
                  .where(streamType, isEqualTo: true))
          .within(
              center: userLoc,
              radius: radius,
              field: 'position',
              strictMode: strictmode);
    });

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
    versionCheck(context);
    getVisibilityPrefs();
    getUnreadMessages();
    getUnreadNotifs();
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
        } else if (message['notifType'] == "likeNotif") {
          LocalNotifcation(context, message['aps']['alert']['title'],
              message['aps']['alert']['body'], "likeNotif", message);
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
        } else if (message['data']['notifType'] == "likeNotif") {
          LocalNotifcation(context, message['aps']['alert']['title'],
              message['aps']['alert']['body'], "likeNotif", message);
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
        } else if (message['notifType'] == "likeNotif") {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => NotifcationsScreen()));
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
        } else if (message['data']['notifType'] == "likeNotif") {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => NotifcationsScreen()));
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
        } else if (message['notifType'] == "likeNotif") {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => NotifcationsScreen()));
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
        } else if (message['data']['notifType'] == "likeNotif") {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => NotifcationsScreen()));
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

  String force;
  final APP_STORE_URL = 'https://apps.apple.com/app/id1476202100';
  final PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=com.dime2.inc';

  versionCheck(context) async {
    //Get Current installed version of app
    final PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion =
        double.parse(info.version.trim().replaceAll(".", ""));

    //Get Latest version info from firebase config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    setChecker() async {
      DocumentSnapshot remote = await Firestore.instance
          .collection('remoteConfig')
          .document('checker')
          .get();

      setState(() {
        force = remote['force'];
      });
    }

    setChecker();
    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      remoteConfig.getString('force_update_current_version');
      double newVersion = double.parse(remoteConfig
          .getString('force_update_current_version')
          .trim()
          .replaceAll(".", ""));
      if (newVersion > currentVersion) {
        _showVersionDialog(context);
      }
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
  }

//Show Dialog to force user to update
  _showVersionDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "New Update Available";
        String message =
            "There is a newer version of app available please update it now.";
        String btnLabel = "Update Now";
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchURL(APP_STORE_URL),
                  ),
                  force == "false"
                      ? FlatButton(
                          child: Text("Later"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      : Container()
                ],
              )
            : new AlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchURL(PLAY_STORE_URL),
                  ),
                  force == "false"
                      ? FlatButton(
                          child: Text("Later"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      : Container()
                ],
              );
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
                      width: MediaQuery.of(context).size.width / 1.9,
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
              Container(
                  child: Stack(children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => ChatList()));
                  },
                  icon: Icon(
                    Feather.message_circle,
                    size: MediaQuery.of(context).size.height / 38,
                    color: Colors.white,
                  ),
                ),
                unreadMessages > 0
                    ? Positioned(
                        top: MediaQuery.of(context).size.height / 70,
                        left: MediaQuery.of(context).size.width / 13,
                        child: CircleAvatar(
                          child: Text(
                            unreadMessages.toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                          ),
                          backgroundColor: Colors.red,
                          radius: 8.2,
                        ))
                    : SizedBox(
                        height: 0.0,
                      )
              ])),
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
                  // Padding(
                  //     padding: EdgeInsets.fromLTRB(
                  //         0, MediaQuery.of(context).size.height / 1000000, 0, 0)),
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 72,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.info_outline,
                          color: Color(0xFF1458EA),
                        ),
                        onPressed: () {
                          Flushbar(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            borderRadius: 15,
                            messageText: Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "You can like someone socially or professionally which will send them an anonymous notification with your bio, and the type of like you are sending. If they like you back, have fun chatting!",
                                    style: TextStyle(color: Colors.black),
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
                            duration: Duration(seconds: 10),
                          )..show(context);
                        },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: FloatingActionButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                          onPressed: () {
//                  Navigator.push(
//                      context,
//                      CupertinoPageRoute(
//                          builder: (context) => ScrollPage(social: true,)));
                            setState(() {
                              changed("socialVisible");

                              likeType = 'social';
                              socialPressed = !socialPressed;
                            });
                          },
                          elevation: 0,
                          heroTag: 'socialButton',
                          backgroundColor: socialPressed == false
                              ? Colors.white
                              : Colors.grey[100],
                          child: Icon(
                            Entypo.drink,
                            color: Color(0xFF8803fc),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: FloatingActionButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                          onPressed: () {
//                  Navigator.push(
//                      context,
//                      CupertinoPageRoute(
//                          builder: (context) => ScrollPage(social: false,)));
                            setState(() {
                              changed("profVisible");

                              likeType = 'prof';
                              socialPressed = !socialPressed;
                            });
                          },
                          elevation: 0,
                          heroTag: 'profButton',
                          backgroundColor: socialPressed == true
                              ? Colors.white
                              : Colors.grey[100],
                          child: Icon(
                            FontAwesome.graduation_cap,
                            color: Color(0xFF096664),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(75, 8, 75, 0),
                  ),
                  //Should disable the people around you feature if the rating is not 100%
                  //Don't show if the profile rating is 100%
                  // Padding(
                  //   padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/3.3, 0, 0, 0),
                  //   child: Tooltip(
                  //     padding: EdgeInsets.symmetric(horizontal: 20),
                  //     height: 50,
                  //     waitDuration: Duration(seconds: 0),
                  //     message: "Fill out name, program, grad year, and bio on your profile to view and be visible on the people around you",
                  //     child: Row(
                  //       children: <Widget>[
                  //         Icon(Icons.info_outline, color: Colors.blue),
                  //         SizedBox(width: MediaQuery.of(context).size.width/50),
                  //         Text("Profile Rating: " + "75%", textAlign: TextAlign.center),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            headerHeight: MediaQuery.of(context).size.height / 4.1,
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
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => NotifcationsScreen()));
                    },
                    elevation: 3,
                    heroTag: 'btn2',
                    backgroundColor: Colors.white,
                    child: Icon(
                      Ionicons.md_notifications_outline,
                      color: Colors.black,
                      size: 30.0,
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
    List<DocumentSnapshot> socialStream = [];
    List<DocumentSnapshot> profStream = [];
    return Container(
        color: Colors.white,
        child: ListView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 500,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 22.5,
                  ),
                  Text(
                    socialPressed == true
                        ? 'Appear on Casual Location Feed?'
                        : 'Appear on Network Location Feed?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5.5,
                  ),
                  socialPressed == true
                      ? Switch(
                          value: appearOnSocial,
                          onChanged: (value) {
                            if (goodProfileStandard == true) {
                              setState(() {
                                appearOnSocial = value;
                              });
                              Firestore.instance
                                  .collection('users')
                                  .document(currentUserModel.uid)
                                  .updateData(
                                      {'socialVisible': appearOnSocial});
                            }
                          },
                          activeTrackColor: Colors.blue[200],
                          activeColor: Color(0xff1976d2))
                      : Switch(
                          value: appearOnProf,
                          onChanged: (value) {
                            if (goodProfileStandard == true) {
                              setState(() {
                                appearOnProf = value;
                              });
                              Firestore.instance
                                  .collection('users')
                                  .document(currentUserModel.uid)
                                  .updateData({'profVisible': appearOnProf});
                            }
                          },
                          activeTrackColor: Colors.blue[200],
                          activeColor: Color(0xff1976d2)),
                ],
              ),
              ((socialPressed == true &&
                          appearOnSocial == true &&
                          goodProfileStandard == true) ||
                      (socialPressed == false &&
                          appearOnProf == true &&
                          goodProfileStandard == true))
                  ? StreamBuilder(
                      stream: stream,
                      builder: (context, snapshots) {
                        if (!snapshots.hasData) {
                          return Container(
                              alignment: FractionalOffset.center,
                              child: CircularProgressIndicator());
                        } else {
                          print('im IN THE soc stream');
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
                                            MediaQuery.of(context).size.height /
                                                20),
                                        child: Text(
                                          "There's nobody around. \n Go get a walk in and find some new people!",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height *
                                        2 /
                                        3,
                                    child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      cacheExtent: 5000.0,
                                      itemBuilder: (context, index) {
                                        print('still in social ');
                                        DocumentSnapshot doc =
                                            snapshots.data[index];
                                        print(
                                            'doc with id ${doc.documentID} distance ${doc.data['distance']}');
                                        GeoPoint point =
                                            doc.data['position']['geopoint'];
                                        if (doc.data[
                                                'blocked${currentUserModel.uid}'] ==
                                            true) {
                                          return UserTile(blocked: true);
                                        } else {
                                          bool liked;

                                          List<dynamic> likedBy =
                                              doc.data['likedBy'];

                                          if (likedBy != null &&
                                              likedBy.contains(
                                                  currentUserModel.uid)) {
                                            liked = true;

//                                liked = true;

                                            print('in here for somer eason');
                                          } else {
                                            liked = false;
                                          }
                                          String type = "social";
                                          print('guys name is' +
                                              doc.data['displayName']);
                                          if (socialPressed) {
                                            type = "social";
                                          } else {
                                            type = "prof";
                                          }
                                          var status;

                                          if (socialPressed == true) {
                                            status =
                                                doc.data['relationshipStatus'];
                                          }
                                          return UserTile(
                                              verified: doc.data['verified'],
                                              liked: liked,
                                              likeType: type,
                                              relationshipStatus: status,
                                              contactName:
                                                  doc.data['displayName'],
                                              personImage: doc.data['photoUrl'],
                                              uid: doc.documentID,
                                              major: doc.data['major'],
                                              university:
                                                  doc.data['university'],
                                              gradYear: doc.data['gradYear'],
                                              bio: doc.data['bio']);
                                        }
                                      },
                                      itemCount: snapshots.data.length,
                                    ),
                                  ),
                          ));
                        }
                      },
                    )
                  : Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 3.5,
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Image.asset(
                            'assets/img/undraw_peoplearoundyou.png',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                              "Please turn the location toggle on or ensure your profile is set up with a name, university, program, grad year, and bio!",
                              textAlign: TextAlign.center),
                        ),
                      ],
                    )
            ]));
  }

  String _value = "social";
  String _label = '';

  changed(value) {
    setState(() {
      _value = value;
      print(_value);
      typeStream.add(value);
    });
  }
}

class UserTile extends StatefulWidget {
  final bool blocked, liked, verified;
  final String likeType,
      relationshipStatus,
      contactName,
      personImage,
      major,
      uid,
      university,
      gradYear,
      bio;
  const UserTile(
      {this.verified,
      this.liked,
      this.likeType,
      this.relationshipStatus,
      this.contactName,
      this.personImage,
      this.uid,
      this.major,
      this.university,
      this.gradYear,
      this.blocked,
      this.bio});
  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    setState(() {

//    liked=widget.liked;

//    });
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
            if (widget.blocked != true) {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => UserCard(
                            userId: widget.uid,
                            userName: widget.contactName,
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
            title: Row(
              children: <Widget>[
                Text(
                  widget.blocked == true ? "Blocked User" : widget.contactName,
                  style: TextStyle(fontSize: 18),
                ),
                widget.verified == true
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(screenW(4.0), 0, 0, 0),
                        child: Icon(
                          Feather.check_circle,
                          color: Color(0xFF096664),
                          size: screenF(17),
                        ))
                    : Container(),
              ],
            ),
            subtitle: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.height / 1000, 0, 0),
                ),
                widget.major != null && widget.gradYear != null
                    ? Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(widget.major + ", " + widget.gradYear),
                      )
                    : Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(widget.major != null ? widget.major : ""),
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
                        widget.bio != null ? widget.bio : "",
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => LargePic(
                                  largePic: widget.personImage,
                                )));
                  },
                  child: CircleAvatar(
                    radius: screenH(30),
                    backgroundImage: CachedNetworkImageProvider(
                      widget.blocked == true
                          ? "https://firebasestorage.googleapis.com/v0/b/dime-87d60.appspot.com/o/defaultprofile.png?alt=media&token=8cd5318b-9593-4837-a9f9-2a22c87463ef"
                          : widget.personImage,
                    ),
                  ),
                ),
                widget.relationshipStatus != null
                    ? Positioned(
                        left: MediaQuery.of(context).size.width / 10000000,
                        top: MediaQuery.of(context).size.height / 23.5,
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.height / 80,
                          backgroundColor: Colors.white,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 600,
                              ),
                              Text(
                                widget.relationshipStatus,
                                style: TextStyle(fontSize: screenH(11.5)),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 0.0,
                      )
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                widget.blocked != true
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            color: Colors.grey[100]),
                        child: IconButton(
                          icon: widget.liked == false
                              ? Icon(
                                  AntDesign.like2,
                                  size: screenH(25),
                                  color: Color(0xFF1458EA),
                                )
                              : Icon(
                                  AntDesign.like1,
                                  size: screenH(25),
                                  color: Color(0xFF1458EA),
                                ),
                          color: Colors.black,
                          onPressed: () {
                            if (widget.liked == false) {
                              setState(() {
//                                likeCheck=true;
//                                widget.liked = true;
                                List<String> myId = [];
                                myId.add(currentUserModel.uid);
                                Firestore.instance
                                    .collection('users')
                                    .document(widget.uid)
                                    .updateData({
                                  'likedBy': FieldValue.arrayUnion(myId),
                                });

                                List<String> userID = [];
                                userID.add(widget.uid);
                                Firestore.instance
                                    .collection('users')
                                    .document(currentUserModel.uid)
                                    .updateData({
                                  'likedUsers': FieldValue.arrayUnion(userID)
                                });

                                Firestore.instance
                                    .collection('users')
                                    .document(widget.uid)
                                    .collection('likes')
                                    .document(currentUserModel.uid)
                                    .setData({
//                              'likerName':currentUserModel.displayName,
//                              'likerPhoto':currentUserModel.photoUrl,
//                              'likerBio':currentUserModel.bio,
//                              'likerUni':currentUserModel.university,
//                              'likerMajor':currentUserModel.major,
//                              'likerGradYear':currentUserModel.gradYear,
//                              'likerRelationshipStatus':currentUserModel.relationshipStatus,
                                  'unread': true,
                                  'timestamp': Timestamp.now(),
                                  'liked': false,
                                  'likeType': widget.likeType
                                });

                                Firestore.instance
                                    .collection('likeNotifs')
                                    .add({
                                  'toUser': widget.uid,
                                  'fromUser': currentUserModel.uid,
                                  "likeType": widget.likeType
                                });

                                Flushbar(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  borderRadius: 15,
                                  messageText: Padding(
                                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          widget.likeType == "social"
                                              ? "A casual" +
                                                  " like has been sent to " +
                                                  widget.contactName
                                              : "A network" +
                                                  " like has been sent to " +
                                                  widget.contactName,
                                          style: TextStyle(color: Colors.black),
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
                                  duration: Duration(seconds: 10),
                                )..show(context);
                              });
                            }
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

//class UserTile extends StatelessWidget {
//  UserTile(
//      {this.liked,this.relationshipStatus,
//      this.contactName,
//      this.personImage,
//      this.uid,
//      this.major,
//      this.university,
//      this.gradYear,
//      this.profInterests,
//      this.socialInterests,
//      this.blocked,
//      this.bio});
//  final bool blocked,liked;
//  final String relationshipStatus,
//      contactName,
//      personImage,
//      major,
//      uid,
//      university,
//      gradYear,
//      bio;
//  final List<dynamic> profInterests, socialInterests;
//  Widget buildProfInterests(BuildContext context) {
//    String interests = "";
//    if (profInterests != null) {
//      for (int i = 0; i < profInterests.length; i++) {
//        if (i == profInterests.length - 1) {
//          interests = interests + profInterests[i];
//        } else {
//          interests = interests + profInterests[i] + ", ";
//        }
//      }
//      return Row(
//        children: <Widget>[
//          // Text(interests,
//          //     style: TextStyle(color: Color(0xFF1976d2), fontSize: 13))
//          Container(
//            width: MediaQuery.of(context).size.width / 1.8,
//            child: AutoSizeText(
//              interests,
//              style: TextStyle(color: Color(0xFF096664), fontSize: 13),
//              minFontSize: 13,
//              maxLines: 1,
//              overflow: TextOverflow.ellipsis,
//            ),
//          )
//        ],
//      );
//    } else {
//      return SizedBox(
//        height: (1.0),
//      );
//    }
//  }
//
//  Widget buildSocialInterests(BuildContext context) {
//    String interests = "";
//    if (socialInterests != null) {
//      for (int i = 0; i < socialInterests.length; i++) {
//        if (i == socialInterests.length - 1) {
//          interests = interests + socialInterests[i];
//        } else {
//          interests = interests + socialInterests[i] + ", ";
//        }
//      }
//      return Row(
//        children: <Widget>[
//          // Text(
//          //   interests,
//          //   style: TextStyle(color: Color(0xFF8803fc), fontSize: 13),
//          // )
//          Container(
//            width: MediaQuery.of(context).size.width / 1.8,
//            child: AutoSizeText(
//              interests,
//              style: TextStyle(color: Color(0xFF8803fc), fontSize: 13),
//              minFontSize: 13,
//              maxLines: 1,
//              overflow: TextOverflow.ellipsis,
//            ),
//          )
//        ],
//      );
//    } else {
//      return SizedBox(
//        height: (0.0),
//      );
//    }
//  }
//
//  List<Widget> buildInterests(List interestsList, context) {
//    List<Widget> interestWidgets = [];
//
//    for (var interest in interestsList) {
//      interestWidgets.add(Column(children: <Widget>[
//        Container(
//          height: MediaQuery.of(context).size.height / 30,
//          width: MediaQuery.of(context).size.width / 6,
//          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 40,
//              MediaQuery.of(context).size.height / 150, 0, 0),
//          child: Text(interest,
//              style: TextStyle(color: Colors.white, fontSize: 10)),
//          decoration: BoxDecoration(
//              color: Color(0xFF8803fc),
//              borderRadius: BorderRadius.circular(20)),
//        ),
//        Padding(
//          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
//        ),
//      ]));
//    }
//    return interestWidgets;
//  }

//}

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
        } else if (message['notifType'] == "likeNotif") {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => NotifcationsScreen()));
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
        } else if (message['data']['notifType'] == "likeNotif") {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => NotifcationsScreen()));
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
