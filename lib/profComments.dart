import 'package:Dime/EditCardsScreen.dart';
import 'package:Dime/socialPage.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'models/commentTags.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'homePage.dart';
import 'login.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'models/comment.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Dime/profPage.dart';

class ProfComments extends StatefulWidget {
  final String postId;
  const ProfComments({this.postId});
  @override
  _ProfCommentsState createState() => _ProfCommentsState(this.postId);
}

class _ProfCommentsState extends State<ProfComments> {
  final String postId;
  String university;
  _ProfCommentsState(this.postId);
  GlobalKey<AutoCompleteTextFieldState<UserTag>> key = new GlobalKey();
  TextEditingController controller = new TextEditingController();
  List<UserTag> suggestions = [
    UserTag(
      id: 'qepKet04E5fC02SYbSiyb3Yw0kX2',
      photo:
          "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=2289214687839499&height=800&width=800&ext=1567912794&hash=AeTzmACju3W_XHmv",
      name: "Shehab Salem",
    )
//    "Apple",
//    "Armidillo",
//    "Actual",
//    "Actuary",
//    "America",
//    "Argentina",
//    "Australia",
//    "Antarctica",
//    "Blueberry",
//    "Cheese",
//    "Danish",
//    "Eclair",
//    "Fudge",
//    "Granola",
//    "Hazelnut",
//    "Ice Cream",
//    "Jely",
//    "Kiwi Fruit",
//    "Lamb",
//    "Macadamia",
//    "Nachos",
//    "Oatmeal",
//    "Palm Oil",
//    "Quail",
//    "Rabbit",
//    "Salad",
//    "T-Bone Steak",
//    "Urid Dal",
//    "Vanilla",
//    "Waffles",
//    "Yam",
//    "Zest"
  ];

  @override
  void initState() {
    super.initState();
    getPostUni();
  }

  getPostUni() async {
    DocumentSnapshot query =
        await Firestore.instance.collection('profPosts').document(postId).get();
    setState(() {
      university = query.data['university'];
    });
  }

  getAllUsers() async {
    QuerySnapshot users =
        await Firestore.instance.collection('users').getDocuments();
  }

  Future<List<Comment>> getComments() async {
    List<Comment> postComments = [];
    print(postId);
    QuerySnapshot query = await Firestore.instance
        .collection('profPosts')
        .document(postId)
        .collection('comments')
        .orderBy('timestamp', descending: false)
        .getDocuments();

    for (var doc in query.documents) {
      String id = doc['commenterId'];
      DocumentSnapshot document =
          await Firestore.instance.collection('users').document(id).get();
      Timestamp storedDate = doc['timestamp'];
      String elapsedTime = timeago.format(storedDate.toDate());
      String times = '$elapsedTime';

      postComments.add(Comment(
          commenterId: id,
          commenterName: document['displayName'],
          commenterPhoto: document['photoUrl'],
          postId: doc['postId'],
          text: doc['text'],
          timestamp: times,
          type: doc['type'],
          commentId: doc.documentID));
    }
    return postComments;
  }

  buildComments() {
    return Container(
        color: Colors.white,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            FutureBuilder<List<Comment>>(
                future: getComments(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());

                  return Container(
                    child: Column(children: snapshot.data),
                  );
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: ProfPage()));
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0.4,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  university != null
                      ? Text(
                          university,
                          style: TextStyle(color: Colors.black),
                        )
                      : SizedBox(
                          height: 0.0,
                        ),
                ],
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: buildComments(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 22,
                            vertical: MediaQuery.of(context).size.height / 72),
                        child: SimpleAutoCompleteTextField(
                          textCapitalization: TextCapitalization.sentences,
                          // key: key,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 30,
                                  bottom:
                                      MediaQuery.of(context).size.height / 155,
                                  top: MediaQuery.of(context).size.height / 155,
                                  right:
                                      MediaQuery.of(context).size.width / 30),
                              hintText: 'Enter Comment',
                              hintStyle: TextStyle(color: Colors.grey)),
                          controller: controller,
//                        suggestions: suggestions,
                          clearOnSubmit: false,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: (20),
                    ),
                    Container(
                        width: 40,
                        height: 40,
                        child: FloatingActionButton(
                            elevation: 5,
                            backgroundColor: Color(0xFF063F3E),
                            heroTag: 'fabb4',
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () async {
                              if (controller.text != "") {
                                String docName =
                                    postId + Timestamp.now().toString();
                                DocumentSnapshot info = await Firestore.instance
                                    .collection('profPosts')
                                    .document(postId)
                                    .get();
                                String ownerID = info.data['ownerId'];
                                Firestore.instance
                                    .collection('profPosts')
                                    .document(postId)
                                    .collection('comments')
                                    .document(docName)
                                    .setData({
                                  'type': 'prof',
                                  'postId': postId,

//                              'commentId':docName,
                                  'commenterId': currentUserModel.uid,
                                  'commenterName': currentUserModel.displayName,
                                  'commenterPhoto': currentUserModel.photoUrl,
                                  'text': controller.text,
                                  'timestamp': Timestamp.now()
                                });

                                Firestore.instance
                                    .collection('postNotifs')
                                    .add({
                                  'commenterId': currentUserModel.uid,
                                  'commenterName': currentUserModel.displayName,
                                  'commenterPhoto': currentUserModel.photoUrl,
                                  'text': controller.text,
                                  'timestamp': Timestamp.now(),
                                  'ownerId': ownerID,
                                  "postID": widget.postId,
                                  "type": "prof",
                                });
                                Firestore.instance
                                    .collection('users')
                                    .document(currentUserModel.uid)
                                    .collection('recentActivity')
                                    .document(widget.postId)
                                    .setData({
                                  'type': 'prof',
                                  'commented': true,
                                  'postId': widget.postId,
                                  'numberOfComments': FieldValue.increment(1),
                                  'timeStamp': Timestamp.now()
                                }, merge: true);

                                QuerySnapshot snap = await Firestore.instance
                                    .collection('profPosts')
                                    .document(postId)
                                    .collection('comments')
                                    .getDocuments();
                                int numberOfComments = snap.documents.length;
                                Firestore.instance
                                    .collection('profPosts')
                                    .document(postId)
                                    .updateData({'comments': numberOfComments});

                                setState(() {
                                  getComments();
                                  controller.clear();
                                });
                              }
                            })),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserTag extends StatelessWidget {
  final String id, name, photo;

  const UserTag({this.id, this.name, this.photo});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(15),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(photo),
        radius: 25,
      ),
      title: Row(
        children: <Widget>[
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
