import 'package:cloud_firestore/cloud_firestore.dart';
       import 'package:firebase_auth/firebase_auth.dart';
       import 'package:image_picker/image_picker.dart';
       import 'dart:io';

       class User {

         final String email;
         final String uid;
         final String photoUrl;
         final String displayName;
         final String university;
         final String major;
         final String gradYear;
         final List<dynamic> profInterests;
         final List<dynamic> socialInterests;
         final GeoPoint currentLocation;


         const User(
             {this.university,this.major,this.gradYear,this.profInterests,this.socialInterests,
             this.currentLocation,
             this.uid,
             this.photoUrl,
             this.email,
             this.displayName,

             });

         factory User.fromDocument(DocumentSnapshot document) {
           return User(
             email: document['email'],
             photoUrl: document['photoUrl'],
             uid: document.documentID,
             displayName: document['displayName'],
             university:document['university'],
             major:document['major'],
             gradYear:document['gradYear'],
             profInterests:document['profInterests'],
             socialInterests:document['socialInterests'],
             currentLocation:document['currentLocation']

           );
         }











       }




