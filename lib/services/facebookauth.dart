import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Dime/models/user.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import '../homePage.dart';
import '../login.dart';
import 'package:Dime/services/usermanagement.dart';

class FacebookAuth {
  final _auth = FirebaseAuth.instance;
  Map userProfile;
  FacebookLogin fbLogin = new FacebookLogin();

  log(context, MaterialPageRoute route) async {
    FacebookLoginResult result =
        await fbLogin.logIn(['email', 'public_profile']);

    final FacebookAccessToken accessToken = result.accessToken;

    AuthCredential credential =
        FacebookAuthProvider.getCredential(accessToken: accessToken.token);

    FirebaseUser user = await _auth.signInWithCredential(credential);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = accessToken.token;
        print(token);
        print(accessToken.expires);
        //                          final pic =await http.get('http://graph.facebook.com/[user_id]/picture?type=square');
        final graphResponse = await http.get(
            'https://graph.facebook.com/v3.3/me?fields=name,picture.width(800).height(800),email&access_token=${token}');
        print(graphResponse);
        userProfile = JSON.jsonDecode(graphResponse.body);

        break;

      case FacebookLoginStatus.cancelledByUser:
        print('cancelled');
        break;
      case FacebookLoginStatus.error:
        print('error');
        break;
    }

    DocumentSnapshot userRecord =
        await Firestore.instance.collection('users').document(user.uid).get();
    if (userRecord.data == null) {
      print('doesnt exist');
      String facebookUid;
      for (var data in user.providerData) {
        if (data.providerId == 'facebook.com') {
          facebookUid = data.uid;
        }
      }
      String fbPhoto = userProfile["picture"]["data"]["url"];
      List<String> empty = [];
      Firestore.instance.collection('users').document(user.uid).setData({
        'photoUrl': fbPhoto,
        'email': user.email,
        'displayName': user.displayName,
        'phoneNumber': user.phoneNumber,
        'facebookUid': facebookUid,
        'likedBy': empty,
        'likedUsers': empty
      });
      userRecord =
          await Firestore.instance.collection('users').document(user.uid).get();

      UserManagement().createCards(user.uid, fbPhoto, user.displayName);
    }

    currentUserModel = User.fromDocument(userRecord);

    print('signed in with facebook successful: user -> $user');
    Navigator.push(context, route);
  }
}
