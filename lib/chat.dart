import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';



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


  getUserProfile() async{
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
   callback()  {
    if (messageController.text.length > 0) {
      _firestore.collection('users').document(widget.fromUserId).collection('messages').document(widget.toUserId).collection('texts').add({
        'text': messageController.text,
        'from': widget.fromUserId,

        'timestamp': Timestamp.now(),
      });
      _firestore.collection('users').document(widget.toUserId).collection('messages').document(widget.fromUserId).collection('texts').add({
        'text': messageController.text,
        'from': widget.fromUserId,

        'timestamp': Timestamp.now(),

      });
      _firestore.collection('chatMessages').add({
        'text': messageController.text,
        'from': widget.fromUserId,
        'to':widget.toUserId,
        'receiverPhoto':currentUserModel.photoUrl,
        'receiverName':currentUserModel.displayName,
        'timestamp': Timestamp.now(),

      });
//      await _firestore.collection('users').document(widget.toUserId).collection('messages').add({
//        'text': messageController.text,
//        'from': widget.fromUserId,
//      });
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
        backgroundColor: Color(0xFFECE9E4),
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          iconSize: 20,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: <Widget>[
            toUserPhoto!=null?
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(toUserPhoto),
            ):CircularProgressIndicator(),
            SizedBox(width: MediaQuery.of(context).size.width/30,),
            toUserName!=null?Text(toUserName, style: TextStyle(color: Colors.black),):CircularProgressIndicator(),
          ],
        ),
      ),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('users').document(widget.fromUserId).collection('messages').document(widget.toUserId).collection('texts').orderBy('timestamp', descending:true).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());

                    List<DocumentSnapshot> docs = snapshot.data.documents;

                    List<Widget> messages = docs
                        .map((doc) => Message(
                        from: doc.data['from'],
                        text: doc.data['text'],
                        me: widget.fromUserId == doc.data['from']))
                        .toList();
                    return ListView(
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
                height: MediaQuery.of(context).size.height/55,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width/50,
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
                          onTap: (){
                            scrollController.animateTo(0.0,
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
                              hintText: 'Write a message'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/15,
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
                height: MediaQuery.of(context).size.height/55,
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
    return  Container(
        width: 40,
        height: 40,
        child: FloatingActionButton(
            elevation: 5,
            backgroundColor: Colors.black,
            heroTag: 'fabb4',
            child: Icon(Icons.send, color: Color(0xFFECE9E4), size: 20,),
            onPressed: callback
        )
    );
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

  final bool me;

  const Message({Key key, this.from, this.text, this.me}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: me?
      EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/3.5, MediaQuery.of(context).size.height/50, MediaQuery.of(context).size.width/50, 0)
          :
      EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/50, MediaQuery.of(context).size.height/50, MediaQuery.of(context).size.width/3.5, 0)
      ,

      child: Column(
        crossAxisAlignment:
        me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   from,
          // ),
          Material(
            color: me ? Color(0xFFECE9E4) : Color(0xFFF3F4F5),
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
                  color: me ? Colors.black : Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}