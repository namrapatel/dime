import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'viewCards.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'models/profPost.dart';
import 'models/socialPost.dart';
import 'login.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat.dart';


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

  Future getRecentActivity() async{
    QuerySnapshot querySnapshot= await Firestore.instance.collection('users').document(userId).collection('recentActivity').orderBy('timeStamp',descending: true).getDocuments();
      final docs= querySnapshot.documents;

      return docs;

  }

  @override
  Widget build(BuildContext context) {
    var string = userName.split(" ");
    String firstName = string[0];

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
                        Container(
                        width: MediaQuery.of(context).size.width/1.5,
                        child: AutoSizeText(
                        userName,
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                        minFontSize: 12,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                    ),
                      ),
          IconButton(
            icon: Icon(MaterialCommunityIcons.chat),
            color: Colors.white,
            onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: Chat(
                            fromUserId: currentUserModel.uid,
                            toUserId: userId
                          )));
            },
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
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: getRecentActivity(),
              builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("loading..."));
              } 
              else if(snapshot.data.length == 0){
                return Column(
            children: <Widget>[
              Image.asset('assets/img/improvingDrawing.png',
              height: MediaQuery.of(context).size.height/4,
              width: MediaQuery.of(context).size.height/4,
              
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text("Interactions from the feeds will show up here!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
                ),
                ),
              ),

            ],
          );
              }
              else{
                String action;

                return  ListView.builder(
                  physics: BouncingScrollPhysics(),
                    itemCount: snapshot?.data?.length,
                    itemBuilder: (_, index) {

                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                              snapshot.data[index].data['upvoted']==true&&snapshot.data[index].data['commented']==true?
                                Text(firstName+" upvoted and commented"

                                  ,
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ):
                                  Text(snapshot.data[index].data['upvoted']==true?firstName+" upvoted":firstName+" commented",style: TextStyle(
                      color: Colors.white ))

                              ],
                            ),
                          ),
                      snapshot.data[index].data['type']=='social'?
                          SocialPost(
                            postId: snapshot.data[index].data['postId'],
                          ):ProfPost(
                      postId:snapshot.data[index].data['postId'],
                      ),

                          SizedBox(
                            height: 10,
                          ),
//                          Padding(
//                            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.end,
//                              children: <Widget>[
//                                Text("Taher commented",
//                                  style: TextStyle(
//                                      color: Colors.white
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                          ProfPost(
//                            caption: "Hello",
//                          ),
//                          SizedBox(
//                            height: 10,
//                          ),
//                          Padding(
//                            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.end,
//                              children: <Widget>[
//                                Text("Taher upvoted and commented",
//                                  style: TextStyle(
//                                      color: Colors.white
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                          ProfPost(
//                            caption: "Hello",
//                          ),
                        ],
                      );
                    });
//                  children: <Widget>[
//                    Padding(
//                      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.end,
//                        children: <Widget>[
//                          Text(userName+snapshot.data[index].data['action'],
//                            style: TextStyle(
//                                color: Colors.white
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                    ProfPost(
//                      caption: "Hello",
//                    ),
//                    SizedBox(
//                      height: 10,
//                    ),
//                    Padding(
//                      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.end,
//                        children: <Widget>[
//                          Text("Taher commented",
//                            style: TextStyle(
//                                color: Colors.white
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                    ProfPost(
//                      caption: "Hello",
//                    ),
//                    SizedBox(
//                      height: 10,
//                    ),
//                    Padding(
//                      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.end,
//                        children: <Widget>[
//                          Text("Taher upvoted and commented",
//                            style: TextStyle(
//                                color: Colors.white
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                    ProfPost(
//                      caption: "Hello",
//                    ),
//                  ],
//                );

//              return ListView.builder(
//              itemCount: snapshot?.data?.length,
//              physics: BouncingScrollPhysics(),
//              itemBuilder: (_, index) {
//              Timestamp storedDate=snapshot.data[index].data["timeStamp"];
//              String elapsedTime = timeago.format(storedDate.toDate());
//              String timestamp = '$elapsedTime';
//
//              return SocialPost(
//
//              postId: snapshot.data[index].documentID,
//              caption: snapshot.data[index].data["caption"],
//              comments: snapshot.data[index].data["comments"],
//              timeStamp: timestamp,
//              postPic: snapshot.data[index].data["postPic"],
//              upVotes: snapshot.data[index].data["upVotes"],
//              likes:snapshot.data[index].data['likes']
//              );
//              });
              }
              })

          )
        ),
      ],
    )
    );
  }

}