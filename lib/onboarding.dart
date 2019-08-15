import 'package:Dime/homePage.dart';
import 'package:Dime/profile.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// App widget class

class onBoarding extends StatelessWidget {
  //making list of pages needed to pass in IntroViewsFlutter constructor.
  final pages = [
    PageViewModel(
        pageColor: const Color(0xFF1458EA),
        // iconImageAssetPath: 'assets/air-hostess.png',
        bubble: Image.asset('assets/dimelogo.png'),
        body: SizedBox(),
        title: SizedBox(
          height: 30.0,
        ),
        textStyle: TextStyle(fontFamily: 'futura', color: Colors.white),
        mainImage: Column(
          children: <Widget>[
            Image.asset(
              'assets/friendsDrawing.png',
              height: 245.0,
              width: 245.0,
              alignment: Alignment.center,
            ),
            Text('In the moment.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'futura')),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'A tool to connect you with those around you and stay up to date with the social and professional scene at your university.',
                style: TextStyle(
                    fontFamily: 'futura', color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )),
    PageViewModel(
        pageColor: const Color(0xFF8803fc),
        // iconImageAssetPath: 'assets/air-hostess.png',
        bubble: Image.asset('assets/dimelogo.png'),
        body: SizedBox(),
        title: SizedBox(
          height: 30.0,
        ),
        textStyle: TextStyle(fontFamily: 'futura', color: Colors.white),
        mainImage: Column(
          children: <Widget>[
            SizedBox(
              height: 0.0,
            ),
            Image.asset(
              'assets/socialAndProfCard.png',
              height: 245.0,
              width: 245.0,
              alignment: Alignment.center,
            ),
            Text('Your cards.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'futura')),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'All your online media handles and a small glimpse into who you are are easily accessible through your personal cards.',
                style: TextStyle(
                    fontFamily: 'futura', color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )),
    PageViewModel(
        pageColor: Colors.white,
        // iconImageAssetPath: 'assets/air-hostess.png',
        bubble: Image.asset('assets/dimelogo.png'),
        body: SizedBox(),
        title: SizedBox(
          height: 30.0,
        ),
        textStyle: TextStyle(fontFamily: 'futura', color: Colors.black),
        mainImage: Column(
          children: <Widget>[
            SizedBox(
              height: 0.0,
            ),
            Image.asset(
              'assets/feeds.png',
              height: 245.0,
              width: 245.0,
              alignment: Alignment.center,
            ),
            Text('Campus Feeds',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'futura')),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'All your online profiles and a small glipse of who you are easily accessible through your cards.',
                style: TextStyle(
                    fontFamily: 'futura', color: Colors.black, fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )),
    PageViewModel(
        pageColor: const Color(0xFF063F3E),
        // iconImageAssetPath: 'assets/air-hostess.png',
        bubble: Image.asset('assets/dimelogo.png'),
        body: SizedBox(),
        title: SizedBox(
          height: 30.0,
        ),
        textStyle: TextStyle(fontFamily: 'futura', color: Colors.black),
        mainImage: Column(
          children: <Widget>[
            Image.asset(
              'assets/pplNearbyUI.png',
              height: 245.0,
              width: 245.0,
              alignment: Alignment.center,
            ),
            Text("Look who's around!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'futura')),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'With our location technology you’ll be able to view the cards of those around you and connect with them instantly. ',
                style: TextStyle(
                    fontFamily: 'futura', color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )),
    PageViewModel(
        pageColor: const Color(0xFF1458EA),
        // iconImageAssetPath: 'assets/air-hostess.png',
        bubble: Image.asset('assets/dimelogo.png'),
        body: SizedBox(),
        title: SizedBox(
          height: 30.0,
        ),
        textStyle: TextStyle(fontFamily: 'futura', color: Colors.black),
        mainImage: Column(
          children: <Widget>[
            SizedBox(
              height: 0.0,
            ),
            Image.asset(
              'assets/improvingDrawing.png',
              height: 245.0,
              width: 245.0,
              alignment: Alignment.center,
            ),
            Text("There's more to come!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'futura')),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "We're constantly working to make your experience on our platform as seamless as possible. Stay tuned for new features!",
                style: TextStyle(
                    fontFamily: 'futura', color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )),
  ];

  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IntroViews Flutter', //title of app
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), //ThemeData
      home: Builder(
        builder: (context) => IntroViewsFlutter(
              pages,
              onTapDoneButton: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ), //MaterialPageRoute
                );
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
