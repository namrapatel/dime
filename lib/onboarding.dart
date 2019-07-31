import 'package:Dime/homePage.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:fancy_on_boarding/page_model.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class onBoarding extends StatefulWidget {
  @override
  _onBoardingState createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  BuildContext context;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('in onboarding with email below');
    print(currentUserModel.email);
  }

  final pageList = [
    //Slogan Screen, Cards Screen, People around you screen, Events Screen, Thank you/Always improving
    PageModel(
        color: Color(0xFFECE9E4),
        heroAssetPath: 'assets/friendsDrawing.png',
        title: Text('In the moment.',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.black,
              fontSize: 34.0,
            )),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
              'A tool to connect you with those right next to you and help you disocver parties and events happening right now!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              )),
        ),
        iconAssetPath: 'assets/dimelogo1.png'),
    PageModel(
        color: const Color(0xFF8803fc),
        heroAssetPath: "assets/socialAndProfCard.png",
        title: Text('Your cards.',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
              'All your online profiles and a small glipse of who you are easily accessible through your cards.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
        ),
        iconAssetPath: 'assets/dimelogo1.png'),
    PageModel(
        color: Colors.white,
        heroAssetPath: 'assets/pplNearbyUI.png',
        title: Column(
          children: <Widget>[
            Text("Look who's around.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  fontSize: 34.0,
                )),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
              "With the power of our location technology, you'll be able to view the cards of those around you, figure out why they're there and connect with them instantly.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              )),
        ),
        iconAssetPath: 'assets/dimelogo1.png'),
    PageModel(
      color: Color(0xFF1976d2),
      heroAssetPath: 'assets/mapsUI.png',
      title: Text("What's happening?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
            "Look out for those hotspots! Discover what hot events, parties and different activities are going on around you right now.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
      ),
      iconAssetPath: 'assets/dimelogo1.png',
    ),
    PageModel(
      color: Colors.black,
      heroAssetPath: 'assets/improvingDrawing.png',
      title: Text("There's more to come!",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFFECE9E4),
            fontSize: 34.0,
          )),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
                "We're constantly working to make your experience on our platoform as seamless as possible. Stay tuned for new feaures!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                )),
          ),
          SizedBox(
            height: 80.0,
          ),
          Container(
            width: 200,
            height: 50,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              elevation: 5,
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => ScrollPage(),
                //     ));
              },
              backgroundColor: Color(0xFFECE9E4),
              child: Text(
                "Get started!",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      iconAssetPath: 'assets/dimelogo1.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FancyOnBoarding(
        pageList: pageList,
        mainPageRoute: '/mainPage',
      ),
    );
  }
}
