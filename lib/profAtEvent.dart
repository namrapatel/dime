import 'package:Dime/profPage.dart';
import 'package:latlong/latlong.dart' as Lat;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'viewCards.dart';
import 'login.dart';
import 'package:Dime/socialPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'viewCards.dart';
import 'login.dart';
import 'homePage.dart';
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
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:rxdart/rxdart.dart';

class profAtEvent extends StatefulWidget {
  profAtEvent({Key key}) : super(key: key);
  @override
  _profAtEventState createState() => _profAtEventState();
}

class _profAtEventState extends State<profAtEvent>
    with SingleTickerProviderStateMixin {
  var radius = BehaviorSubject<double>.seeded(0.075);
  Geoflutterfire geo =Geoflutterfire();
  Stream<List<DocumentSnapshot>> stream;
  RubberAnimationController _controller;
  //Completer <GoogleMapController> mapController = Completer();

  FocusNode _focus = new FocusNode();

  // getPermission() async {
  //   final GeolocationResult result =
  //       await Geolocation.requestLocationPermission(const LocationPermission(
  //           android: LocationPermissionAndroid.fine,
  //           ios: LocationPermissionIOS.always));
  //   return result;
  // }

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

  @override
  void initState() {
    var location = new Location();



    location.onLocationChanged().listen((LocationData currentLocation) async {


      GeoFirePoint userLoc = geo.point(latitude: currentLocation.latitude, longitude: currentLocation.longitude);

//      Firestore.instance
//          .collection('users')
//          .document(currentUserModel.uid)
//          .setData({
//        'position': userLoc.data,
//      }, merge: true);

//            DocumentSnapshot mine =await Firestore.instance.collection('users').document(currentUserModel.uid).get();
//            GeoFirePoint gp=mine.data['position'];
//
//            double radius = 6.0;
      String field = 'position';
      stream = radius.switchMap((rad) {
        var collectionReference = Firestore.instance.collection('users').where('atEvent',isEqualTo: true);
        return geo.collection(collectionRef: collectionReference).within(
            center: userLoc, radius: rad, field: 'position', strictMode: true);
      });

      changed(value);

    });

    _controller = RubberAnimationController(
        vsync: this,
        upperBoundValue: AnimationControllerValue(percentage: 0.95),
        initialValue: 0.57,
        lowerBoundValue: AnimationControllerValue(percentage: 0.57),
        duration: Duration(milliseconds: 200));
    super.initState();
    _focus.addListener(_onFocusChange);


  }
  double value = 0.075;
  String _label = '';

  changed(value) {
    setState(() {
      value = value;
      print(value);
      _label = '${value.toInt().toString()} kms';
    });
    radius.add(value);
  }

  void _onFocusChange() {
    if (_focus.hasFocus) {
      _controller.animateTo(
          from: _controller.value, to: _controller.upperBound);
    }
  }

  String _value;

  DropdownButton _normalDown() => DropdownButton<String>(
        iconEnabledColor: Colors.white,
        icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
        items: [
          DropdownMenuItem(
            value: "1",
            child: Text(
              "Build Relationships",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          DropdownMenuItem(
            value: "2",
            child: Text(
              "Engage in content",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          DropdownMenuItem(
            value: "3",
            child: Text(
              "Participate in key conversations",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          DropdownMenuItem(
            value: "4",
            child: Text(
              "Just to learn something",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        },
        value: _value,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Center(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width / 17.5, 0, 0, 0),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width / 1.65, 0, 0, 0),
                      ),
                    ],
                  ),
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
                      "Others at this Event",
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
              ],
            ),
          ),
          headerHeight: MediaQuery.of(context).size.height / 8.75,
          upperLayer: _getUpperLayer(),
          animationController: _controller,
        ),
      ),
    );
  }

  //map goes here
  Widget _getLowerLayer() {
    return new Stack(
      children: <Widget>[
        _btmCard(context),
      ],
    );
  }

  Widget _btmCard(BuildContext context) {
    List<String> _reasons = [
      'Build Relationships',
      'Engage in content',
      'Participate in key conversations',
      'Just to learn something'
    ]; // Option 2
    String _selectedReason; // Option 2

    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(children: <Widget>[
            Container(
              color: Color(0xFF1976d2),
              height: screenH(370),
              width: screenW(420),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: screenH(50),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: screenW(12),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: ProfPage()));
                      },
                      color: Colors.white,
                      iconSize: screenH(25),
                    ),
                    SizedBox(
                      width: screenW(80),
                    ),
                    _normalDown(),
                  ],
                ),
                SizedBox(
                  height: screenH(5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: ViewCards(
                      userId: currentUserModel.uid,
                      type: 'prof',
                    )),
                  ],
                )
              ],
            ),
          ]),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Padding(
            padding: EdgeInsets.all(5),
          ),
          // Container(
          //   //width: MediaQuery.of(context).size.width,
          //   width: 270,
          //   height: 90,
          //         decoration: BoxDecoration(
          //             color: Color(0xFF1976d2),
          //             borderRadius: BorderRadius.circular(20)),
          // )
        ],
      ),
    );
  }
  Future<List<UserTile>>getUsers() async{
    List<UserTile> userList=[];
//    final Lat.Distance distance = new Lat.Distance();
//    final double km = distance(
//        new Lat.LatLng(43.472285,-80.54486),new Lat.LatLng(43.473095,-80.5394933));
//print(km);
    final Lat.Distance distance = new Lat.Distance();
    QuerySnapshot query =await Firestore.instance.collection('users').where('atEvent',isEqualTo: true).getDocuments();
    final docs= query.documents;
    for(var doc in docs){
//      print(doc.data['currentLocation'].latitude);
//      print(doc.data['currentLocation'].longitude);
      final double distanceInMeters = distance(new Lat.LatLng(currentUserModel.currentLocation.latitude,currentUserModel.currentLocation.longitude),new Lat.LatLng(doc.data['currentLocation'].latitude,doc.data['currentLocation'].longitude));
//      await Geolocator().distanceBetween(userLoc.latitude, userLoc.longitude, doc.data['currentLocation'].latitude, doc.data['currentLocation'].longitude);
      print(doc.data['displayName']);
      print('distance away is');
      print(distanceInMeters);
      if(distanceInMeters<=75.0&&currentUserModel.uid!=doc.documentID){
        int counter=0;
        if(doc.data['university']==currentUserModel.university){
          counter++;
        }
        if(doc.data['gradYear']==currentUserModel.gradYear){
          counter++;
        }
        if(doc.data['major'].toString().toLowerCase()==currentUserModel.major.toLowerCase()){
          counter=counter+2;
        }
//        if(doc.data['profInterests']!=null){
        List<dynamic> interests =doc.data['profInterests']+doc.data['socialInterests'];
        print(interests);
        List<dynamic> myInterests= currentUserModel.profInterests+currentUserModel.socialInterests;
        for(int i=0;i<interests.length;i++){
          for(int a=0;a<myInterests.length;a++){
            if(interests[i]==myInterests[a]){
              counter=counter+2;
            }
          }
        }
//        }

        userList.add(new UserTile(doc.data['displayName'],doc.data['photoUrl'],doc.documentID,counter,major: doc.data['major'],profInterests: doc.data['profInterests'],socialInterests: doc.data['socialInterests'],university: doc.data['university'],gradYear:doc.data['gradYear']));
      }
      for(var user in userList){
        print(user.contactName);
      }
      userList.sort((a, b) => a.compatibility.compareTo(b.compatibility));
      for(var user in userList){
        print(user.contactName);
      }
    } return userList;


  }

  Widget _getUpperLayer() {
    return   Container(
        color: Colors.white,
        child: Container(
            color: Colors.white,
            child:  FutureBuilder<List<UserTile>>(
                future: getUsers(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Container(
                        alignment: FractionalOffset.center,
                        child: CircularProgressIndicator());

                  return Column(children: snapshot.data);
                })
        )
    );

  }
}
