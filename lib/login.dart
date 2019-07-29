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

User currentUserModel;


class Login extends StatefulWidget {
  Login({
    Key key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {



  @override
  void initState() {
    // TODO: implement initState
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
              new MaterialPageRoute(builder: (context) => ScrollPage()));
        }

      } else {
        print("floppps");
      }
    });
  }


  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _isObscured = true;
  Color _eyeButtonColor = Colors.grey;

  Padding buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Welcome Back.', style: TextStyle(fontSize: 52.0, fontWeight: FontWeight.bold),),
    );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, left: 12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 78.0,
          height: 1.5,
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
        labelText: 'Email Address'
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
        suffixIcon: IconButton(
          onPressed: () {
            if (_isObscured) {
              setState(() {
                _isObscured = false;
                _eyeButtonColor = Theme
                  .of(context)
                  .primaryColor;
              });
            } else {
              setState(() {
                _isObscured = true;
                _eyeButtonColor = Colors.grey;
              });
            }
          },
          icon: Icon(Icons.remove_red_eye, color: _eyeButtonColor,),
        ),
      ),
      obscureText: _isObscured,
    );
  }

  Padding buildPasswordText() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
                onTap: (){
                 //POPUP HERE
                 forgotPass();
                },
                child: Text('Forgot Password?',
                    style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.underline)),
              )
      ),
    );
  }

    void forgotPass(){ 
    final myController = TextEditingController();
    showDialog<void>(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('No worries, enter your email for a magic link!'),
        content: SingleChildScrollView(
          child: TextField(
          controller: myController,
          decoration: InputDecoration(
            hintText: 'Please enter your email'
          ),
        ),
            
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Send'),
            onPressed: () {
              //sendPasswordResetEmail(email: myController.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 50.0,
        width: 270.0,
        child: FlatButton(
          onPressed: () async{
            if (_formKey.currentState.validate()) {
              //Only gets here if the fields pass
              _formKey.currentState.save();
              //TODO Check values and navigate to new page
              try{
                await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email , password: _password).then((signedInUser) async{

                  DocumentSnapshot userRecord = await Firestore.instance
                      .collection('users')
                      .document(signedInUser.uid)
                      .get();
                  if (userRecord.data != null) {
                    currentUserModel = User.fromDocument(userRecord);
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => ScrollPage()));
                  }

                });
              }catch(e){
            print(e);

            }

              Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ScrollPage()));
            }
          },
          color: Colors.grey[900],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Text('LOGIN', style: Theme
            .of(context)
            .primaryTextTheme
            .button,),
        ),
      ),
    );
  }

  Align buildOrText() {
    return Align(
      alignment: Alignment.center,
      child: Text('Or login with:', style: TextStyle(fontSize: 15.0, color: Colors.grey),),
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
      width: 46.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey, width: 0.5)
      ),
    );
  }

  Align buildSignUpText() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: <Widget>[
          SizedBox(width: 85,),  
          Text("Don't have an account?"),
              SizedBox(width: 5.0),
              InkWell(
                onTap: (){
                  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: SignupPage()));
                },
                child: Text('Sign up',
                    style: TextStyle(
                        color: Colors.black,
                        
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
              )


        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECE9E4),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 22.0),
          children: <Widget>[
            SizedBox(height: kToolbarHeight),
            buildTitle(),
            buildTitleLine(),
            SizedBox(height: 70.0,),
            buildEmailTextField(),
            SizedBox(height: 30.0,),
            buildPasswordInput(context),
            buildPasswordText(),
            SizedBox(height: 30.0,),
            buildLoginButton(context),
            SizedBox(height: 10.0,),
            buildOrText(),
            SizedBox(height: 15.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              FloatingActionButton(
                onPressed:(){ FacebookAuth().logIn(context,new MaterialPageRoute(builder: (context) => ScrollPage()));},
                heroTag: 'btnF',
                backgroundColor: Color(0xFF3C5A99),
                child: Icon(MaterialCommunityIcons.facebook),
                elevation: 0,
              ),
              SizedBox(width: 20,),
              FloatingActionButton(
                onPressed:(){ GoogleAuth().logIn(context,new MaterialPageRoute(builder: (context) => ScrollPage()));},
                heroTag: 'btnGG',
                backgroundColor: Color(0xFFDB4437),
                child: Icon(AntDesign.google),
                elevation: 0,
              ),
              ],
            ),
            SizedBox(height: 20.0),
            buildSignUpText()
          ],
        ),
      ),
    );
  }
}