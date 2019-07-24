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
      padding: const EdgeInsets.all(8.0),
      child: Text('Hello There.', style: TextStyle(fontSize: 52.0, fontWeight: FontWeight.bold ),),
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
              if(_password == _confirm){
                try{
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email , password: _password)
                      .then((signedInUser) async{
                    UserManagement().storeNewUser(signedInUser, context);
                    DocumentSnapshot userRecord = await Firestore.instance
                        .collection('users')
                        .document(signedInUser.uid)
                        .get();
                    if (userRecord.data != null) {
                      currentUserModel = User.fromDocument(userRecord);
                      print('in signup');

                    }
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: onBoarding()));
                  });


                }catch(e){
                  print(e.message);

                }
                //NAVIGATE TO ONBOARDING

              }
              else if(_password != _confirm){
                _showCupertinoDialog();
              }
              
            }
          },
          color: Colors.grey[900],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Text('SIGN UP', style: Theme
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


  Align buildSignUpText() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: <Widget>[
          SizedBox(width: 85,),  
          Text("Already have an account?"),
              SizedBox(width: 5.0),
              InkWell(
                onTap: (){
                  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Login()));
                },
                child: Text('Sign in',
                    style: TextStyle(
                        color: Colors.black,
                        
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
              )


        ],
      )
    );
  }

    void _showCupertinoDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Oops!'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "There was an error in your password confirmation!",
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
      backgroundColor: Color(0xFFECE9E4),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 22.0),
          children: <Widget>[
            SizedBox(height: kToolbarHeight),
            buildTitle(),
            buildTitleLine(),
            SizedBox(height: 40.0,),
            buildEmailTextField(),
            SizedBox(height: 30.0,),
            buildPasswordInput(context),
            SizedBox(height: 30.0,),
            buildConfirmInput(context),
            SizedBox(height: 30.0,),
            buildLoginButton(context),
            SizedBox(height: 10.0,),
            buildOrText(),
            SizedBox(height: 15.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              FloatingActionButton(
                onPressed: (){FacebookAuth().logIn(context,new MaterialPageRoute(builder: (context) => onBoarding()));},
                heroTag: 'btnFB',
                backgroundColor: Color(0xFF3C5A99),
                child: Icon(MaterialCommunityIcons.facebook),
                elevation: 0,
              ),
              SizedBox(width: 20,),
              FloatingActionButton(
                heroTag: 'btnG',
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