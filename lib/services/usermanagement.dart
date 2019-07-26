import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Creates a document in the database for each user, differentiated by email

class UserManagement {
  storeNewUser(user, context) {
    FirebaseUser current = user;
    String uid = current.uid;
    String defaultName = "No Display Name";
    String defaultImage = 'https://firebasestorage.googleapis.com/v0/b/dime-87d60.appspot.com/o/defaultprofile.png?alt=media&token=8cd5318b-9593-4837-a9f9-2a22c87463ef';
    Firestore.instance.collection('users').document('$uid').setData({
      'photoUrl': defaultImage,
      'email': current.email,
      'displayName': defaultName
    });

    createCards(uid, defaultImage, defaultName);
  }

  createCards(String id, String url, String name) {
    Firestore.instance.collection('users').document(id)
        .collection('profcard')
        .add({
      'photoUrl': url,
      'displayName': name
    });
    Firestore.instance.collection('users').document(id)
        .collection('socialcard')
        .add({
      'photoUrl': url,
      'displayName': name
    });
  }
}