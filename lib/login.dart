import 'package:Dime/main.dart';
import 'package:Dime/services/facebookauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'signup.dart';
import 'package:page_transition/page_transition.dart';
import 'homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Dime/models/user.dart';
import 'package:Dime/services/googleauth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'homePage.dart';

import 'package:flutter/services.dart';



User currentUserModel;

class Login extends StatefulWidget {
  Login({
    Key key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
//  String validate="";
  final FirebaseMessaging _messaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((firebaseUser) async {

      if (firebaseUser != null) {

        print('in login');
        print(firebaseUser);
        print(firebaseUser.displayName);
        print("you're in");
//check for exception, may only be if emulator not wiped
        DocumentSnapshot userRecord = await Firestore.instance
            .collection('users')
            .document(firebaseUser.uid)
            .get();
        if (userRecord.data != null) {
          currentUserModel = User.fromDocument(userRecord);
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => SplashScreen()));
        }
      } else {
        print("floppps");
      }
    });
  }

  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  _saveDeviceToken() async {
    print("here");
    String uid = 'angHcPRj5yXFKQoxUfNQdvlEA9u1';
    String fcmToken = await _fcm.getToken();
    print(fcmToken);
    if (fcmToken != null) {
      await _db.collection('users').document(uid).get().then((document) {
        print("im in here");
        var initTokens = document['tokens'] == null ? document['tokens'] : [];
        var tokenList = new List<String>.from(initTokens);
        if (!tokenList.contains(fcmToken)) {
          tokenList.add(fcmToken);
          _db.collection('users').document(uid).updateData(
              {'tokens': tokenList});
        }
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _isObscured = true;
  Color _eyeButtonColor = Colors.blueGrey;

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width/100),
      child: Text(
        'Welcome Back.',
        style: TextStyle(
          fontSize: 52.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1458EA),
        ),
      ),
    );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/110, left: MediaQuery.of(context).size.width/100),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: MediaQuery.of(context).size.width/6,
          height: MediaQuery.of(context).size.height/250,
          color: Colors.black,
        ),
      ),
    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
        onSaved: (emailInput) => _email = emailInput,
        validator: (emailInput) {
          if (emailInput.isEmpty) {
            return 'Please enter an email';
          }
//          }else{
//            return validate;
//          }
        },
        decoration: InputDecoration(
            labelText: 'Email Address',
            labelStyle: TextStyle(fontSize: 15, color: Colors.blueGrey),
            contentPadding: EdgeInsets.all(MediaQuery.of(context).size.width/22),
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(
                color: Color(0xFF1458EA),
              ),
            ),
            focusedBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(
                color: Color(0xFF1458EA),
              ),
            )));
  }

  TextFormField buildPasswordInput(BuildContext context) {
    return TextFormField(
      onSaved: (passwordInput) => _password = passwordInput,
      validator: (passwordInput) {
        if (passwordInput.isEmpty) {
          return 'Please enter a password';
        }
      },
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(fontSize: 15, color: Colors.blueGrey),
        fillColor: Color(0xFF1458EA),
        contentPadding: EdgeInsets.all(MediaQuery.of(context).size.width/22),
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
        focusedBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(
            color: Color(0xFF1458EA),
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            if (_isObscured) {
              setState(() {
                _isObscured = false;
                _eyeButtonColor = Theme.of(context).primaryColor;
              });
            } else {
              setState(() {
                _isObscured = true;
                _eyeButtonColor = Colors.blueGrey;
              });
            }
          },
          icon: Icon(
            Icons.remove_red_eye,
            color: _eyeButtonColor,
          ),
        ),
      ),
      obscureText: _isObscured,
    );
  }

  Padding buildPasswordText() {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              //POPUP HERE
              forgotPass();
            },
            child: Text('Forgot Password?',
                style: TextStyle(
                    color: Colors.blueGrey,
                    decoration: TextDecoration.underline)),
          )),
    );
  }
  void _showCupertinoDialog(String exception) {
    String errorMessage='';
     if(exception=="ERROR_INVALID_EMAIL") {
       errorMessage = 'Please enter a valid email address';
     }else if(exception=="ERROR_USER_NOT_FOUND"){
      errorMessage='The email entered does not match any account';
      print('user doesnt exist');
    }else if(exception=="ERROR_WRONG_PASSWORD"){
      errorMessage='The password entered is incorrect';
    }
    else{
      errorMessage="There was an unexpected error";
    }
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Oops!'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorMessage,
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
  }

  void forgotPass() {
    final myController = TextEditingController();
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('No worries, enter your email for a magic link!'),

          content: SingleChildScrollView(
            child: Material(
              child: TextField(
                controller: myController,
                decoration: InputDecoration(hintText: 'Please enter your email'),
              ),
            ),
          ),
//          ,Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Text(
//                'No worries, enter your email for a magic link!',
//              style: TextStyle(color: Colors.grey[600]),
//            ),
//          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () async{
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: myController.text);
                  Navigator.pop(context);
                },
                child: Text(
                  'Send',
                  style: TextStyle(fontSize: 18),
                )),
          ],
        );
