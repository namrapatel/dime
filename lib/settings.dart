// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/widgets.dart';
// import 'classes/user.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'loginpage.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';

// class SettingsPage extends StatefulWidget {
//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   bool _value1 = false;
//   bool _value2 = false;

//   void _onChanged1(bool value) => setState(() => _value1 = value);
//   void _onChanged2(bool value) => setState(() => _value2 = value);

//   final screenH = ScreenUtil.instance.setHeight;
//   final screenW = ScreenUtil.instance.setWidth;
//   final screenF = ScreenUtil.instance.setSp;

//   String displayName = currentUserModel.displayName;
//   String bio = currentUserModel.bio;

//   String url = currentUserModel.photoUrl;
//   String uid = currentUserModel.uid;
//   SharedPreferences pref;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Container(
//             height: screenH(850),
//             width: double.infinity,
//           ),
//           Positioned(
//             top: (MediaQuery.of(context).size.height / 16),
//             left: (MediaQuery.of(context).size.width / 45),
//             //top: 32,
//             //left: 5,
//             child: IconButton(
//                 icon: Icon(Icons.close),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 color: Colors.black),
//           ),
//           Positioned(
//               top: (MediaQuery.of(context).size.height / 16),
//               left: (MediaQuery.of(context).size.width / 1.2),
//               child: IconButton(
//                 icon: Icon(Feather.log_out),
//                 onPressed: () {
//                   Navigator.of(context).pushReplacementNamed('/loginpage');
//                 },
//               )),
//           Positioned(
//             top: (MediaQuery.of(context).size.height / 12),
//             left: (MediaQuery.of(context).size.width / 3.8),
//             child: Text(
//               "Account Settings",
//               style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//           Positioned(
//             top: (MediaQuery.of(context).size.height / 6),
//             //top: 105.0,
//             //left: 30,
//             left: (MediaQuery.of(context).size.width / 20),
//             child: Container(
//               height: screenH(125),
//               width: screenH(125),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50.0),
//                   image: DecorationImage(
//                       image: NetworkImage(url), fit: BoxFit.cover)),
//             ),
//           ),
//           Positioned(
//             top: (MediaQuery.of(context).size.height / 5.5),
//             left: (MediaQuery.of(context).size.width / 2.6),
//             child: Column(
//               children: <Widget>[
//                 Text(
//                   '$displayName',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
//                 ),
//                 SizedBox(
//                   height: screenH(15),
//                 ),
//                 Text(
//                   '(123) 456-7890',
//                   style: TextStyle(
//                       fontFamily: 'Comfortaa',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17.0,
//                       color: Colors.grey),
//                 ),
//                 SizedBox(
//                   height: screenH(125),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             top: (MediaQuery.of(context).size.height / 3.8),
//             left: (MediaQuery.of(context).size.width / 2.6),
//             child: OutlineButton(
//                 child: Text("Change Picture"),
//                 onPressed: () {},
//                 color: Colors.black,
//                 shape: new RoundedRectangleBorder(
//                     borderRadius: new BorderRadius.circular(15.0))),
//           ),
//           Positioned(
//             top: (MediaQuery.of(context).size.height / 2.85),
//             left: (MediaQuery.of(context).size.width / 21),
//             right: (MediaQuery.of(context).size.width / 21),
//             child: Material(
//               elevation: 3.0,
//               borderRadius: BorderRadius.circular(15.0),
//               child: Container(
//                 height: screenH(530),
//                 //height: 405.0,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15.0),
//                     color: Colors.white),
//               ),
//             ),
//           ),
//           Positioned(
//             top: (MediaQuery.of(context).size.height / 2.6),
//             left: (MediaQuery.of(context).size.width / 10),
//             child: Text(
//               "Options",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Positioned(
//             top: (MediaQuery.of(context).size.height / 2.3),
//             left: (MediaQuery.of(context).size.width / 21),
//             child: Container(
//                 color: Colors.white,
//                 width: screenW(360),
//                 child: ListTile(
//                   onTap: () {},
//                   title: Text(
//                     "Notifications",
//                   ),
//                   leading: Icon(
//                     SimpleLineIcons.bell,
//                     color: Colors.grey[700],
//                   ),
//                   trailing: new Switch(
//                     value: _value1,
//                     onChanged: _onChanged1,
//                     activeColor: Colors.black,
//                   ),
//                 )),
//           ),
//           Positioned(
//             top: (MediaQuery.of(context).size.height / 1.95),
//             left: (MediaQuery.of(context).size.width / 12),
//             child: Container(
//               color: Colors.white,
//               width: screenW(340),
//               child: CupertinoTextField(
//                 prefix: Icon(SimpleLineIcons.user),
//                 padding: EdgeInsets.all(20),
//                 clearButtonMode: OverlayVisibilityMode.editing,
//                 keyboardType: TextInputType.emailAddress,
//                 autocorrect: false,
//                 decoration: BoxDecoration(
//                   border: Border(
//                       bottom: BorderSide(
//                           width: 0.0, color: CupertinoColors.inactiveGray)),
//                 ),
//                 placeholder: '$displayName',
//               ),
//             ),
//           ),
//           Positioned(
//             top: (MediaQuery.of(context).size.height / 1.6),
//             left: (MediaQuery.of(context).size.width / 12),
//             child: Container(
//               color: Colors.white,
//               width: screenW(340),
//               child: CupertinoTextField(
//                 prefix: Icon(SimpleLineIcons.phone),
//                 padding: EdgeInsets.all(20),
//                 clearButtonMode: OverlayVisibilityMode.editing,
//                 keyboardType: TextInputType.phone,
//                 autocorrect: false,
//                 decoration: BoxDecoration(
//                   border: Border(
//                       bottom: BorderSide(
//                           width: 0.0, color: CupertinoColors.inactiveGray)),
//                 ),
//                 placeholder: '(123) 456-7890',
//               ),
//             ),
//           ),
//           Positioned(
//               top: (MediaQuery.of(context).size.height / 1.2),
//               left: (MediaQuery.of(context).size.width / 9),
//               child: new SizedBox(
//                 width: screenW(150),
//                 height: screenH(55),
//                 child: new OutlineButton(
//                     child: Text(
//                       "Cancel",
//                       style: TextStyle(color: Colors.black, fontSize: 15),
//                     ),
//                     color: Colors.black,
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(15.0))),
//               )),
//           Positioned(
//               top: (MediaQuery.of(context).size.height / 1.2),
//               left: (MediaQuery.of(context).size.width / 1.9),
//               child: new SizedBox(
//                 width: screenW(150),
//                 height: screenH(55),
//                 child: new RaisedButton(
//                     child: Text(
//                       "Save Changes",
//                       style: TextStyle(color: Colors.white, fontSize: 15),
//                     ),
//                     color: Colors.black,
//                     onPressed: () {},
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(15.0))),
//               )),
//         ],
//       ),
//     );
//   }
// }
