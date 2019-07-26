
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'viewCards.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';


class UserCard extends StatefulWidget {
  const UserCard({this.userId});
  final String userId;

  @override
  _UserCardState createState() => _UserCardState(this.userId);
}

class _UserCardState extends State<UserCard> {

  final String userId;

_UserCardState(this.userId);
  
  @override 
  Widget build(BuildContext context){
    
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height/20,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width/25,
              ),
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height/20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ViewCards(userId: this.userId,),
            ],
          ),
        ],
      )
    );
  }


}

