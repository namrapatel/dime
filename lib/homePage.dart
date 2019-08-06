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
  //Completer <GoogleMapController> mapController = Completer();
  GoogleMapController mapController;

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





      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(currentLocation.latitude,currentLocation.longitude),
          zoom: 18
      )));


      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: 18)));
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

//
  void _onFocusChange() {
    if (_focus.hasFocus) {
      _controller.animateTo(
          from: _controller.value, to: _controller.upperBound);
    }
  }
  @override
  void dispose() {
    streamController.close(); //Streams must be closed when not needed
    super.dispose();
  }


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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.leftToRight,
                                  child: SocialPage()));
                        },
                        elevation: 0,
                        heroTag: 'btn1',
                        backgroundColor: Color(0xFF8803fc),
                        child: Icon(
                          Entypo.drink,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width / 1.65, 0, 0, 0),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: ProfPage()));
                        },
                        elevation: 0,
                        heroTag: 'btn2',
                        backgroundColor: Color(0xFF1976d2),
                        child: Icon(MaterialCommunityIcons.account_tie,
                            color: Colors.white),
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
                  // child: FluidSlider(
                  //   thumbColor: Colors.black,
                  //   valueTextStyle: TextStyle(color: Colors.white, fontSize: 17),
                  // labelsTextStyle: TextStyle(color: Colors.black, fontSize: 17),
                  // sliderColor: Color(0xFFECE9E4),
                  // min: 5,
                  // max: 50,
                  // //divisions: 10,
                  // value: _value,
                  // //label: _label,
                  // //activeColor: Colors.black,
                  // //inactiveColor: Colors.grey[200],
                  // onChanged: (double value) => changed(value),
                  // ),

                  child: SliderTheme(
                    data: SliderThemeData(
                      overlayColor: Colors.transparent,
                      //thumbShape: SliderComponentShape.noOverlay,
                      overlappingShapeStrokeColor: Colors.black,
                      showValueIndicator: ShowValueIndicator.always,
                      valueIndicatorColor: Colors.black,
                      activeTrackColor: Colors.black,
                      valueIndicatorTextStyle: TextStyle(color: Colors.white),
                      inactiveTrackColor: Color(0xFFECE9E4),
                      thumbColor: Colors.black,
                      trackHeight: 10,

                    ),
                    child: Slider(
                      value: _value,
                      label: _label,
                      onChanged: (double value) => changed(value),
                      min: 5,
                      max: 50,
                    ),

                  ),
                ),
              ],
            ),
          ),
          headerHeight: MediaQuery.of(context).size.height / 3.2,
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
        _googlemap(context),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 40,
              MediaQuery.of(context).size.height / 14, 0, 0),
          child: Align(
            child: Text(
              "What's Happening",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),

            alignment: Alignment.topCenter,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 40,
              MediaQuery.of(context).size.height / 8, 0, 0),
          child: Container(
            width: 40,
            height: 40,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: ChatList()));
              },
              elevation: 10,
              backgroundColor: Colors.white,
              heroTag: 'fabb1',
              child: Icon(
                MaterialCommunityIcons.chat,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 40,
              MediaQuery.of(context).size.height / 5, 0, 0),
          child: Container(
            width: 40,
            height: 40,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: ProfilePage()));
              },
              elevation: 10,
              backgroundColor: Colors.white,
              heroTag: 'fabb2',
              child: Icon(
                Icons.settings,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 40,
              MediaQuery.of(context).size.height / 3.6, 0, 0),
          child: Container(
            width: 40,
            height: 40,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: UserCard(
                          userId: currentUserModel.uid,
                        )));
              },
              elevation: 10,
              backgroundColor: Colors.white,
              heroTag: 'fabb3',
              child: Icon(
                MaterialCommunityIcons.card_bulleted,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 40,
                MediaQuery.of(context).size.height / 2.83, 0, 0),
            child: Container(
                width: 40,
                height: 40,
                child: FloatingActionButton(
                  elevation: 10,
                  backgroundColor: Colors.white,
                  heroTag: 'fabb4',
                  child: Icon(
                    Ionicons.md_search,
                    color: Colors.black,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Explore()));
                  },
                ))),
        Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 40,
                MediaQuery.of(context).size.height / 2.35, 0, 0),
            child: Container(
                width: 40,
                height: 40,
                child: FloatingActionButton(
                  elevation: 10,
                  backgroundColor: Colors.white,
                  heroTag: 'fabb5',
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: InviteFriends()));
                  },
                ))),
      ],
    );
  }

  Widget _googlemap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        initialCameraPosition:
        CameraPosition(target: LatLng(56.130367, -106.346771), zoom: 2),
        onMapCreated: (GoogleMapController controller) {
          //mapController.complete(controller);
          mapController = controller;
          mapController.setMapStyle(
              '[{"featureType":"all","elementType":"labels.text.fill","stylers":[{"color":"#7c93a3"},{"lightness":"-10"}]},{"featureType":"administrative.country","elementType":"geometry","stylers":[{"visibility":"on"}]},{"featureType":"administrative.country","elementType":"geometry.stroke","stylers":[{"color":"#a0a4a5"}]},{"featureType":"administrative.province","elementType":"geometry.stroke","stylers":[{"color":"#62838e"}]},{"featureType":"landscape","elementType":"geometry.fill","stylers":[{"color":"#dde3e3"}]},{"featureType":"landscape.man_made","elementType":"geometry.stroke","stylers":[{"color":"#3f4a51"},{"weight":"0.30"}]},{"featureType":"poi","elementType":"all","stylers":[{"visibility":"simplified"}]},{"featureType":"poi.attraction","elementType":"all","stylers":[{"visibility":"on"}]},{"featureType":"poi.business","elementType":"all","stylers":[{"visibility":"on"}]},{"featureType":"poi.government","elementType":"all","stylers":[{"visibility":"on"}]},{"featureType":"poi.park","elementType":"all","stylers":[{"visibility":"on"}]},{"featureType":"poi.place_of_worship","elementType":"all","stylers":[{"visibility":"on"}]},{"featureType":"poi.school","elementType":"all","stylers":[{"visibility":"on"}]},{"featureType":"poi.sports_complex","elementType":"all","stylers":[{"visibility":"on"}]},{"featureType":"road","elementType":"all","stylers":[{"saturation":"-100"},{"visibility":"on"}]},{"featureType":"road","elementType":"geometry.stroke","stylers":[{"visibility":"on"}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"color":"#bbcacf"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"lightness":"0"},{"color":"#bbcacf"},{"weight":"0.50"}]},{"featureType":"road.highway","elementType":"labels","stylers":[{"visibility":"on"}]},{"featureType":"road.highway","elementType":"labels.text","stylers":[{"visibility":"on"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry.fill","stylers":[{"color":"#ffffff"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry.stroke","stylers":[{"color":"#a9b4b8"}]},{"featureType":"road.arterial","elementType":"labels.icon","stylers":[{"invert_lightness":true},{"saturation":"-7"},{"lightness":"3"},{"gamma":"1.80"},{"weight":"0.01"}]},{"featureType":"transit","elementType":"all","stylers":[{"visibility":"on"}]},{"featureType":"water","elementType":"geometry.fill","stylers":[{"color":"#a3c7df"}]}]');
        },
      ),
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

  void _addMarker(double lat, double lng) {
    MarkerId id = MarkerId(lat.toString() + lng.toString());
    Marker _marker = Marker(
      markerId: id,
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      infoWindow: InfoWindow(title: 'latLng', snippet: '$lat,$lng'),
    );
    setState(() {
      markers[id] = _marker;
    });
  }
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