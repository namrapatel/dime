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
        color: const Color(0xFF678FB4),
        heroAssetPath: 'assets/dimelogo1.png',
        title: Text('Slogan Screen',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Padding(
            padding: EdgeInsets.all(20),
                  child: Text('All hotels and hostels are sorted by hospitality rating',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
        ),
        iconAssetPath: 'assets/dimelogo1.png'),
    PageModel(
        color: const Color(0xFF678FB4),
        heroAssetPath: 'assets/dimelogo1.png',
        title: Text('Cards Screen',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Padding(
            padding: EdgeInsets.all(20),
                  child: Text('All hotels and hostels are sorted by hospitality rating',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
        ),
        iconAssetPath: 'assets/dimelogo1.png'),
    PageModel(
        color: const Color(0xFF65B0B4),
        heroAssetPath: 'assets/dimelogo1.png',
        title: Text('People around you screen',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text(
            'We carefully verify all banks before adding them into the app',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconAssetPath: 'assets/dimelogo1.png'),
    PageModel(
      color: const Color(0xFF9B90BC),
      heroAssetPath: 'assets/dimelogo1.png',
      title: Text('Events Screen',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text('All local stores are categorized for your convenience',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      iconAssetPath: 'assets/dimelogo1.png',
    ),
    PageModel(
      color: const Color(0xFF9B90BC),
      heroAssetPath: 'assets/dimelogo1.png',
      title: Text('Always Improving screen',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: 
      Column(
        children: <Widget>[
          Text('All local stores are categorized for your convenience',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
              //ADD BUTTON WITH TO TAKE YOU TO HOMESCREEN
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




