import 'package:Dime/profPage.dart';
import 'package:Dime/socialPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:rubber/rubber.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'viewCards.dart';


class ScrollPage extends StatefulWidget {
  ScrollPage({Key key}) : super(key: key);
  @override
  _ScrollPageState createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage>
    with SingleTickerProviderStateMixin {
  RubberAnimationController _controller;
  //Completer <GoogleMapController> mapController = Completer();
  GoogleMapController mapController;
  FocusNode _focus = new FocusNode();

  Geoflutterfire geo;
  // Stream<List<DocumentSnapshot>> stream;
  // var radius = BehaviorSubject<double>.seeded(1.0);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  

  // getPermission() async {
  //   final GeolocationResult result =
  //       await Geolocation.requestLocationPermission(const LocationPermission(
  //           android: LocationPermissionAndroid.fine,
  //           ios: LocationPermissionIOS.always));
  //   return result;
  // }

  getPermission() async{
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.locationAlways]);
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

  @override
  void initState() {
    print('home');
print(currentUserModel.email);
          var location = new Location();

        location.onLocationChanged().listen((LocationData currentLocation) {
          mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(currentLocation.latitude,currentLocation.longitude),
          zoom: 18
          )));

        });

    
    _controller = RubberAnimationController(
        vsync: this,
        upperBoundValue: AnimationControllerValue(percentage: 0.95),
        initialValue: 0.40,
        lowerBoundValue: AnimationControllerValue(percentage: 0.40),
        duration: Duration(milliseconds: 200));
    super.initState();
    _focus.addListener(_onFocusChange);
    
    getPermission();
  }

  void _onFocusChange(){
    if(_focus.hasFocus){
      _controller.animateTo(from: _controller.value, to: _controller.upperBound);
    }
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
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width / 17.5, 0, 0, 0),
                      ),
                      // RaisedButton(

                      //     child: Text('Logout'),
                      //     onPressed: () async{

                      //       FirebaseAuth.instance.signOut().then((value) {
                      //         Navigator.push(context,
                      //             new MaterialPageRoute(builder: (context) => Login()));

                      //       }).catchError((e) {
                      //         print(e);
                      //       });
                      //     }),
                      FloatingActionButton(
                        onPressed: () {
                        
                        Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: SocialPage()));
                        },
                        elevation: 0,
                        heroTag: 'btn1',
                        backgroundColor: Color(0xFF8803fc),
                        child: Icon(Entypo.drink),
                        // shape: RoundedRectangleBorder(
                        //   borderRadius:  BorderRadius.only(
                        //     topRight: Radius.circular(25),
                        //     bottomRight: Radius.circular(25),
                        //   )

                        //   ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width / 1.65, 0, 0, 0),
                      ),
                      FloatingActionButton(
                         onPressed: () {
                        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: ProfPage()));
                        },
                        elevation: 0,
                        heroTag: 'btn2',
                        backgroundColor: Color(0xFF1976d2),
                        child: Icon(
                          MaterialCommunityIcons.account_tie,
                          //size: 25,
                        ),
                        // shape: RoundedRectangleBorder(
                        //   borderRadius:  BorderRadius.only(
                        //     topLeft: Radius.circular(25),
                        //     bottomLeft: Radius.circular(25),
                        //   )

                        //   ),
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
                Container(
                  //color: Colors.white,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 22,
                        vertical: MediaQuery.of(context).size.height / 72),
                    child: TextField(
                      
                      focusNode: _focus,
                      decoration: new InputDecoration(
                          icon: Icon(Icons.search),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 30,
                              bottom: MediaQuery.of(context).size.height / 75,
                              top: MediaQuery.of(context).size.height / 75,
                              right: MediaQuery.of(context).size.width / 30),
                          hintText: 'Search for people, interests, school ...'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          headerHeight: MediaQuery.of(context).size.height / 3.68,
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
            child: Text("What's Happening", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
            alignment: Alignment.topCenter,
            
            
            ),


        ),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 40,
              MediaQuery.of(context).size.height / 20, 0, 0),
          child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  icon: Icon(
                MaterialCommunityIcons.chat,
                color: Colors.black,
                size: 30,
              ))),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 40,
              MediaQuery.of(context).size.height / 7, 0, 0),
          child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  icon: Icon(
                Icons.settings,
                color: Colors.black,
                size: 30,
              ))),
        )
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
        zoomGesturesEnabled: false,
        initialCameraPosition:
            CameraPosition(target: LatLng(56.130367,-106.346771), zoom: 2),
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
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                "Dhruv Patel",
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
                    child: Text("Mechatronics Engineering, 2023"),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height / 70, 0, 0),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 30,
                        width: MediaQuery.of(context).size.width / 6,
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width / 40,
                            MediaQuery.of(context).size.height / 150,
                            0,
                            0),
                        child: Text("Badminton",
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                        decoration: BoxDecoration(
                            color: Color(0xFF8803fc),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 30,
                        width: MediaQuery.of(context).size.width / 8.5,
                        padding: EdgeInsets.fromLTRB(10, 4.5, 0, 0),
                        child: Text("Flutter",
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                        decoration: BoxDecoration(
                            color: Color(0xFF1976d2),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height / 50, 0, 0),
                  )
                ],
              ),
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/img/dhruvpatel.jpeg'),
                radius: 20,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(MaterialCommunityIcons.chat),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(MaterialCommunityIcons.card_bulleted),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ViewCards()));
                    },
                  ),
                ],
              ),
            );
          },
          itemCount: 100),
    );
  }


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

  // void _updateMarkers(List<DocumentSnapshot> documentList) {
  //   documentList.forEach((DocumentSnapshot document) {
  //     GeoPoint point = document.data['position']['geopoint'];
  //     _addMarker(point.latitude, point.longitude);
  //   });
  // }




}
