import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Dime/classes/user.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import '../homePage.dart';
import '../login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  logIn(context, MaterialPageRoute route) async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken:  googleSignInAuthentication.idToken);

    final FirebaseUser user = await _auth.signInWithCredential(credential);

//    DocumentSnapshot userRecord = await Firestore.instance
//        .collection('users')
//        .document(user.uid)
//        .get();

    DocumentSnapshot userRecord = await Firestore.instance
        .collection('users')
        .document(user.uid)
        .get();

    if (userRecord.data == null) {
      Firestore.instance
          .collection('users')
          .document(user.uid)
          .setData({
        'email': user.email,
        'displayName': user.displayName,
        'phoneNumber': user.phoneNumber,
        'photoUrl': user.photoUrl,
      });
    }

   userRecord = await Firestore.instance
       .collection('users')
       .document(user.uid)
       .get();

   currentUserModel = User.fromDocument(userRecord);
   print("Signed in with google successful for user $user");
   Navigator.push(context,route);
  }
}
