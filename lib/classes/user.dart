       import 'package:cloud_firestore/cloud_firestore.dart';
       import 'package:firebase_auth/firebase_auth.dart';
       import 'package:image_picker/image_picker.dart';
       import 'dart:io';

       class User {

         final String email;
         final String uid;
         final String photoUrl;
         final String displayName;
         final String bio;


         const User(
             {
             this.uid,
             this.photoUrl,
             this.email,
             this.displayName,
             this.bio
             });

         factory User.fromDocument(DocumentSnapshot document) {
           return User(
             email: document['email'],
             photoUrl: document['photoUrl'],
             uid: document.documentID,
             displayName: document['displayName'],
             bio: document['bio'],

           );
         }











       }





