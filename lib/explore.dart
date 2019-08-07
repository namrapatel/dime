import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;
var allUsers = [];

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  var queryResultSet = [];
  var tempSearchStore = [];
  bool alreadyBuilt = false;

  getAllUsers() {
    return Firestore.instance.collection('users').getDocuments();
  }

  initiateSearch(String value) {
    if (value.length == 0) {
      setState(() {
        tempSearchStore = allUsers;
        queryResultSet = allUsers;
      });
    }
    String standardValue = value.toLowerCase();

    if (value.length == 1) {
      setState(() {
        tempSearchStore = [];
        queryResultSet = [];
      });

      for (var user in allUsers) {
        if (user['displayName'].toLowerCase().startsWith(standardValue)) {
          setState(() {
            tempSearchStore.add(user);
            queryResultSet.add(user);
          });
        }
      }
    }
    if (value.length > 1) {
      setState(() {
        tempSearchStore = [];
        queryResultSet = [];
      });

      for (var user in allUsers) {
        if (user['displayName'].toLowerCase().startsWith(standardValue)) {
          print("IM HERE");
          setState(() {
            tempSearchStore.add(user);
            queryResultSet.add(user);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!alreadyBuilt) {
      getAllUsers().then((QuerySnapshot docs) {
        var tempSet = [];
        for (int i = 0; i < docs.documents.length; ++i) {
          tempSet.add(docs.documents[i].data);
        }
        setState(() {
          tempSearchStore = tempSet;
          allUsers = tempSet;
        });
      });

      alreadyBuilt = true;
    }

    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    return Scaffold(
        //backgroundColor: Color(0xFFECE9E4),
        body: ListView(
      //physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 28,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width / 50,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 45,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 17, 0, 0, 100),
                ),
                Text(
                  "Explore",
                  style: TextStyle(
                    fontSize: 48,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  //color: Colors.white,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 22,
                        vertical: MediaQuery.of(context).size.height / 72),
                    child: TextField(
                      onChanged: (val) {
                        initiateSearch(val);
                      },
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
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.fromLTRB(
                  0, 0, 0, MediaQuery.of(context).size.height / 10),
              child: ListView(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                children: tempSearchStore.map((element) {
                  return _buildTile(element);
                }).toList(),
              ),
            ),
          ],
        )
      ],
    ));
  }

  Widget _buildTile(data) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(data['photoUrl']),
      ),
      title: Text(data['displayName']),
      subtitle: Text(data['major'] != null ? data['major'] : ""),
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
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
