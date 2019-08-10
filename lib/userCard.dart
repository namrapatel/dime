import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'viewCards.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'models/profPost.dart';
import 'models/socialPost.dart';
import 'login.dart';



class UserCard extends StatefulWidget {
  const UserCard({this.userId, this.type, this.userName});
  final String userId, type, userName;

  @override
  _UserCardState createState() => _UserCardState(this.userId, this.type, this.userName);
}

class _UserCardState extends State<UserCard>{

  final String userId, type, userName;

_UserCardState(this.userId, this.type, this.userName);

  final screenH = ScreenUtil.instance.setHeight;
  final screenW = ScreenUtil.instance.setWidth;
  final screenF = ScreenUtil.instance.setSp;

  @override
  void initState() {
    super.initState();

  }


  @override
  void dispose() {
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF1458EA),
        title: Row(
          children: <Widget>[
            Text(
              userName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF1458EA), 
      body: Stack(
      children: <Widget>[
        ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width / 20,
                  MediaQuery.of(context).size.height / 18,
                  0,
                  0),
              child: Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: ViewCards(
                      userId: userId,
                      type: 'social',
                    )),
                  ],
                ),
                alignment: Alignment.topCenter,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width / 35,
                  MediaQuery.of(context).size.height / 18,
                  0,
                  0),
              child: Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: ViewCards(
                      userId: userId,
                      type: 'prof',
                    )),
                  ],
                ),
                alignment: Alignment.topCenter,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width/20, MediaQuery.of(context).size.height / 2.6, 0, 0),
          child: Text("Recent Activity", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              0, MediaQuery.of(context).size.height / 2.4, 0, 0),
          child: Container(
            height: 500,
            width: 500,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("Taher upvoted",
                      style: TextStyle(
                        color: Colors.white
                      ),
                      ),
                    ],
                  ),
                ),
                ProfPost(
                  caption: "Hello",
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("Taher commented",
                      style: TextStyle(
                        color: Colors.white
                      ),
                      ),
                    ],
                  ),
                ),
                ProfPost(
                  caption: "Hello",
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("Taher upvoted and commented",
                      style: TextStyle(
                        color: Colors.white
                      ),
                      ),
                    ],
                  ),
                ),
                ProfPost(
                  caption: "Hello",
                ),
              ],
            ),
          )
        ),
      ],
    )
    );
  }

}