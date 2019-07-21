import 'package:Dime/profPage.dart';
import 'package:Dime/socialPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';


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
  @override
  void initState() {
    _controller = RubberAnimationController(
        vsync: this,
        upperBoundValue: AnimationControllerValue(percentage: 0.95),
        initialValue: 0.5,
        lowerBoundValue: AnimationControllerValue(percentage: 0.35),
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
          headerHeight: MediaQuery.of(context).size.height / 3.55,
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
        initialCameraPosition:
            CameraPosition(target: LatLng(43.653225, -79.383186), zoom: 10),
        onMapCreated: (GoogleMapController controller) {
          //mapController.complete(controller);
          mapController = controller;
          mapController.setMapStyle(
              '[{"featureType":"administrative","elementType":"labels.text.fill","stylers":[{"color":"#6195a0"}]},{"featureType":"administrative.province","elementType":"geometry.stroke","stylers":[{"visibility":"off"}]},{"featureType":"landscape","elementType":"geometry","stylers":[{"lightness":"0"},{"saturation":"0"},{"color":"#f5f5f2"},{"gamma":"1"}]},{"featureType":"landscape.man_made","elementType":"all","stylers":[{"lightness":"-3"},{"gamma":"1.00"}]},{"featureType":"landscape.natural.terrain","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"poi","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"poi.park","elementType":"geometry.fill","stylers":[{"color":"#bae5ce"},{"visibility":"on"}]},{"featureType":"road","elementType":"all","stylers":[{"saturation":-100},{"lightness":45},{"visibility":"simplified"}]},{"featureType":"road.highway","elementType":"all","stylers":[{"visibility":"simplified"}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"color":"#fac9a9"},{"visibility":"simplified"}]},{"featureType":"road.highway","elementType":"labels.text","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#787878"}]},{"featureType":"road.arterial","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"all","stylers":[{"visibility":"simplified"}]},{"featureType":"transit.station.airport","elementType":"labels.icon","stylers":[{"hue":"#0a00ff"},{"saturation":"-77"},{"gamma":"0.57"},{"lightness":"0"}]},{"featureType":"transit.station.rail","elementType":"labels.text.fill","stylers":[{"color":"#43321e"}]},{"featureType":"transit.station.rail","elementType":"labels.icon","stylers":[{"hue":"#ff6c00"},{"lightness":"4"},{"gamma":"0.75"},{"saturation":"-68"}]},{"featureType":"water","elementType":"all","stylers":[{"color":"#eaf6f8"},{"visibility":"on"}]},{"featureType":"water","elementType":"geometry.fill","stylers":[{"color":"#c7eced"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"lightness":"-49"},{"saturation":"-53"},{"gamma":"0.79"}]}]');
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
                backgroundColor: Colors.black,
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
                      _showCupertinoDialog();
                    },
                  ),
                ],
              ),
            );
          },
          itemCount: 100),
    );
  }

  void _showCupertinoDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Send Card to Dhruv Patel?'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Please select the card you would like to send. It will send as a message, you can view it in the messages page.',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Social',
                    style: TextStyle(fontSize: 18),
                  )),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Professional',
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          );
        });
  }
}
