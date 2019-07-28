import 'package:Dime/homePage.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:fancy_on_boarding/page_model.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:flutter_tagging/flutter_tagging.dart';

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
      backgroundColor: Color(0xFFECE9E4),
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
                    color: Color(0xFFECE9E4),
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
                    child: Text("Messages", style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.w300),),
                  )
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/1.2,
                child: _myListView(context),
              ),






            ],
          ),
        ],
      ),

    );
  }


    Widget _myListView(BuildContext context) {
      return ListView.separated(
        itemCount: 15,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/img/dhruvpatel.jpeg'),
            ),
            title: Row(
              children: <Widget>[
                Text('Dhruv Patel'),
                SizedBox(width: MediaQuery.of(context).size.width/2.95,),
                Text("Yesterday", style: TextStyle(fontSize: 12, color: Colors.blueAccent[700]),)
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18,),
            subtitle: Text("Dude, did you see the game last night? It..."),
            //MAX OF 40 CHARACTERS BEFORE "..." 
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );
    }











}


