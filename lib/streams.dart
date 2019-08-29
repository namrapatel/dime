import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:flutter/cupertino.dart';
import 'homePage.dart';
import 'profPage.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;

class ProfStreams extends StatefulWidget {
  @override
  _ProfStreamsState createState() => _ProfStreamsState();
}

class _ProfStreamsState extends State<ProfStreams> {
  _launchURLMessenger() async {
    const url = 'https://www.messenger.com/new';
    launch(url);
  }

  _launchURLTwitter() async {
    const url = 'https://twitter.com/messages/compose';
    launch(url);
  }

  _launchURLLinkedin() async {
    const url = 'https://www.linkedin.com/messaging/compose';
    launch(url);
  }

  _textMe() async {
    // Android
    const uri = 'sms: ';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      const uri = 'sms:';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

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
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ProfPage(
                            stream: '@general',
                          )));
            },
          ),
          title: Text(
            "Streams",
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 1.1,
              child: _myListView(context),
            )
          ],
        ));
  }
}

Widget _myListView(BuildContext context) {
  final titles = [
    'tech_community',
    'business',
  ];

  final icons = [
    MaterialCommunityIcons.brain,
    MaterialCommunityIcons.account_tie,
  ];

  return ListView.builder(
    physics: BouncingScrollPhysics(),
    itemCount: titles.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ListTile(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => ProfPage()));
              },
              contentPadding: EdgeInsets.all(10),
              leading: Icon(
                icons[index],
                color: Colors.black,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.people),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "203",
                      style: TextStyle(color: Colors.black),
                    ),
                    FlatButton(
                      child: Text("Join Stream"),
                      onPressed: () {
                        //increase the counter lol
                        //just dont show the button if they are joined
                        //evenually this will be notifs lol
                      },
                    )
                  ],
                ),
              ),
              title: Text(
                '@' + titles[index],
                style: TextStyle(),
              )),
        ),
      );
    },
  );
}
