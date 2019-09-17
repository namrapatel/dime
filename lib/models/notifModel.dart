import 'package:Dime/chat.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:Dime/homePage.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Dime/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class LikeNotif extends StatefulWidget {
  final String id,name,photo,major,university,gradYear,bio,relationshipStatus,type,timestamp;
  final bool liked;
  const LikeNotif({this.id,this.name,this.photo,this.major,this.university,this.gradYear,this.bio,this.relationshipStatus,
    this.type,this.timestamp,this.liked});

  @override
  _LikeNotifState createState() => _LikeNotifState(id: id,name: name,photo: photo,major: major,university: university,gradYear: gradYear,bio: bio,relationshipStatus: relationshipStatus,type: type,timestamp: timestamp,liked: liked);
}

class _LikeNotifState extends State<LikeNotif> {
  String id,name,photo,major,university,gradYear,bio,relationshipStatus,type,timestamp;
  bool liked;
  _LikeNotifState({this.id,this.name,this.photo,this.major,this.university,this.gradYear,this.bio,this.relationshipStatus,
  this.type,this.timestamp,this.liked});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenH(8.0)),
      child: ListTile(
        // leading: Container(
        //     width: MediaQuery.of(context).size.width / 12,
        //     height: MediaQuery.of(context).size.height / 25,
        //     decoration: BoxDecoration(
        //       //Depending on if its social or professional like - it should be a different color, I've put the professional color for now
        //         color: Color(0xFF096664),
        //         borderRadius: BorderRadius.all(Radius.circular(30))),
        //     child: Icon(
        //       AntDesign.bulb1,
        //       color: Colors.white,
        //       size: screenH(20),
        //     )),
        leading: Stack(
          children: <Widget>[
            liked==false?
            CircleAvatar(
          backgroundColor: type=="social"?Color(0xFF8803fc):Color(0xFF096664),
          radius: screenH(30),
          child: Icon(
              AntDesign.bulb1,
              color: Colors.white,
              size: screenH(25),
            ),
        ):
        CircleAvatar(
    radius: screenH(30),
   backgroundImage: CachedNetworkImageProvider(photo)
    ),
            type == "social"? relationshipStatus!=null?
        Positioned(
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
                         relationshipStatus,
                          style: TextStyle(fontSize: screenH(12.1)),
                        ),
                      ],
                    ),
                  ),
        ):SizedBox(width: 0.0,)
        :SizedBox(width: 0.0,)
          ],
        ),
        title: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 1.95,
              child: AutoSizeText(
                liked==false?
                "Someone just liked you!":name+ " just liked you!",
                style: TextStyle(fontWeight: FontWeight.bold),
                minFontSize: 15,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              bio!=null?bio:""
              ,
              style: TextStyle(
                color: Color(0xFF1458EA),
              ),
            ),
            Text(university!=null?university:"" ),
            major != null && gradYear != null
                ?  Text(major + ", " + gradYear)

                : Text(major != null ? major : ""),

            Text(timestamp!=null?timestamp:"", style: TextStyle(fontSize: 11)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.grey[100],
              ),
              child: liked==false?IconButton(
                icon: Icon(
                  EvilIcons.like,
                  size: screenH(35),
                ),
                color: Color(0xFF1458EA),
                onPressed: () {
                  setState(() {
                    liked=true;
                    List<String> myId=[];
                    myId.add(currentUserModel.uid);
                    Firestore.instance.collection('users').document(currentUserModel.uid).collection('likes').document(id).updateData({
                      'liked':true
                    });
                    Firestore.instance.collection('users').document(id).updateData({
                      'likedBy':FieldValue.arrayUnion(myId)
                    });
                    Firestore.instance.collection('users').document(id).collection('likes').document(currentUserModel.uid).setData({
                      'unread':true,
                      'timestamp': Timestamp.now(),
                      'liked':true,
                      'likeType':type
                    },merge: true);
                  });
                },
              ):IconButton(
                icon: Icon(
                  Feather.message_circle,
                  size: screenH(27),
                ),
                color: Color(0xFF1458EA),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => Chat(
                            fromUserId: currentUserModel.uid,
                            toUserId: id,
                          )));
                },
              )
            )
          ],
        ),
      ),
    );
  }
}
