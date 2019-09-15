import 'package:Dime/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:page_transition/page_transition.dart';
import 'login.dart';
import 'package:flutter/cupertino.dart';
import 'chat.dart';
import 'userCard.dart';
import 'homePage.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar.dart';

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
    return Firestore.instance
        .collection('users')
        .orderBy('university', descending: true)
        .getDocuments();
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
        if (user['userData']['displayName']
            .toLowerCase()
            .startsWith(standardValue)) {
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
        if (user['userData']['displayName']
            .toLowerCase()
            .startsWith(standardValue)) {
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
          if (docs.documents[i]['blocked${currentUserModel.uid}'] == true) {
            print('blocked user');
          } else {
            var userMap = new Map();
            userMap['userData'] = docs.documents[i].data;
            userMap['userId'] = docs.documents[i].documentID;
//          tempSet.add(docs.documents[i].data);
            tempSet.add(userMap);
            print(docs.documents[i].documentID);
          }
          setState(() {
            tempSearchStore = tempSet;
            allUsers = tempSet;
          });
        }
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
      padding: EdgeInsets.all(0.0),
      physics: const NeverScrollableScrollPhysics(),
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
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 17, 0, 0, 100),
                ),
                Text(
                  "Explore",
                  style: TextStyle(
                    fontSize: screenF(48),
                  ),
                ),
                      IconButton(
                        icon: Icon(
                          Icons.info_outline,
                          color: Color(0xFF1458EA),
                        ),
                        onPressed: () {
                          Flushbar(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            borderRadius: 15,
                            messageText: Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Use the explore feed to find people you're interested in. You can still send an anonymous like, but they won't know if it's for social or professional reasons.",
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                            backgroundColor: Colors.white,
                            flushbarPosition: FlushbarPosition.TOP,
                            icon: Padding(
                              padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                              child: Icon(
                                Icons.info_outline,
                                size: 28.0,
                                color: Color(0xFF1458EA),
                              ),
                            ),
                            duration: Duration(seconds: 7),
                          )..show(context);
                        },
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
                      textCapitalization: TextCapitalization.sentences,
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
                          hintText: 'Search for people...'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.48,
              child: ListView.builder(
                cacheExtent: 5000.0,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                itemBuilder: (context, index) {
//                  tempSearchStore.map((element) {
                  return _buildTile(tempSearchStore[index]);
//                  });
//                  DocumentSnapshot doc = snapshots.data[index];
//                  print(
//                      'doc with id ${doc.documentID} distance ${doc.data['distance']}');
//                  GeoPoint point = doc.data['position']['geopoint'];
//                  if (doc.data['blocked${currentUserModel.uid}'] ==
//                      true) {
//                    return UserTile(blocked: true);
//                  } else {
//                    return UserTile(
//                        relationshipStatus:
//                        doc.data['relationshipStatus'],
//                        contactName: doc.data['displayName'],
//                        personImage: doc.data['photoUrl'],
//                        uid: doc.documentID,
//                        major: doc.data['major'],
//                        profInterests: doc.data['profInterests'],
//                        socialInterests:
//                        doc.data['socialInterests'],
//                        university: doc.data['university'],
//                        gradYear: doc.data['gradYear'],
//                        bio: doc.data['bio']);
//                  }
                },
                itemCount: tempSearchStore.length,
//                children: tempSearchStore.map((element) {
//                  return _buildTile(element);
//                }).toList(),
              ),
            ),
          ],
        )
      ],
    ));
  }

  Widget _buildTile(data) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => UserCard(
                      userId: data['userId'],
                      userName: data['userData']['displayName'],
                    )));
      },
      leading: Stack(
        children: <Widget>[
//          CircleAvatar(
//            radius: screenH(30),
//            backgroundImage: NetworkImage(data['userData']['photoUrl']),
//          ),
          CircleAvatar(
              radius: screenH(30),
              backgroundImage:
                  CachedNetworkImageProvider(data['userData']['photoUrl'])),
          data['userData']['relationshipStatus'] != null
              ? Positioned(
                  left: MediaQuery.of(context).size.width / 10000000,
                  top: MediaQuery.of(context).size.height / 23.5,
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.height / 80,
                    backgroundColor: Colors.white,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 600,
                        ),
                        Text(
                          data['userData']['relationshipStatus'],
                          style: TextStyle(fontSize: screenH(12.1)),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  width: 0.0,
                )
        ],
      ),
      title: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 3.3,
            child: AutoSizeText(
              data['userData']['displayName'],
              // style: TextStyle(color: Color(0xFF1458EA), fontSize: 13),
              minFontSize: 15,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),

      // Text(data['userData']['displayName']),
      subtitle: Text(
          data['userData']['major'] != null ? data['userData']['major'] : ""),
//      trailing: (currentUserModel.bio!=null&&currentUserModel.university!=null&&currentUserModel.major!=null&&currentUserModel.gradYear!=null&&(currentUserModel.displayName!="New User"&&currentUserModel.displayName!="No Display Name"))?Row(
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          ((data['userData']['major'] != null&&data['userData']['gradYear'] != null&&data['userData']['university'] != null&&
//      data['userData']['bio'] != null&&(data['userData']['displayName'] != "New User"&&data['userData']['displayName'] != "No Display Name")))?
//                    Container(
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                          color: Colors.grey[100],
//                        ),
////                      (data['userData']['likedBy']!=null&&!data['userData']['likedBy'].contains(currentUserModel.uid))?Colors.lightBlueAccent:Colors.grey[100],
//                        child: IconButton(
//                          icon: Icon(
//                            EvilIcons.like,
//                            size: screenH(35),
//                            color: Color(0xFF1458EA),
//                          ),
//
//                          color: Colors.black,
//                          onPressed: () {
//                            if((data['userData']['likedBy']!=null&&!data['userData']['likedBy'].contains(currentUserModel.uid))||data['userData']['likedBy']==null) {
//                              setState(() {
//
//                                List<String> myId=[];
//                                myId.add(currentUserModel.uid);
//                                Firestore.instance.collection('users').document(data['userId']).updateData({
//                                  'likedBy':FieldValue.arrayUnion(myId),
//
//                                });
//
//                                Firestore.instance.collection('users').document(data['userId']).collection('likes').document(currentUserModel.uid).setData({
////                              'likerName':currentUserModel.displayName,
////                              'likerPhoto':currentUserModel.photoUrl,
////                              'likerBio':currentUserModel.bio,
////                              'likerUni':currentUserModel.university,
////                              'likerMajor':currentUserModel.major,
////                              'likerGradYear':currentUserModel.gradYear,
////                              'likerRelationshipStatus':currentUserModel.relationshipStatus,
//                                  'unread':true,
//                                  'timestamp': Timestamp.now(),
//                                  'liked':false,
//                                  'likeType':'social'
//                                });
//                              });
//                            }
//                          },
//                        ),
//                      ):SizedBox(width: 0.0,)
//        ],
//      ):SizedBox(width: 0.0)
    );
  }
}
