import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'socialPage.dart';
import 'profPage.dart';

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

  // getPermission() async {
  //   final GeolocationResult result =
  //       await Geolocation.requestLocationPermission(const LocationPermission(
  //           android: LocationPermissionAndroid.fine,
  //           ios: LocationPermissionIOS.always));
  //   return result;
  // }
  // getLocation() {
  //   return getPermission().then((result) async {
  //     if (result.isSuccessful) {
  //       final coords =
  //           await Geolocation.currentLocation(accuracy: LocationAccuracy.best);
  //       return coords;
  //     }
  //   });
  // }
  // buildMap() {
  //   getLocation().then((response) {
  //     response.listen((value) {
  //       if (value.isSuccessful) {
  //         controller.move(
  //             new LatLng(value.location.latitude, value.location.longitude),
  //             8.0);
  //       }
  //     });
  //   });
  // }
  //   getLat() {
  //   getLocation().then((response) {
  //     response.listen((value) {
  //       if (value.isSuccessful) {
  //         // controller.move(
  //         //     new LatLng(value.location.latitude, value.location.longitude),
  //         //     8.0);
  //         return value.location.latitude;
  //       }
  //     });
  //   });
  // }
  //     getLong() {
  //   getLocation().then((response) {
  //     response.listen((value) {
  //       if (value.isSuccessful) {
  //         // controller.move(
  //         //     new LatLng(value.location.latitude, value.location.longitude),
  //         //     8.0);
  //         return value.location.longitude;
  //       }
  //     });
  //   });
  // }
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _controller = RubberAnimationController(
        vsync: this,
        initialValue: 0.5,
        lowerBoundValue: AnimationControllerValue(percentage: 0.35),
        duration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   title: Text("Home screen",style: TextStyle(color: Colors.white),),
      // ),
      body: Container(
        child: RubberBottomSheet(
          scrollController: _scrollController,
          lowerLayer: _getLowerLayer(),
          header: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(7),
                ),
                Container(
                  width: 50,
                  height: 7,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    ),
                    FloatingActionButton(
                      onPressed: (){ Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SocialPage()),
                        );},
                      elevation: 0,
                      heroTag: 'btn1',
                      backgroundColor: Colors.purple,
                      child: Icon(Entypo.drink),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius:  BorderRadius.only(
                      //     topRight: Radius.circular(25),
                      //     bottomRight: Radius.circular(25),
                      //   )

                      //   ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(250, 0, 0, 0),
                    ),
                    FloatingActionButton(
                      onPressed: (){ Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfPage()),
                        );},
                      elevation: 0,
                      heroTag: 'btn2',
                      backgroundColor: Colors.blueAccent[700],
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
                Padding(padding: EdgeInsets.fromLTRB(0, 25, 0, 0)),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(95, 0, 0, 0),
                    ),
                    Icon(Icons.people, color: Colors.black),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    ),
                    Text(
                      "People around you",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(51.2, 0, 0, 0),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                ),
                Container(
                  //color: Colors.white,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    child: TextField(
                      decoration: new InputDecoration(
                          icon: Icon(Icons.search),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: 'Search here'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          headerHeight: 211,
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
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
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
          padding: EdgeInsets.fromLTRB(0, 40, 20, 0),
          child: Align(
              alignment: Alignment.topRight,
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
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text("Mechatronics Engineering, 2023"),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 20,
                        width: 70,
                        padding: EdgeInsets.fromLTRB(10, 4.5, 0, 0),
                        child: Text("Badminton",
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      ),
                      Container(
                        height: 20,
                        width: 50,
                        padding: EdgeInsets.fromLTRB(10, 4.5, 0, 0),
                        child: Text("Flutter",
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent[700],
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
