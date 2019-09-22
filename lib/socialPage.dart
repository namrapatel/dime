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

class SocialTabs extends StatefulWidget {

  @override
  _SocialTabsState createState() => _SocialTabsState();
}

class _SocialTabsState extends State<SocialTabs> with AutomaticKeepAliveClientMixin<SocialTabs> {
  var university = currentUserModel.university;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: SizedBox(height: 0,),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white,
              icon: Icon(Icons.arrow_forward_ios),
            ),
          ],
          elevation: 0.0,
          backgroundColor: Color(0xFF8803fc),
          title: Container(
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
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                child: Text(
                  'Chill',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              Tab(
                child: Text(
                  'Party',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [SocialPage(party:false), SocialPage(party:true)],
        ),
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;
}

class SocialPage extends StatefulWidget {
  final bool party;
  const SocialPage({this.party});
  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> with AutomaticKeepAliveClientMixin<SocialPage>{
  var university = currentUserModel.university;
  Firestore firestore = Firestore.instance;
  List<DocumentSnapshot> products = [];
  bool isLoading = false;
  bool hasMore = true;
  int documentLimit = 10;
  bool noPosts=false;
  DocumentSnapshot lastDocument;
  ScrollController _scrollController = ScrollController();
  @override
  void initState()
  {getPosts();
    super.initState();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        getPosts();
      }
    });
  }

 getPosts() async {
   String collection;
   if (widget.party == true) {
     collection = "partyPosts";
   } else {
     collection = "socialPosts";
   }
   if (!hasMore) {
//
     return;
   }
   if (isLoading) {
     return;
   }
   if (products.length != 0) {
     setState(() {
       isLoading = true;
     });
   }
   QuerySnapshot qn;
   if (lastDocument == null) {
     qn = await Firestore.instance
         .collection(collection)
         .where('university', isEqualTo: currentUserModel.university)
         .orderBy('timeStamp', descending: true).limit(documentLimit)
         .getDocuments();
     if (qn.documents.length == 0 || qn == null) {
       setState(() {
         noPosts = true;
       });
     } }else {
     qn = await Firestore.instance
         .collection(collection)
         .where('university', isEqualTo: currentUserModel.university)
         .orderBy('timeStamp', descending: true).startAfterDocument(
         lastDocument).limit(documentLimit)
         .getDocuments();
     if (qn.documents.length == 0 || qn == null) {
       setState(() {
         hasMore = false;
         isLoading = false;
       });
     }
   }
       if (qn.documents.length < documentLimit) {
         hasMore = false;
       }
       lastDocument = qn.documents[qn.documents.length - 1];
       products.addAll(qn.documents);
       setState(() {
         isLoading = false;
       });
//    return qn.documents;

     }




     int commentLengths;

     @override
     Widget build(BuildContext context) {
       super.build(context);
       double defaultScreenWidth = 414.0;
       double defaultScreenHeight = 896.0;
       ScreenUtil.instance = ScreenUtil(
         width: defaultScreenWidth,
         height: defaultScreenHeight,
         allowFontScaling: true,
       )
         ..init(context);
       return Scaffold(

         backgroundColor: Color(0xFF8803fc),
         floatingActionButton: currentUserModel.university != null
             ? FloatingActionButton(
           shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.all(Radius.circular(16.0))),
           onPressed: () {
             Navigator.push(
                 context,
                 PageTransition(
                     type: PageTransitionType.leftToRight,
                     child: widget.party == true
                         ? CreatePartyPost()
                         : CreateSocialPost()));
           },
           elevation: 50,
           heroTag: widget.party == true?"btn1":"btn2",
           backgroundColor: Color(0xFF3c3744),
           child: Icon(
             Icons.add,
             // color: Color(0xFF8803fc),
             color: Colors.white,
           ),
         )
             : SizedBox(
           height: 1,
         ),
         body: Column(children: [
           university != null ?
           Expanded(
             child: noPosts ? Container(
                 child: Text("There are currently no posts.")) : products
                 .length == 0
                 ? Center(child: CircularProgressIndicator())
                 :
             ListView.builder(
               controller: _scrollController,
               itemCount: products.length,
               itemBuilder: (context, index) {
                 return SocialPost.fromDocument(products[index]);
               },
             ),
           ) : Column(
             children: <Widget>[
               SizedBox(height: MediaQuery
                   .of(context)
                   .size
                   .height / 18),
               Image.asset('assets/img/login_logo.png'),
               SizedBox(
                 height: MediaQuery
                     .of(context)
                     .size
                     .height / 88,
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
                 height: MediaQuery
                     .of(context)
                     .size
                     .height / 88,
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
           ),
           isLoading
               ? Container(
             child: CircularProgressIndicator(),
           )
               : Container()
         ]),);
     }
     @override
     bool get wantKeepAlive =>
     true;
   }
