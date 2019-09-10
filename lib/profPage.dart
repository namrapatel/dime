import 'package:Dime/profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'homePage.dart';
import 'login.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'createProfPost.dart';
import 'models/profPost.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'streams.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ProfPage extends StatefulWidget {
  final String stream;
  const ProfPage({this.stream});
  @override
  _ProfPageState createState() => _ProfPageState(stream: stream);
}

class _ProfPageState extends State<ProfPage> {
  FirebaseMessaging _fcm = FirebaseMessaging();
  int subCounter = 0;
  var university = currentUserModel.university;
  String stream;
  bool subscribed;
  _ProfPageState({this.stream});
  @override
  void initState() {
    super.initState();
    checkSubscription();
  }

  checkSubscription() async {
    DocumentSnapshot userDoc = await Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .get();
    if (userDoc['subscriptions'] != null) {
      if (userDoc['subscriptions'].contains(stream)) {
        setState(() {
          subscribed = true;
        });
      }
    }
  }

  void fcmSubscribe(String topic) {
    _fcm.subscribeToTopic(topic);
  }

  void fcmUnsubscribe(String topic) {
    _fcm.unsubscribeFromTopic(topic);
  }

  Future getPosts() async {
    List<DocumentSnapshot> finalSorted = [];
    List<dynamic> docs =[];
    List<List<dynamic>> twoD = [];

    if(stream=="Subscriptions"){
      QuerySnapshot postNames= await Firestore.instance.collection('users').document(currentUserModel.uid).collection('feed').getDocuments();
      List<dynamic> addressesDocs=postNames.documents;
//      List<DocumentSnapshot> subscribedPosts=[];
      for(var a=0;a<addressesDocs.length;a++){
        String address= addressesDocs[a].documentID;
        String streamPost= addressesDocs[a]['stream'];
       DocumentSnapshot post= await Firestore.instance.collection("streams").document(streamPost).collection('posts').document(address).get();
      docs.add(post);

       print(post.documentID);
      }




    }else {
      QuerySnapshot qn = await Firestore.instance
          .collection('streams')
          .document(stream)
          .collection('posts')
          .where('university', isEqualTo: currentUserModel.university)
          .getDocuments();
      docs = qn.documents;
    }


      print('length');
      print(docs.length);
      for (var doc in docs) {
        double counter = 0;
        List<dynamic> toAdd = [];
        Timestamp time = doc.data['timeStamp'];

        print(doc.data['caption']);

        print(DateTime.now().difference(time.toDate()));
        if (DateTime
            .now()
            .difference(time.toDate())
            .inMinutes <= 60) {
          print('difference between posted and time from an hour ago is');
          print(DateTime
              .now()
              .difference(time.toDate())
              .inMinutes);
          counter = counter + 5;
        }
        int upvotes = doc.data['upVotes'];
        counter = counter + (0.1 * upvotes);
        int comments = doc.data['comments'];
        counter = counter + (0.2 * comments);
        toAdd.add(doc);
        toAdd.add(counter);
        twoD.add(toAdd);
      }
      for (var list in twoD) {
        print(list[0].data['caption']);
        print(list[1]);
      }
      twoD.sort((b, a) => a[1].compareTo(b[1]));
      print('after sort');
      for (var list in twoD) {
        print(list[0].data['caption']);
        print(list[1]);
        finalSorted.add(list[0]);
      }

    return finalSorted;
  }

