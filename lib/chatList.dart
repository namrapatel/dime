import 'package:Dime/chat.dart';
import 'package:Dime/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:page_transition/page_transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;

class ChatList extends StatefulWidget {
  final String title = '';
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  BuildContext context;

  @override
  void initState() {
    super.initState();
  }

  Future<List<MessageTile>> getMessages() async {
    List<MessageTile> messageTiles = [];
    QuerySnapshot query = await Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .getDocuments();
    for (var document in query.documents) {
      String displayName;
      String photoUrl;
      String senderId = document.documentID;
      QuerySnapshot cardQuery = await Firestore.instance
          .collection('users')
          .document(senderId)
          .collection('profcard')
          .getDocuments();
      for (var card in cardQuery.documents) {
        displayName = card.data['displayName'];
        photoUrl = card.data['photoUrl'];
      }
      QuerySnapshot secondQuery = await Firestore.instance
          .collection('users')
          .document(currentUserModel.uid)
          .collection('messages')
          .document(senderId)
          .collection('texts')
          .orderBy('timestamp', descending: true)
          .getDocuments();
      DocumentSnapshot lastMessageDoc = secondQuery.documents.first;

      String message = lastMessageDoc.data['text'];
      print(message);
      if (message.length >= 40) {
        message = message.substring(0, 39);
      }
      if (lastMessageDoc.data['from'] == currentUserModel.uid) {
        message = "You: " + message;
      }
      var storedDate = lastMessageDoc.data['timestamp'];

      String elapsedTime = timeago.format(storedDate.toDate());
      String timestamp = '$elapsedTime';
      print(message);
      print(timestamp);
      print(photoUrl);
      print(displayName);
      print(currentUserModel.uid);
      print(senderId);
      messageTiles.add(MessageTile(
        text: message,
        timestamp: timestamp,
        senderPhoto: photoUrl,
        senderName: displayName,
        to: currentUserModel.uid,
        from: senderId,
      ));
    }
    print('messagetiles');

    print(messageTiles);
    return messageTiles;
  }

  Widget buildMessages() {
    return FutureBuilder(
        future: getMessages(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SpinKitThreeBounce(color: Colors.black, size: 25.0,);
          } else if (snapshot.data.length == 0) {
            return Center(
                child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: screenH(50.0)),
                    child: Container(
                        width: screenW(200),
                        child: Text(
                          "No Messages to Show",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenF(20),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  SizedBox(
                    height: screenH(20),
                  ),
                  Container(
                    height: screenH(300),
                    width: screenW(500),
                    child: Image(
                      image: AssetImage('assets/undraw_messages.png'),
                    ),
                  )
                ],
              ),
            ));
          } else {
            return Column(children: snapshot.data);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF1458EA),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.upToDown, child: ScrollPage()));
          },
        ),
        title: Text(
          "Messages",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(0.0),
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 35,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[buildMessages()],
                      )
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String to, from, text, timestamp, senderPhoto, senderName;

  MessageTile(
      {this.text,
      this.to,
      this.from,
      this.timestamp,
      this.senderPhoto,
      this.senderName});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.leftToRight,
                child: Chat(
                  fromUserId: to,
                  toUserId: from,
                )));
      },
      leading: CircleAvatar(
        backgroundImage: NetworkImage(senderPhoto),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(senderName),
          Text(
            timestamp,
            style: TextStyle(fontSize: 13, color: Colors.blueAccent[700]),
          )
        ],
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 17,
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(text.length >= 39 ? text.substring(0, 39) : text),
        ],
      ),
      //MAX OF 40 CHARACTERS BEFORE "..."
    );
  }
}