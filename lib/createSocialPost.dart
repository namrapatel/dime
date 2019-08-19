import 'package:Dime/services/usermanagement.dart';
import 'package:Dime/socialPage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as Im;
import 'dart:math' as Math;

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;
UserManagement uploader = new UserManagement();

class CreateSocialPost extends StatefulWidget {
  @override
  _CreateSocialPostState createState() => _CreateSocialPostState();
}

class _CreateSocialPostState extends State<CreateSocialPost> {
  TextEditingController descriptionController = TextEditingController();
  File file;
  String elapsedTime;
  String caption;
  String postPic;
  Timestamp timeStamp;
  var storedDate;
  String postId;
  int upVotes;
  bool loading = false;

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
        backgroundColor: Colors.grey[200],
        body: ListView(padding: EdgeInsets.all(0.0), children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          screenW(20), screenH(50), screenW(0), screenH(0)),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: Color(0xFF8803fc), fontSize: screenF(18)),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: SocialPage()));
                    },
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        screenW(20), screenH(50), screenW(20), screenH(0)),
                    child: FloatingActionButton.extended(
                      backgroundColor: Color(0xFF8803fc),
                      onPressed: () {
                        post();
                      },
                      icon: Icon(
                        Ionicons.ios_send,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Post",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              loading
                  ? LinearProgressIndicator()
                  : Padding(padding: EdgeInsets.only(top: 0.0)),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    screenW(30), screenH(20), screenW(30), screenH(0)),
                child: Text(
                  "This post will be anonymous, however comments on the post are not.",
                  textAlign: TextAlign.center,
                ),
              ),
              file == null
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            // height: screenH(50),
                            // width: screenW(50),
                            child: FloatingActionButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0))),
                              onPressed: () {
                                _selectImage(context);
                              },
                              elevation: 5,
                              heroTag: 'imgbtn',
                              backgroundColor: Colors.white,
                              // label: Text(
                              //   "Add an Image",
                              //   style: TextStyle(
                              //       color: Colors.black, fontSize: 17),
                              // ),
                              child: Icon(
                                SimpleLineIcons.picture,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Card(
                      color: Colors.grey[200],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  clearImage();
                                },
                                color: Colors.black,
                              )
                            ],
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                            child: AspectRatio(
                              aspectRatio: 0.92,
                              child: Image(
                                image: FileImage(file),
                                width: screenW(170),
                                height: screenH(250),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      )),
              SizedBox(
                height: screenH(12),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenW(17.0)),
                child: Container(
                  height: screenH(110),
                  decoration: BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: Colors.black.withOpacity(0.35),
                      //       blurRadius: (10),
                      //       spreadRadius: (3),
                      //       offset: Offset(0, 3)),
                      // ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenW(15.0), vertical: screenH(3.0)),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      maxLength: 140,
                      maxLengthEnforced: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "What's going on?",
                          hintStyle: TextStyle(color: Colors.grey[700])),
                      autofocus: true,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenH(15.0), horizontal: screenW(20.0)),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Max. 140 characters",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              )
            ],
          ),
        ]));
  }

  _selectImage(BuildContext parentContext) async {
    return showDialog<Null>(
      context: parentContext,
      barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  File imageFile = await ImagePicker.pickImage(
                      source: ImageSource.camera,
                      maxWidth: 1920,
                      maxHeight: 1350);
                  setState(() {
                    file = imageFile;
                  });
                }),
            SimpleDialogOption(
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  File imageFile = await ImagePicker.pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 200,
                      maxHeight: 350);
                  setState(() {
                    file = imageFile;
                  });
                }),
            SimpleDialogOption(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void compressImage() async {
    print('starting compression');
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    String rand = timeStamp.toString();

    Im.Image image = Im.decodeImage(file.readAsBytesSync());
//     Im.copyResize(image,width: 500,height: 500);

    //    image.format = Im.Image.RGBA;
    //    Im.Image newim = Im.remapColors(image, alpha: Im.LUMINANCE);

    var newim2 = File('$path/img_$rand.jpg')
      ..writeAsBytesSync(Im.encodeJpg(image));

    setState(() {
      file = newim2;
    });
    print('done');
  }

  void clearImage() {
    setState(() {
      file = null;
    });
  }

  void post() {
    timeStamp = Timestamp.now();
    upVotes = 0;
    if (file != null) {
      setState(() {
        loading = true;
      });
      compressImage();
      uploadImage(file).then((String data) {
        elapsedTime = timeago.format(DateTime.now());
        postPic = data;
        caption = descriptionController.text;
        postId = currentUserModel.uid + Timestamp.now().toString();

        uploader.addSocialPost(caption, timeStamp, postPic, postId, upVotes);
      }).then((_) {
        setState(() {
          file = null;
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft, child: SocialPage()));
        });
      });
    } else {
      setState(() {
        loading = false;
      });
      // elapsedTime = timeago.format(storedDate.toDate());
      // timeStamp = '$elapsedTime';
      postId = currentUserModel.uid + Timestamp.now().toString();
      caption = descriptionController.text;

      uploader.addSocialPost(caption, timeStamp, postPic, postId, upVotes);
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft, child: SocialPage()));
    }
  }
}

Future<String> uploadImage(var imageFile) async {
  var uuid = currentUserModel.uid + Timestamp.now().toString();
  StorageReference ref = FirebaseStorage.instance.ref().child("post_$uuid.jpg");
  StorageUploadTask uploadTask = ref.putFile(imageFile);

  String downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
  return downloadUrl;
}
