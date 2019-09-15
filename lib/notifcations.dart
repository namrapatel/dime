import 'package:Dime/chatList.dart';
import 'package:Dime/homePage.dart';
import 'package:Dime/models/notifModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'homePage.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
class NotifcationsScreen extends StatefulWidget {
  @override
  _NotifcationsScreenState createState() => _NotifcationsScreenState();
}

class _NotifcationsScreenState extends State<NotifcationsScreen> {

//  @override
//  void initState() {
//
//    super.initState();
//  }

  getNotifs() async{
    List<LikeNotif> userDocuments=[];
   QuerySnapshot querySnapshot= await Firestore.instance.collection('users').document(currentUserModel.uid).collection('likes').orderBy('timestamp',descending: true).getDocuments();
    for(var document in querySnapshot.documents){
      DocumentSnapshot doc= await Firestore.instance.collection('users').document(document.documentID).get();
      var storedDate = document.data['timestamp'];
      String elapsedTime = timeago.format(storedDate.toDate());
      String timestamp = '$elapsedTime';
      userDocuments.add(new LikeNotif(timestamp: timestamp,id: doc.documentID,name: doc['displayName'],
        major: doc['major'],university: doc['university'],bio: doc['bio'],gradYear: doc['gradYear'],liked: document['liked'],type: document['likeType'],relationshipStatus: doc['relationshipStatus'],photo: doc['photoUrl'],));
//      userDocuments.add(userDoc);

    }
    return userDocuments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height / 30,
        ),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.grey[100],
                  ),
                  child: IconButton(
                    onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => ChatList()));
                    },
                    icon: Icon(
                      Feather.message_circle,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 17, 0, 0, MediaQuery.of(context).size.height/7),
                ),
                Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: screenF(40),
                  ),
                ),
              ],
            ),
            Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 17, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  Text("329 Likes", style: TextStyle(fontSize: 18),),
                  SizedBox(width: MediaQuery.of(context).size.width/50,),
                  Text("•"),
                  SizedBox(width: MediaQuery.of(context).size.width/50,),
                  Text("12 Chats", style: TextStyle(fontSize: 18),),
                      IconButton(
                        icon: Icon(Icons.info_outline, color: Color(0xFF1458EA),),
                        onPressed: (){
              Flushbar(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                borderRadius: 15,
                messageText: Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "You have recieved 329 anonymous likes, and chosen to chat with 12 people!",
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
                duration: Duration(seconds: 5),
              )..show(context);
                        },
                      ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/50,),
          FutureBuilder(
          future: getNotifs(),
          builder:
          (context,  snapshots) {
          if (!snapshots.hasData) {
          return Container(
          alignment: FractionalOffset.center,
          child: CircularProgressIndicator());
          }else{

          return
          Container(
              height: MediaQuery.of(context).size.height / 1.3,
              child: (snapshots.data.length == 0)
                  ? Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Image.asset(
                      'assets/img/undraw_peoplearoundyou.png'),
                  Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height / 20),
                    child: Text(
                      "There's nobody around. \n Go get a walk in and find some new people!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ):ListView.builder(
                cacheExtent: 5000.0,
                physics: BouncingScrollPhysics(),
                padding:
                    EdgeInsets.only(left: screenW(5.0), right: screenW(5.0)),

                itemBuilder: (context, index) {
                  return Container(
                    child: Column(children: snapshots.data),
                  );
//                  DocumentSnapshot doc= snapshots.data[index];
////                  tempSearchStore.map((element) {
//
//
//                  var storedDate = doc.data['timestamp'];
//                  String elapsedTime = timeago.format(storedDate.toDate());
//                  String timestamp = '$elapsedTime';
//                  return LikeNotif(timestamp: timestamp,id: doc.documentID,name: doc['name'],
//                  major: doc['major'],university: doc['university'],bio: doc['bio'],gradYear: doc['gradYear'],liked: doc['liked'],type: doc['type'],relationshipStatus: doc['relationshipStatus'],);
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
                itemCount: snapshots.data.length,
//                children: tempSearchStore.map((element) {
//                  return _buildTile(element);
//                }).toList(),
              ),
            );}})
          ],
        ),
      ],
    ));
  }
}
