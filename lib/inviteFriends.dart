import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;

class InviteFriends extends StatefulWidget {
  @override
  _InviteFriendsState createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {

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
      //backgroundColor: Color(0xFFECE9E4),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: screenH(50),
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: screenW(10),
              ),
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context); 
                },
              ),
            ],
          ),
          SizedBox(
            height: screenH(50),
          ),
          Center(
            child: Text("Invite Friends",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          ),
          FlatButton(
            child: Text("Share Dime"),
            onPressed: (){
              Share.share('Check out Dime! Download at this link: https://baller.com',
              subject: "Get Dime!",
              
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
            child: Center(
              child: Text(
                "Invite one or more friends to join the Dime community and we'll give you this month's password.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            height: screenH(30),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.08,
            height: MediaQuery.of(context).size.height / 900,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: screenH(30),
          ),
          Container(
              width: screenW(378),
              child: ListTile(
                onTap: () {
                  _launchURLMessenger();
                },
                title: Text(
                  "Messenger",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Invite friends from Facebook Messenger"),
                leading: Icon(
                  MaterialCommunityIcons.facebook_messenger,
                  color: Color(0xFF0078FF),
                  size: 35,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Colors.grey[500],
                ),
              )),
          Container(
              width: screenW(378),
              child: ListTile(
                onTap: () {
                  _launchURLTwitter();
                },
                title: Text(
                  "Twitter",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Invite friends from Twitter"),
                leading: Icon(
                  Entypo.twitter_with_circle,
                  color: Color(0xFF00acee),
                  size: 35,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Colors.grey[500],
                ),
              )),
          Container(
              width: screenW(378),
              child: ListTile(
                onTap: () {
                  _launchURLLinkedin();
                },
                title: Text(
                  "Linkedin",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Invite friends from Linkedin"),
                leading: Icon(
                  MaterialCommunityIcons.linkedin,
                  color: Color(0xFF0077B5),
                  size: 35,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Colors.grey[500],
                ),
              )),
          Container(
              width: screenW(378),
              child: ListTile(
                onTap: () {
                  _textMe();
                },
                title: Text(
                  "Messages",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Invite friends from Messages"),
                leading: Icon(
                  Ionicons.ios_text,
                  color: Color(0xFF53d769),
                  size: 35,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Colors.grey[500],
                ),
              )),
        ],
      ),
    );
  }
}
