import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'models/comment.dart';

class ProfComments extends StatefulWidget {
  final String postId, stream;
  const ProfComments({this.postId, this.stream});
  @override
  _ProfCommentsState createState() =>
      _ProfCommentsState(this.postId, this.stream);
}

class _ProfCommentsState extends State<ProfComments> with AutomaticKeepAliveClientMixin<ProfComments> {
  final String postId;
  final String stream;

  _ProfCommentsState(this.postId, this.stream);
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  getAllUsers() async {
    QuerySnapshot users =
        await Firestore.instance.collection('users').getDocuments();
  }

  Future<List<Comment>> getComments() async {
    List<Comment> postComments = [];
    print(postId);
    QuerySnapshot query = await Firestore.instance
        .collection('streams')
        .document(stream)
        .collection('posts')
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
          verified: document['verified'],
          stream: stream,
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
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
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
                  stream != null
                      ? Text(
                          "@" + stream,
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
                        child: TextField(
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
                                    .collection('streams')
                                    .document(stream)
                                    .collection('posts')
                                    .document(postId)
                                    .get();
                                String ownerID = info.data['ownerId'];
                                int points = info.data['points'];
                                print('prof comments checkpoint update');
                                print(postId);
                                print(stream);
                                print(docName);
                                Firestore.instance
                                    .collection('streams')
                                    .document(stream)
                                    .collection('posts')
                                    .document(postId)
                                    .collection('comments')
                                    .document(docName)
                                    .setData({
                                  'type': 'prof',
                                  'postId': postId,
                                  'stream': stream,
                                  'commenterId': currentUserModel.uid,
                                  'commenterName': currentUserModel.displayName,
                                  'commenterPhoto': currentUserModel.photoUrl,
                                  'text': controller.text,
                                  'timestamp': Timestamp.now()
                                });
                                Firestore.instance
                                    .collection('postNotifs')
                                    .add({
                                  'stream': stream,
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
                                  'timeStamp': Timestamp.now(),
                                  'stream': stream
                                }, merge: true);

                                QuerySnapshot snap = await Firestore.instance
                                    .collection('streams')
                                    .document(stream)
                                    .collection('posts')
                                    .document(postId)
                                    .collection('comments')
                                    .getDocuments();
                                int numberOfComments = snap.documents.length;
                                Firestore.instance
                                    .collection('streams')
                                    .document(stream)
                                    .collection('posts')
                                    .document(postId)
                                    .updateData({
                                  'comments': numberOfComments,
                                  'points': FieldValue.increment(2)
                                });
                                points = points + 2;
                                setState(() {
                                  getComments();
                                  controller.clear();
                                });

                                if (points >= 100) {
                                  Firestore.instance
                                      .collection('users')
                                      .document(ownerID)
                                      .collection('profcard')
                                      .document('prof')
                                      .updateData({'isFire': true});
                                } else {
                                  Firestore.instance
                                      .collection('users')
                                      .document(ownerID)
                                      .collection('profcard')
                                      .document('prof')
                                      .updateData({'isFire': false});
                                }
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
  @override
  bool get wantKeepAlive => true;
}
