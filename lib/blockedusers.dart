import 'package:Dime/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login.dart';
import 'homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flushbar/flushbar.dart';


final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;

class BlockedUsers extends StatefulWidget {
  @override
  _BlockedUsersState createState() => _BlockedUsersState();
}

class _BlockedUsersState extends State<BlockedUsers> {
  Future getBlockedUsers() async {
    List<DocumentSnapshot> users = [];
    QuerySnapshot query = await Firestore.instance
        .collection('users')
        .where('blocked${currentUserModel.uid}', isEqualTo: true)
        .getDocuments();
    for (var doc in query.documents) {
      users.add(doc);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
       double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF1458EA),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: ProfilePage()));
            },
          ),
          title: Row(children: <Widget>[
            Container(
              child: AutoSizeText(
                "Blocked Users",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                minFontSize: 12,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ])),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: FutureBuilder(
                future: getBlockedUsers(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                        alignment: FractionalOffset.center,
                        child: CircularProgressIndicator());
                  } else {
                    if (snapshot.data.length == 0) {
                      return Container(
                          child: Center(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: screenH(150),
                            ),
                            Image.asset('assets/img/login_logo.png',
                            height: screenH(350),
                            width: screenW(350),
                            ),
                            SizedBox(
                              height: screenH(5),
                            ),
                            Text(
                              "You have no blocked users",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ));
                    } else {
                      return ListView.builder(
                          itemCount: snapshot?.data?.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: screenH(8.0)),
                              child: ListTile(
                                title: Container(
                                child: AutoSizeText(
                                  snapshot.data[index]['displayName'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      ),
                                  minFontSize: 12,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      snapshot.data[index]['photoUrl']),
                                  radius: 25,
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20.0)),
                                        color: Colors.grey[100],
                                      ),
                                      child: RaisedButton(
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(20.0)),
                                        child: Text(
                                          "Unblock",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.black,
                                        onPressed: () {
                                          print(snapshot.data[index].documentID);
                                          String userID =
                                              snapshot.data[index].documentID;
                                          List<dynamic> ids = [];
                                          ids.add(userID);
                                          Firestore.instance
                                              .collection('users')
                                              .document(currentUserModel.uid)
                                              .updateData({
                                            'blocked$userID': false,
                                            'blocked': FieldValue.arrayRemove(ids),
                                          });
                                          ids.remove(userID);
                                          ids.add(currentUserModel.uid);
                                          Firestore.instance
                                              .collection('users')
                                              .document(userID)
                                              .updateData({
                                            'blocked${currentUserModel.uid}': false,
                                            'blockedby':
                                                FieldValue.arrayRemove(ids),
                                          });

                                          Firestore.instance
                                              .collection('users')
                                              .document(currentUserModel.uid)
                                              .collection('messages')
                                              .document(userID)
                                              .setData({'blocked': false},
                                                  merge: true);

                                          Firestore.instance
                                              .collection('users')
                                              .document(userID)
                                              .collection('messages')
                                              .document(currentUserModel.uid)
                                              .setData({'blocked': false},
                                                  merge: true);
                                          setState(() {
                                            getBlockedUsers();
                                          });
                              Flushbar(
                                 margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                borderRadius: 15,
                                messageText: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Unblocked!',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'This user has been unblocked.',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                boxShadows: [
                                  BoxShadow(
                                      color: Colors.black12.withOpacity(0.1),
                                      blurRadius: (15),
                                      spreadRadius: (5),
                                      offset: Offset(0, 3)),
                                ],
                                flushbarPosition: FlushbarPosition.TOP,
                                icon: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                                  child: Icon(
                                    Icons.save_alt,
                                    size: 28.0,
                                    color: Color(0xFF1458EA),
                                  ),
                                ),
                                duration: Duration(seconds: 3),
                              )..show(context);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }
                })),
      ),
    );
  }
}
