import 'package:Dime/profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'homePage.dart';
import 'login.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'createSocialPost.dart';
import 'models/socialPost.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'homePage.dart';

class SocialPage extends StatefulWidget {
  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  var university = currentUserModel.university;
  @override
  void initState() {
    super.initState();
  }

  Future getPosts() async {
    QuerySnapshot qn = await Firestore.instance
        .collection('socialPosts')
        .where('university', isEqualTo: currentUserModel.university).orderBy('timeStamp',descending: true)
        .getDocuments();
//    List<dynamic> docs = qn.documents;
//    List<List<dynamic>> twoD = [];
//    List<DocumentSnapshot> finalSorted = [];
//
//    print('length');
//    print(docs.length);
//    for (var doc in docs) {
//      double counter = 0;
//      List<dynamic> toAdd = [];
//      Timestamp time = doc.data['timeStamp'];
//
//      print(doc.data['caption']);
//
//      print(DateTime.now().difference(time.toDate()));
//      if (DateTime.now().difference(time.toDate()).inMinutes <= 180) {
//        print('difference between posted and time from an hour ago is');
//        print(DateTime.now().difference(time.toDate()).inMinutes);
//        counter = counter + 5;
//      }
//      int upvotes = doc.data['upVotes'];
//      counter = counter + (0.1 * upvotes);
//      int comments = doc.data['comments'];
//      counter = counter + (0.2 * comments);
//      toAdd.add(doc);
//      toAdd.add(counter);
//      twoD.add(toAdd);
//    }
//    for (var list in twoD) {
//      print(list[0].data['caption']);
//      print(list[1]);
//    }
//    twoD.sort((b, a) => a[1].compareTo(b[1]));
//    print('after sort');
//    for (var list in twoD) {
//      print(list[0].data['caption']);
//      print(list[1]);
//      finalSorted.add(list[0]);
//    }

    return qn.documents;
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
              backgroundColor: Color(0xFF8803fc),
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
                  currentUserModel.university != null
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
                                    builder: (context) => CreateSocialPost()));
                          },
                        )
                      : SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.55,
                    child: AutoSizeText(
                      university != null ? university : "Whoops!",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      minFontSize: 12,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 110,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => ScrollPage(social: true)));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )),
        backgroundColor: Color(0xFF8803fc),
        body: university != null
            ? FutureBuilder(
                future: getPosts(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      cacheExtent: 5000.0,
                        itemCount: snapshot?.data?.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (_, index) {
                          return SocialPost.fromDocument(snapshot.data[index]);
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
                          color: Color(0xFF8803fc),
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
