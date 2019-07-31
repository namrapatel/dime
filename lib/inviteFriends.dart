import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;

class InviteFriends extends StatefulWidget {
  @override
  _InviteFriendsState createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(70, 10, 70, 0),
            child: Center(
              child: Text(
                "Invite your friends to the Dime community to spread the word and form the app ecosystem.",
                textAlign: TextAlign.center,
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
                onTap: () {},
                title: Text(
                  "Facebook",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Invite friends from Facebook"),
                leading: Icon(
                  Entypo.facebook_with_circle,
                  color: Color(0xFF3C5A99),
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
                onTap: () {},
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
                onTap: () {},
                title: Text(
                  "Instagram",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Invite friends from Instagram"),
                leading: Icon(
                  MaterialCommunityIcons.instagram,
                  color: Color(0xFF8803fc),
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
                onTap: () {},
                title: Text(
                  "Messages",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Invite friends from Messages"),
                leading: Icon(
                  Ionicons.ios_text,
                  color: Colors.black,
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