//          AlertDialog(
//          title: Text('No worries, enter your email for a magic link!'),
//          content: SingleChildScrollView(
//            child: TextField(
//              controller: myController,
//              decoration: InputDecoration(hintText: 'Please enter your email'),
//            ),
//          ),
//          actions: <Widget>[
//            FlatButton(
//              child: Text('Send'),
//              onPressed: () async{
//        await FirebaseAuth.instance.sendPasswordResetEmail(email: myController.text);
//
//                //sendPasswordResetEmail(email: myController.text);
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
      },
    );
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: MediaQuery.of(context).size.height/13,
        width: MediaQuery.of(context).size.width/1.5,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFF1458EA),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF1458EA).withOpacity(0.35),
                    blurRadius: (15),
                    spreadRadius: (5),
                    offset: Offset(0, 3)),
              ],
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          child: FlatButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                //Only gets here if the fields pass
                _formKey.currentState.save();
                //TODO Check values and navigate to new page
                try {
                  await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _email, password: _password)
                      .then((signedInUser) async {
                    DocumentSnapshot userRecord = await Firestore.instance
                        .collection('users')
                        .document(signedInUser.uid)
                        .get();
                    if (userRecord.data != null) {
                      currentUserModel = User.fromDocument(userRecord);
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => ScrollPage()));
                    }
                  });
                } on PlatformException catch(e)  {
                  _showCupertinoDialog(e.code);
                  print(e.message);
                  print(e.code);
                  print(e.details);
                } catch(i){
                  print('undefined exception');
                  _showCupertinoDialog('unexpected');
                  print(i);
                }

//                Navigator.push(
//                    context,
//                    PageTransition(
//                        type: PageTransitionType.fade, child: ScrollPage()));
              }
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Text(
              'LOGIN',
              style: Theme.of(context).primaryTextTheme.button,
            ),
          ),
        ),
      ),
    );
  }
















  Align buildOrText() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        'Or login with',
        style: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
      ),
    );
  }

  Container buildSocialMediaButtons(IconData icon, Color iconColor) {
    return Container(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(30.0),
        child: Icon(icon, color: iconColor),
      ),
      height: 46.0,
      width: 60.0,
    );
  }

  Align buildSignUpText() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 85,
            ),
            Text("Don't have an account?"),
            SizedBox(width: 5.0),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: SignupPage()));
              },
              child: Text('Sign up',
                  style: TextStyle(
                      color: Color(0xFF1458EA),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline)),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 22.0),
          children: <Widget>[
            SizedBox(height: kToolbarHeight),
            buildTitle(),
            buildTitleLine(),
            SizedBox(
              height: MediaQuery.of(context).size.height/10,
            ),
            buildEmailTextField(),
            SizedBox(
              height: MediaQuery.of(context).size.height/20,
            ),
            buildPasswordInput(context),
            buildPasswordText(),
            SizedBox(
              height: MediaQuery.of(context).size.height/20,
            ),
            buildLoginButton(context),
            SizedBox(
              height: MediaQuery.of(context).size.height/30,
            ),
            buildSignUpText(),
            SizedBox(
              height: MediaQuery.of(context).size.height/20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/17,),
              child: Divider(
                height: MediaQuery.of(context).size.height/330,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 20),
            buildOrText(),
            SizedBox(
              height: 15.0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height/13,
                width: MediaQuery.of(context).size.width/1.5,
                child: OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                    FacebookAuth().logIn(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => ScrollPage()));
                  },
                  color: Color(0xFF3C5A99),
                  child: Center(
                    child: Icon(
                      MaterialCommunityIcons.facebook,
                      color: Color(0xFF3C5A99),
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
