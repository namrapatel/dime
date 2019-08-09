import 'package:Dime/viewCards.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'homePage.dart';
import 'login.dart';
import 'EditCardsScreen.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'createProfPost.dart';
import 'profComments.dart';
import 'models/profPost.dart';

Future getPosts() async {
  QuerySnapshot qn = await Firestore.instance
      .collection('profPosts')
      .orderBy('timeStamp', descending: false)
      .getDocuments();
  return qn.documents;
}

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;
final _firestore = Firestore.instance;

class ProfPage extends StatefulWidget {
  @override
  _ProfPageState createState() => _ProfPageState();
}

class _ProfPageState extends State<ProfPage> {
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
            backgroundColor: Color(0xFF063F3E),
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: ScrollPage()));
              },
            ),
            title: Text(
              "University of Waterloo",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          )),
      backgroundColor: Color(0xFF063F3E),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: CreateProfPost()));
        },
        elevation: 50,
        heroTag: 'btn1',
        backgroundColor: Color(0xFF3c3744),
        child: Icon(
          Icons.add,
          // color: Color(0xFF8803fc),
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
          future: getPosts(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("loading..."));
            } else {
              return ListView.builder(
                  itemCount: snapshot?.data?.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, index) {
                    return ProfPost(
                      caption: snapshot.data[index].data["caption"],
                      comments: 20,
                      timeStamp: snapshot.data[index].data["timeStamp"],
                      postPic: snapshot.data[index].data["postPic"],
                    );
                  });
            }
          }),
    );
  }
}
