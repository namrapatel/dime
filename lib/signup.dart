import 'package:Dime/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/cupertino.dart';
import 'onboarding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Dime/models/user.dart';
import 'services/usermanagement.dart';
import 'services/facebookauth.dart';
import 'homePage.dart';
import 'package:flutter/services.dart';
//TODO: display text if email already registered etc..

class SignupPage extends StatefulWidget {
  SignupPage({
    Key key,
  }) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  String _email, _password, _confirm;
  bool _isObscured = true;
  Color _eyeButtonColor = Colors.grey;
  Map userProfile;

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 100),
      child: Text(
        'Hello There.',
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
      padding: const EdgeInsets.only(top: 4.0, left: 12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: MediaQuery.of(context).size.width / 6,
          height: MediaQuery.of(context).size.height / 250,
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
      },
      decoration: InputDecoration(
        labelText: 'Email Address',
        labelStyle: TextStyle(fontSize: 15, color: Colors.blueGrey),
        fillColor: Colors.blueAccent[700],
        contentPadding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
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
      ),
    );
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
        fillColor: Colors.blueAccent[700],
        contentPadding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
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
                _eyeButtonColor = Colors.grey;
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

  TextFormField buildConfirmInput(BuildContext context) {
    return TextFormField(
      onSaved: (confirmInput) => _confirm = confirmInput,
      validator: (confirmInput) {
        if (confirmInput.isEmpty) {
          // Need to add validation for confirm password as well
          return 'Please confirm your password';
        }
      },
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        labelStyle: TextStyle(fontSize: 15, color: Colors.blueGrey),
        fillColor: Colors.blueAccent[700],
        contentPadding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
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
                _eyeButtonColor = Colors.grey;
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

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 13,
        width: MediaQuery.of(context).size.width / 1.5,
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
                if (_password == _confirm) {
                  try {
                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _email, password: _password)
                        .then((signedInUser) async {
                      UserManagement().storeNewUser(signedInUser, context);
                      DocumentSnapshot userRecord = await Firestore.instance
                          .collection('users')
                          .document(signedInUser.uid)
                          .get();

                      if (userRecord.data != null) {
                        currentUserModel = User.fromDocument(userRecord);
                        print('in signup');
                      }
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => SplashScreen(
                                    route: 'onBoarding',
                                  )));
                    });
                  } on PlatformException catch (e) {
                    _showCupertinoDialog(e.code);
                    print(e.message);
                    print(e.code);
                    print(e.details);
                  } catch (i) {
                    _showCupertinoDialog('unexpected');
                    print('undefined exception');
                    print(i);
                  }
                  //NAVIGATE TO ONBOARDING

                } else if (_password != _confirm) {
                  _showCupertinoDialog('matching');
                }
              }
            },
            color: Color(0xFF1458EA),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Text(
              'SIGN UP',
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

  Align buildSignUpText() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 85,
            ),
            Text("Already have an account?"),
            SizedBox(width: 5.0),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text('Sign in',
                  style: TextStyle(
                      color: Color(0xFF1458EA),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline)),
            )
          ],
        ));
  }

  void _showCupertinoDialog(String exception) {
    String errorMessage = '';
    if (exception == "ERROR_WEAK_PASSWORD") {
      errorMessage = 'Please enter a password with at least 6 characters';
      print('user doesnt exist');
    } else if (exception == "ERROR_INVALID_EMAIL") {
      errorMessage = 'Please enter a valid email address';
    } else if (exception == "ERROR_EMAIL_ALREADY_IN_USE") {
      errorMessage = 'This email address is already in use by another account';
    } else if (exception == "matching") {
      errorMessage = "Please enter passwords that match";
    } else {
      errorMessage = "There was an unexpected error";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 22.0),
          children: <Widget>[
            SizedBox(height: kToolbarHeight),
            buildTitle(),
            buildTitleLine(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            buildEmailTextField(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            buildPasswordInput(context),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            buildConfirmInput(context),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            buildLoginButton(context),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            buildSignUpText(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 17),
              child: Divider(
                height: MediaQuery.of(context).size.height / 330,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 20),
            buildOrText(),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 13,
                  width: MediaQuery.of(context).size.width / 1.5,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
