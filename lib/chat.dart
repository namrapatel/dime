import 'package:Dime/chatList.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login.dart';
import 'package:flutter/cupertino.dart';
import 'package:Dime/homePage.dart';
import 'userCard.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:auto_size_text/auto_size_text.dart';

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;

class Chat extends StatefulWidget {
  static const String id = "CHAT";
//  final FirebaseUser fromUser;
  final String fromUserId;
  final String toUserId;

  const Chat({Key key, this.fromUserId, this.toUserId}) : super(key: key);
  _ChatState createState() {
    return _ChatState();
  }
}

class _ChatState extends State<Chat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  String toUserPhoto;
  String toUserName;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  FocusNode _focus = new FocusNode();

  getUserProfile() async {
    QuerySnapshot query = await Firestore.instance
        .collection('users')
        .document(widget.toUserId)
        .collection('profcard')
        .getDocuments();
    for (var doc in query.documents) {
      setState(() {
        toUserName = doc['displayName'];
        toUserPhoto = doc['photoUrl'];
      });
    }
  }

  callback() {
    if (messageController.text.length > 0) {
      _firestore
          .collection('users')
          .document(widget.fromUserId)
          .collection('messages')
          .document(widget.toUserId)
          .setData({'timestamp': Timestamp.now()}, merge: true);
      _firestore
          .collection('users')
          .document(widget.fromUserId)
          .collection('messages')
          .document(widget.toUserId)
          .collection('texts')
          .add({
        'text': messageController.text,
        'from': widget.fromUserId,
        'timestamp': Timestamp.now(),
      });
      _firestore
          .collection('users')
          .document(widget.toUserId)
          .collection('messages')
          .document(widget.fromUserId)
          .setData({'timestamp': Timestamp.now()}, merge: true);
      if (widget.toUserId != widget.fromUserId) {
        _firestore
            .collection('users')
            .document(widget.toUserId)
            .collection('messages')
            .document(widget.fromUserId)
            .collection('texts')
            .add({
          'text': messageController.text,
          'from': widget.fromUserId,
          'timestamp': Timestamp.now(),
        });
      }

      _firestore.collection('notifMessages').document().setData({
        'text': messageController.text,
        'from': widget.fromUserId,
        'to': widget.toUserId,
      });

      messageController.clear();
      scrollController.animateTo(scrollController.position.minScrollExtent,
          curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
    }
  }

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFECE9E4),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF1458EA),
        elevation: screenH(5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: <Widget>[
            toUserPhoto != null
                ? CircleAvatar(
                    radius: screenH(25),
                    backgroundImage: NetworkImage(toUserPhoto),
                  )
                : CircularProgressIndicator(),
            SizedBox(
              width: MediaQuery.of(context).size.width / 33,
            ),
            toUserName != null
                ? Container(
                    width: MediaQuery.of(context).size.width / 1.9,
                    child: AutoSizeText(
                      toUserName,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      minFontSize: 12,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : CircularProgressIndicator(),
            IconButton(
              icon: Icon(MaterialCommunityIcons.card_bulleted),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: UserCard(
                          userId: widget.toUserId,
                          userName: toUserName,
                        )));
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('users')
                  .document(widget.fromUserId)
                  .collection('messages')
                  .document(widget.toUserId)
                  .collection('texts')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());

                List<DocumentSnapshot> docs = snapshot.data.documents;

                List<Message> messages = [];
                for (var doc in docs) {
                  var storedDate = doc.data['timestamp'];
//
                  String elapsedTime = timeago.format(storedDate.toDate());
                  String timestamp = '$elapsedTime';
                  messages.add(Message(
                      from: doc.data['from'],
                      text: doc.data['text'],
                      me: widget.fromUserId == doc.data['from'],
                      timestamp: timestamp));
                }

                return ListView(
                  physics: BouncingScrollPhysics(),
                  reverse: true,
                  shrinkWrap: true,
                  controller: scrollController,
                  children: <Widget>[
                    ...messages,
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 55,
          ),
          Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width / 50,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 22,
                        vertical: MediaQuery.of(context).size.height / 72),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      onTap: () {
                        scrollController.animateTo(
                          0.0,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );
                      },
                      onSubmitted: (value) => callback(),
                      controller: messageController,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 30,
                              bottom: MediaQuery.of(context).size.height / 155,
                              top: MediaQuery.of(context).size.height / 155,
                              right: MediaQuery.of(context).size.width / 30),
                          hintText: 'Write a message',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 15,
                ),
                SendButton(
                  text: "Send",
                  callback: callback,
                )
              ],
            ),
            // child: Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: TextField(
            //         onSubmitted: (value) => callback(),
            //         decoration: InputDecoration(
            //           hintText: "Enter a Message ...",
            //           border: const OutlineInputBorder(),
            //         ),
            //         controller: messageController,
            //       ),
            //     ),
            //     SendButton(
            //       text: "Send",
            //       callback: callback,
            //     )
            //   ],
            // ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 55,
          )
        ],
      )),
    );
  }
}

class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const SendButton({Key key, this.text, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: screenW(44),
        height: screenH(44),
        child: FloatingActionButton(
            elevation: screenH(5),
            backgroundColor: Color(0xFF1458EA),
            heroTag: 'fabb4',
            child: Icon(Icons.send, color: Colors.white, size: 17),
            onPressed: callback));
    // FlatButton(
    //   color: Colors.orange,
    //   onPressed: callback,
    //   child: Text(text),
    // );
  }
}

class Message extends StatelessWidget {
  final String from;
  final String text;
  final String timestamp;

  final bool me;

  const Message({Key key, this.from, this.text, this.me, this.timestamp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: me
          ? EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width / 3.5,
              MediaQuery.of(context).size.height / 50,
              MediaQuery.of(context).size.width / 50,
              0)
          : EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width / 50,
              MediaQuery.of(context).size.height / 50,
              MediaQuery.of(context).size.width / 3.5,
              0),
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            color: me ? Color(0xFF1458EA) : Color(0xFFF3F4F5),
            borderRadius: me
                ? BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(0),
                    bottomLeft: Radius.circular(15),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(0),
                  ),
            elevation: 2,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Text(
                text,
                style: TextStyle(
                  color: me ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          Text(
            timestamp,
            style: TextStyle(color: Colors.grey, fontSize: 11),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
