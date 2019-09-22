import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Paginate extends StatefulWidget {
  @override
  _PaginateState createState() => _PaginateState();
}

class _PaginateState extends State<Paginate> {
  Firestore firestore = Firestore.instance;
  List<DocumentSnapshot> products = [];
  bool isLoading = false;
  bool hasMore = true;
  int documentLimit = 10;
  DocumentSnapshot lastDocument;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getProducts();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        getProducts();
      }
    });
  }

  getProducts() async {
    if (!hasMore) {
      print('No More Products');
      return;
    }
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    QuerySnapshot querySnapshot;
    if (lastDocument == null) {
      querySnapshot = await firestore
          .collection('socialPosts')
          .orderBy('timeStamp')
          .limit(documentLimit)
          .getDocuments();
    } else {
      querySnapshot = await firestore
          .collection('socialPosts')
          .orderBy('timeStamp')
          .startAfterDocument(lastDocument)
          .limit(documentLimit)
          .getDocuments();
      print(1);
    }
    if (querySnapshot.documents.length < documentLimit) {
      hasMore = false;
    }
    lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];
    products.addAll(querySnapshot.documents);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Pagination with Firestore'),
      ),
      body: Column(children: [
        Expanded(
          child: products.length == 0
              ? Center(
            child: Text('No Data...'),
          )
              : ListView.builder(
            controller: _scrollController,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.all(5),
                title: Text(products[index].data['caption']),
                subtitle: Text(products[index].data['timeStamp'].toString()),
              );
            },
          ),
        ),
        isLoading
            ? Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(5),
          color: Colors.yellowAccent,
          child: Text(
            'Loading',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
            : Container()
      ]),
    );
  }
}
