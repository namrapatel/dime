  import 'package:Dime/createProfPost.dart';
  import 'package:Dime/profile.dart';
  import 'package:flutter/material.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:page_transition/page_transition.dart';
  import 'homePage.dart';
  import 'login.dart';
  import 'models/profPost.dart';

  final screenH = ScreenUtil.instance.setHeight;
  final screenW = ScreenUtil.instance.setWidth;
  final screenF = ScreenUtil.instance.setSp;
  final _firestore = Firestore.instance;

  class ProfPage extends StatefulWidget {
  @override
  _ProfPageState createState() => _ProfPageState();
  }

  class _ProfPageState extends State<ProfPage> {

  var university = currentUserModel.university;
  @override
  void initState() {

  super.initState();


  }


  Future getPosts() async {

  QuerySnapshot qn = await Firestore.instance
      .collection('profPosts').where('university',isEqualTo: currentUserModel.university)

      .getDocuments();
  List<dynamic> docs= qn.documents;
  List<List<dynamic>> twoD=[];
  List<DocumentSnapshot> finalSorted=[];

  print('length');
  print(docs.length);
  for(var doc in docs){
  double counter=0;
  List<dynamic> toAdd=[];
  Timestamp time=doc.data['timeStamp'];

  print(doc.data['caption']);

  print(DateTime.now().difference(time.toDate()));
  if(DateTime.now().difference(time.toDate()).inMinutes<=60){
  print('difference between posted and time from an hour ago is');
  print(DateTime.now().difference(time.toDate()).inMinutes);
  counter=counter+5;
  }
  int upvotes=doc.data['upVotes'];
  counter=counter+(0.1*upvotes);
  int comments= doc.data['comments'];
  counter=counter+(0.2*comments);
  toAdd.add(doc);
  toAdd.add(counter);
  twoD.add(toAdd);
  }
  for (var list in twoD){
  print(list[0].data['caption']);
  print(list[1]);
  }
  twoD.sort((b, a) => a[1].compareTo(b[1]));
  print('after sort');
  for (var list in twoD){
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
                university!=null?university:"Whoops!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            )),
        backgroundColor: Color(0xFF063F3E),
        floatingActionButton: currentUserModel.university!=null?FloatingActionButton(


          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: CreateProfPost()));
          },
          elevation: 350,
          heroTag: 'btn1',
          backgroundColor: Color(0xFF3c3744),
          child: Icon(
            Icons.add,
            // color: Color(0xFF8803fc),
            color: Colors.white,
          ),
        ):
        SizedBox(height: 1,),
//
        body:university!=null? FutureBuilder(
  future: getPosts(),
  builder: (_, snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
  return Center(child: Text("loading..."));
  } else{

  return ListView.builder(
  itemCount: snapshot?.data?.length,
  physics: BouncingScrollPhysics(),
  itemBuilder: (_, index) {


  return ProfPost(

  postId: snapshot.data[index].documentID,

  );
  });
  }
  }):Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height/18
              ),
              Image.asset('assets/img/login_logo.png'),
              SizedBox(
                height: MediaQuery.of(context).size.height/88,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Please go to settings and add a university to see your feed!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold
                ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/88,
              ),
          FlatButton(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            color: Colors.white,
            child: Text("Add University", style: TextStyle(color: Color(0xFF063F3E), fontSize: 20, fontWeight: FontWeight.bold),),
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
            onPressed: (){
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: Profile()));
            },
          ),

            ],
          )

  );
  }
  }