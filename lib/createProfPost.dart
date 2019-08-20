import 'package:Dime/services/usermanagement.dart';
import 'package:Dime/ProfPage.dart';
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
import 'package:image_cropper/image_cropper.dart';
import 'dart:math' as Math;

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;
final List<String> filterWords = [
  "anal",
  "anus",
  "arse",
  "ass",
  "ass fuck",
  "ass hole",
  "assfucker",
  "asshole",
  "assshole",
  "bastard",
  "bitch",
  "black cock",
  "bloody hell",
  "boong",
  "cock",
  "cockfucker",
  "cocksuck",
  "cocksucker",
  "coon",
  "coonnass",
  "crap",
  "cunt",
  "cyberfuck",
  "damn",
  "darn",
  "dick",
  "dirty",
  "douche",
  "dummy",
  "erect",
  "erection",
  "erotic",
  "escort",
  "fag",
  "faggot",
  "fuck",
  "Fuck off",
  "fuck you",
  "fuckass",
  "fuckhole",
  "god damn",
  "gook",
  "hard core",
  "hardcore",
  "homoerotic",
  "hore",
  "lesbian",
  "lesbians",
  "mother fucker",
  "motherfuck",
  "motherfucker",
  "negro",
  "nigger",
  "orgasim",
  "orgasm",
  "penis",
  "penisfucker",
  "piss",
  "piss off",
  "porn",
  "porno",
  "pornography",
  "pussy",
  "retard",
  "sadist",
  "sex",
  "sexy",
  "shit",
  "slut",
  "son of a bitch",
  "suck",
  "tits",
  "viagra",
  "whore"
];
UserManagement uploader = new UserManagement();

class CreateProfPost extends StatefulWidget {
  @override
  _CreateProfPostState createState() => _CreateProfPostState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _CreateProfPostState extends State<CreateProfPost> {
  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }

  TextEditingController descriptionController = TextEditingController();
  File file;
  AppState state;

  String elapsedTime;
  String caption;
  String postPic;
  Timestamp timeStamp;
  var storedDate;
  String postId;
  int upVotes;
  bool loading = false;

  Widget _buildButtonIcon() {
    if (state == AppState.free)
      return Icon(AntDesign.picture);
    else if (state == AppState.picked)
      return Icon(Icons.crop);
    else if (state == AppState.cropped)
      return Icon(Icons.clear);
    else
      return Container();
  }

  Future<Null> _pickImage() async {
    file = await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 100, maxHeight: 1920, maxWidth: 1350);
    if (file != null) {
      setState(() {
        state = AppState.picked;
      });
    }
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
      ratioX: 1.5,
      ratioY: 1,
      sourcePath: file.path,
      toolbarTitle: 'Crop your Image',
      toolbarColor: Color(0xFF063F3E),
      toolbarWidgetColor: Colors.white,
    );
    if (croppedFile != null) {
      file = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
    if (croppedFile == null){
      setState(() {
         file = null;
         state = AppState.free;
      });
    }
  }

  Future<Null> _saveImage() async {}

  void _clearImage() {
    setState(() {
      file = null;
      state = AppState.free;
    });
  }

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
                            color: Color(0xFF063F3E), fontSize: screenF(18)),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: ProfPage()));
                    },
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        screenW(20), screenH(50), screenW(20), screenH(0)),
                    child: FloatingActionButton.extended(
                      backgroundColor: Color(0xFF096664),
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
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    // height: screenH(50),
                    // width: screenW(50),
                    FloatingActionButton(
                      backgroundColor: Color(0xFF096664),
                      onPressed: () {
                        if (state == AppState.free)
                          _selectImage(context);
                        else if (state == AppState.picked)
                          _cropImage();
                        else if (state == AppState.cropped) _clearImage();
                      },
                      child: _buildButtonIcon(),
                      heroTag: 'imgbtn',
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    state == AppState.picked
                        ? FloatingActionButton(
                            backgroundColor: Color(0xFF063F3E),
                            onPressed: () {
                              _clearImage();
                            },
                            child: Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                            heroTag: 'clearbtn',
                          )
                        : Container(),

//                            child: FloatingActionButton(
//                              shape: RoundedRectangleBorder(
//                                  borderRadius:
//                                      BorderRadius.all(Radius.circular(16.0))),
//                              onPressed: () {
//                                _selectImage(context);
//                              },
//                              elevation: 5,
//                              heroTag: 'imgbtn',
//                              backgroundColor: Colors.white,
//                              // label: Text(
//                              //   "Add an Image",
//                              //   style: TextStyle(
//                              //       color: Colors.black, fontSize: 17),
//                              // ),
//                              child: Icon(
//                                SimpleLineIcons.picture,
//                                color: Colors.black,
//                                size: 25,
//                              ),
//                            ),

//                    IconButton(
//                      icon: Icon(Icons.close),
//                      onPressed: () {
//                        _clearImage();
//                      },
//                      color: Color(0xFF8803fc),
//                    )
                  ],
                ),
              ),
              Card(
                  color: Colors.grey[200],
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        child: file != null
                            ? Image.file(
                                file,
//                                width: screenW(170),
                                height: screenH(375),
                                fit: BoxFit.fitHeight,
                              )
                            : Container(),
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
                    imageQuality: 100,
                      source: ImageSource.camera,
                      maxWidth: 1920,
                      maxHeight: 1350);
                  setState(() {
                    state = AppState.picked;
                    _cropImage();
                    file = imageFile;
                  });
                }),
            SimpleDialogOption(
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  File imageFile = await ImagePicker.pickImage(
                    imageQuality: 100,
                      source: ImageSource.gallery,
                      maxWidth: 1920,
                      maxHeight: 1350);
                  setState(() {
                    file = imageFile;
                    state = AppState.picked;
                    _cropImage();
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

//  void clearImage() {
//    setState(() {
//      file = null;
//    });
//  }

  void post() {
    List<String> captionWords = descriptionController.text.split(" ");
    bool filterWordFound = false;
    for (String word in captionWords) {
      if (filterWords.contains(word)) {
        filterWordFound = true;
        break;
      }
    }
    if (filterWordFound) {
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Oops!'),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Sorry, that post does not meet our community guidelines",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Try again',
                      style: TextStyle(fontSize: 18),
                    )),
              ],
            );
          });
    } else {
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

          uploader.addProfPost(caption, timeStamp, postPic, postId, upVotes);
        }).then((_) {
          setState(() {
            file = null;
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft, child: ProfPage()));
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

        uploader.addProfPost(caption, timeStamp, postPic, postId, upVotes);
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: ProfPage()));
      }
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
