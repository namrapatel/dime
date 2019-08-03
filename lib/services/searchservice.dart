import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  getAllUsers() {
    return Firestore.instance.collection('users').getDocuments();
  }
}