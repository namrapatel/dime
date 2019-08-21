import 'package:Dime/homePage.dart';
import 'package:Dime/main.dart';
import 'package:Dime/profile.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;

class onBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    return Scaffold(
      //title of app

      body: Builder(
        builder: (context) => IntroViewsFlutter(
          [
            PageViewModel(
                pageColor: const Color(0xFF1458EA),
                // iconImageAssetPath: 'assets/air-hostess.png',
                bubble: Image.asset('assets/Dime3Colors.png'),
                body: SizedBox(),
                title: SizedBox(
                  height: screenH(30.0),
                ),
                textStyle: TextStyle(fontFamily: 'futura', color: Colors.white),
                mainImage: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/friendsDrawing.png',
                      height: screenH(245.0),
                      width: screenW(245.0),
                      alignment: Alignment.center,
                    ),
                    Text('People around you',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenF(36.0),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'futura')),
                    SizedBox(
                      height: screenH(20.0),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenH(8.0)),
                      child: Text(
                        'Find people around your location, read their interests, and chat or connect with their medias!',
                        style: TextStyle(
                            fontFamily: 'futura',
                            color: Colors.white,
                            fontSize: screenF(18.0)),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )),
            PageViewModel(
                pageColor: const Color(0xFF8803fc),
                // iconImageAssetPath: 'assets/air-hostess.png',
                bubble: Image.asset('assets/Dime3Colors.png'),
                body: SizedBox(),
                title: SizedBox(
                  height: screenH(30.0),
                ),
                textStyle: TextStyle(fontFamily: 'futura', color: Colors.white),
                mainImage: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/socialAndProfCard.png',
                      height: screenH(245.0),
                      width: screenW(245.0),
                      alignment: Alignment.center,
                    ),
                    Text('Clickable cards.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'futura')),
                    SizedBox(
                      height: screenW(20.0),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenH(8.0)),
                      child: Text(
                        'All your online media handles and a small glimpse into who you are are easily accessible through your personal cards.',
                        style: TextStyle(
                            fontFamily: 'futura',
                            color: Colors.white,
                            fontSize: screenF(18.0)),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )),
            PageViewModel(
                pageColor: Colors.grey[200],
                // iconImageAssetPath: 'assets/air-hostess.png',
                bubble: Image.asset('assets/Dime3Colors.png'),
                body: SizedBox(),
                title: SizedBox(
                  height: screenH(30.0),
                ),
                textStyle: TextStyle(fontFamily: 'futura', color: Colors.black),
                mainImage: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/feeds.png',
                      height: screenH(245.0),
                      width: screenW(245.0),
                      alignment: Alignment.center,
                    ),
                    Text('Campus Feeds',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: screenF(36.0),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'futura')),
                    SizedBox(
                      height: screenH(20.0),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenH(8.0)),
                      child: Text(
                        'A feed to mess around with your university, and a feed to get stuff done.',
                        style: TextStyle(
                            fontFamily: 'futura',
                            color: Colors.black,
                            fontSize: screenF(18.0)),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )),
            PageViewModel(
                pageColor: const Color(0xFF063F3E),
                // iconImageAssetPath: 'assets/air-hostess.png',
                bubble: Image.asset('assets/Dime3Colors.png'),
                body: SizedBox(),
                title: SizedBox(
                  height: screenH(30.0),
                ),
                textStyle: TextStyle(fontFamily: 'futura', color: Colors.black),
                mainImage: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/pplNearbyUI.png',
                      height: screenH(245.0),
                      width: screenW(245.0),
                      alignment: Alignment.center,
                    ),
                    Text("University directory.",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenF(36.0),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'futura')),
                    SizedBox(
                      height: screenH(20.0),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenH(8.0)),
                      child: Text(
                        'A full list of the people who go to your university, put faces to names.',
                        style: TextStyle(
                            fontFamily: 'futura',
                            color: Colors.white,
                            fontSize: screenF(18.0)),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )),
            PageViewModel(
                pageColor: const Color(0xFF1458EA),
                // iconImageAssetPath: 'assets/air-hostess.png',
                bubble: Image.asset('assets/Dime3Colors.png'),
                body: SizedBox(),
                title: SizedBox(
                  height: screenH(30.0),
                ),
                textStyle: TextStyle(fontFamily: 'futura', color: Colors.black),
                mainImage: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/improvingDrawing.png',
                      height: screenH(245.0),
                      width: screenW(245.0),
                      alignment: Alignment.center,
                    ),
                    Text("There's more to come!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenF(36.0),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'futura')),
                    SizedBox(
                      height: screenH(20.0),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenH(8.0)),
                      child: Text(
                        "We're constantly working to make your experience on our platform as seamless as possible. Stay tuned for new features!",
                        style: TextStyle(
                            fontFamily: 'futura',
                            color: Colors.white,
                            fontSize: screenF(18.0)),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )),
          ],
          showSkipButton: false,
          onTapDoneButton: () {
            Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => Profile()));
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ), //IntroViewsFlutter
      ), //Builder
    ); //Material App
  }
}