  int commentLengths;

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
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0), // here the desired height
            child: AppBar(
              backgroundColor: Color(0xFF096664),
              elevation: 0,
              // actions: <Widget>[
              //   IconButton(
              //     icon: Icon(Icons.arrow_forward_ios),
              //     color: Colors.white,
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           PageTransition(
              //               type: PageTransitionType.rightToLeft,
              //               child: ScrollPage()));
              //     },
              //   ),
              // ],
              automaticallyImplyLeading: false,
              title: Row(
                children: <Widget>[
                  // Text(
                  //  university!=null?university:"Whoops!",
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 25,
                  //       fontWeight: FontWeight.bold),
                  // ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: screenH(8.5),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => ScrollPage()));
                        },
                      ),
                    ],
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width / 30,
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: screenH(3.0),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            child: AutoSizeText(
                              '@' + stream,
                              //university != null ? university : "Whoops!",
                              style: TextStyle(
                                  fontSize: screenF(27.5),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              minFontSize: 12,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: screenH(5.8),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => ProfStreams()));
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  // Container(
                  //   child: RaisedButton(
                  //       shape: new RoundedRectangleBorder(
                  //           borderRadius: new BorderRadius.circular(20.0)),
                  //       child: Text(
                  //         "Subscribe",
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //       color: Colors.black,
                  //       onPressed: () {}),
                  // ),
                  Spacer(),
                  currentUserModel.university != null &&stream!="Subscriptions"
                      ? InkWell(
                          child: Icon(
                            Ionicons.ios_create,
                            size: screenH(36.0),
                            color: Colors.white,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => CreateProfPost(
                                          stream: stream,
                                        )));
                          },
                        )
                      : SizedBox(),
                  // FloatingActionButton(
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         CupertinoPageRoute(
                  //             builder: (context) => CreateProfPost(
                  //                   stream: stream,
                  //                 )));
                  //   },
                  //   elevation: 50,
                  //   heroTag: 'btn1',
                  //   backgroundColor: Color(0xFF3c3744),
                  //   child: Icon(
                  //     Icons.add,
                  //     // color: Color(0xFF8803fc),
                  //     color: Colors.white,
                  //   ),
                  // )
                ],
              ),
            )),
        backgroundColor: Color(0xFF096664),
        floatingActionButton: currentUserModel.university != null &&stream!="Subscriptions"
            // ? FloatingActionButton(
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(16.0))),
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           CupertinoPageRoute(
            //               builder: (context) => CreateProfPost(
            //                     stream: stream,
            //                   )));
            //     },
            //     elevation: 50,
            //     heroTag: 'btn1',
            //     backgroundColor: Color(0xFF3c3744),
            //     child: Icon(
            //       Icons.add,
            //       // color: Color(0xFF8803fc),
            //       color: Colors.white,
            //     ),
            //   )
            // ? SizedBox()
            ? Container(
                child: RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                onPressed: () {


                  String uniqueStream = currentUserModel.university + stream;
                  uniqueStream = uniqueStream.split(' ').join("");
                  List<String> streamName = [stream];
                  List<String> currentId=[];
                  currentId.add(currentUserModel.uid);

                  if (subscribed == true) {
                    Firestore.instance
                        .collection('streams')
                        .document(stream)
                        .setData({
                      'numberOfMembers': FieldValue.increment(-1),
                      currentUserModel.university+' Members': FieldValue.arrayRemove(currentId),

                    }, merge: true);
                    setState(() {
                      subscribed = false;
                    });
                    Firestore.instance
                        .collection('users')
                        .document(currentUserModel.uid)
                        .setData({
                      'subscriptions': FieldValue.arrayRemove(streamName)
                    }, merge: true);
                    fcmUnsubscribe(uniqueStream);
                  } else {
                    Firestore.instance
                        .collection('streams')
                        .document(stream)
                        .setData({
                      'numberOfMembers': FieldValue.increment(1),
                      currentUserModel.university+' Members': FieldValue.arrayUnion(currentId),
                    }, merge: true);
                    setState(() {
                      subscribed = true;
                    });
                    Firestore.instance
                        .collection('users')
                        .document(currentUserModel.uid)
                        .setData({
                      'subscriptions': FieldValue.arrayUnion(streamName)
                    }, merge: true);
                    fcmSubscribe(uniqueStream);
                  }
                },
                child: Text(
                  subscribed == true ? "Unsubscribe" : "Subscribe ",
                  style: TextStyle(color: Color(0xFF096664)),
                ),
                color: Colors.white,
              ))
            //   )
            : SizedBox(
                height: 1,
              ),
        body: university != null
            ? FutureBuilder(
                future: getPosts(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SizedBox(
                        height: 0.0,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot?.data?.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (_, index) {
                          return ProfPost.fromDocument(snapshot.data[index]);
                        });
                  }
                })
            : Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height / 18),
                  Image.asset('assets/img/login_logo.png'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 88,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Please go to settings and add a university to see your feed!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 88,
                  ),
                  FlatButton(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    color: Colors.white,
                    child: Text(
                      "Add University",
                      style: TextStyle(
                          color: Color(0xFF063F3E),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    onPressed: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => Profile()));
                    },
                  ),
                ],
              ));
  }
}
