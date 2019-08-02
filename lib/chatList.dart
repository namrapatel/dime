import 'package:Dime/chat.dart';
import 'package:Dime/homePage.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:fancy_on_boarding/page_model.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:page_transition/page_transition.dart';

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

  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      //backgroundColor: Color(0xFFECE9E4),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                    Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/5,
                    //color: Color(0xFFECE9E4),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height/55,
                    left: MediaQuery.of(context).size.width/55,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    )
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height/10,
                    left: MediaQuery.of(context).size.width/22,
                    child: Text("Messages", style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),),
                  )
                ],
              ),

              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/1.2,
                  child: Column(
                    children: <Widget>[
                     
                           StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection('chatMessages').where('to',isEqualTo: currentUserModel.uid).orderBy('timestamp',descending: true).snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData ||
                                snapshot.data.documents.length == 0) {
                              return Center(
                                  child: Container(

                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: (50.0)),
                                          child: Container(
                                              width: (100),
                                              child: Text(
                                                "You currently have no messages",
                                                textAlign: TextAlign.center,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ));
                            }
                            final docs = snapshot.data.documents;
                            List<MessageTile> messageTiles = [];
                            for (var doc in docs) {
                              String text= doc.data['text'];
                              String photo=doc.data['receiverPhoto'];
                              String name=doc.data['receiverName'];
                              String from=doc.data['from'];
                                  String to=doc.data['to'];
                              var storedDate = doc.data['timestamp'];

                              String elapsedTime =
                              timeago.format(storedDate.toDate());
                              String timestamp = '$elapsedTime';

                              messageTiles.add(new MessageTile(text: text,from: from,timestamp: timestamp,senderName:name,senderPhoto: photo,to:to));
                            }

                            return Container(
                              child: ListView.separated(
                                itemCount: messageTiles.length,scrollDirection: Axis.vertical,shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return messageTiles[index];
                                },

                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                              ),

                            );
                          }),
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

  final String to,from,text, timestamp,senderPhoto, senderName;

  MessageTile({this.text,this.to,this.from,this.timestamp,this.senderPhoto,this.senderName});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.leftToRight,
                child: Chat(fromUserId:to,toUserId: from,)));
      },
      leading: CircleAvatar(
        backgroundImage: NetworkImage(senderPhoto),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(senderName),
          SizedBox(width: MediaQuery.of(context).size.width/3.95,),
          Text(timestamp, style: TextStyle(fontSize: 10, color: Colors.blueAccent[700]),)
        ],
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 10,),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(text.length>=39?text.substring(0,39):text),
        ],
      ),
      //MAX OF 40 CHARACTERS BEFORE "..."
    );
  }
}



