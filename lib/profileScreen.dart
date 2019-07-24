import 'package:Dime/EditCardsScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'classes/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'loginPage.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'settings.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // String displayName = currentUserModel.displayName;
  // String bio = currentUserModel.bio;

  // String url = currentUserModel.photoUrl;
  // String uid = currentUserModel.uid;
  // SharedPreferences pref;

  final screenH = ScreenUtil.instance.setHeight;
  final screenW = ScreenUtil.instance.setWidth;
  final screenF = ScreenUtil.instance.setSp;

  //Initializes the state when the page first loads and retrieves the users data from firestore
  @override
  void initState() {
    super.initState();
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
      body: Stack(
        children: <Widget>[
          Container(
            height: screenH(850),
            width: double.infinity,
          ),
          Container(
            height: screenH(350),
            width: double.infinity,
            color: Colors.black,
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height / 9),
            //top: 70,
            left: (MediaQuery.of(context).size.width / 18),
            child: Text(
              "Profile",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
              ),
            ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height / 4.5),
            left: (MediaQuery.of(context).size.width / 21),

            //top: 155.0,
            //left: 20.0,
            right: (MediaQuery.of(context).size.width / 21),
            child: Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                height: screenH(610),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height / 6.5),
            left: (MediaQuery.of(context).size.width / 2 - 50.0),
            child: Container(
              height: screenH(125),
              width: screenH(125),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  image: DecorationImage(
                      image: AssetImage('assets/taher.jpeg'),
                      fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height / 4.4),
            //top: 220,
            left: (MediaQuery.of(context).size.width / 1.23),
            child: Column(
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(AntDesign.logout)
                ),
                SizedBox(
                  height: screenH(15),
                ),
                SizedBox(
                  height: screenH(125),
                ),
              ],
            ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height / 3.1),
            //top: 220,
            left: (MediaQuery.of(context).size.width / 3.2),
            child: Column(
              children: <Widget>[
                Text(
                  'Taher Ankleshwaria',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: screenH(15),
                ),
                SizedBox(
                  height: screenH(125),
                ),
              ],
            ),
          ),
          Positioned(
              top: (MediaQuery.of(context).size.height / 2.25),
              //top: 300,
              //left: 20,
              left: (MediaQuery.of(context).size.width / 22),
              child: Column(
                children: <Widget>[
                  Container(
                      width: screenW(378),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TabsApp()),
                          );
                        },
                        title: Text(
                          "Edit Cards",
                        ),
                        leading: Icon(
                          SimpleLineIcons.credit_card,
                          color: Colors.grey[700],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[700],
                        ),
                      )),
                  Container(
                      width: screenW(378),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TabsApp()),
                          );
                        },
                        title: Text(
                          "Terms and Conditions",
                        ),
                        leading: Icon(
                          SimpleLineIcons.doc,
                          color: Colors.grey[700],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[700],
                        ),
                      )),
                  Container(
                      width: screenW(378),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TabsApp()),
                          );
                        },
                        title: Text(
                          "Privacy and Security",
                        ),
                        leading: Icon(
                          SimpleLineIcons.shield,
                          color: Colors.grey[700],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[700],
                        ),
                      )),
                  Container(
                      width: screenW(378),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TabsApp()),
                          );
                        },
                        title: Text(
                          "Report",
                        ),
                        leading: Icon(
                          SimpleLineIcons.exclamation,
                          color: Colors.grey[700],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[700],
                        ),
                      )),
                ],
              )),
        ],
      ),
    );
  }
}

//       Container(

//     child: Center(
//   child: Column(
//     children: <Widget>[
//       SizedBox(
//         height: 70.0,
//       ),
//       IconButton(
//       iconSize: ScreenUtil.instance.setHeight(25.0),
//       color: Colors.black,
//       icon: Icon(Icons.settings),
//       onPressed: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => EditProfilePage(),
//             ));
//       },
//     ),
//       RaisedButton(
//             color: Colors.greenAccent[700],
//             child: Text('Logout'),
//             onPressed: () async{
//               pref = await SharedPreferences.getInstance();

//               await pref.clear();
//               FirebaseAuth.instance.signOut().then((value) {
//                 Navigator.of(context).pushReplacementNamed('/loginpage');

//               }).catchError((e) {
//                 print(e);
//               });
//             }),
//       SizedBox(height: 30.0),
//       url==null
//             ?CircularProgressIndicator()

//             :CircleAvatar(
//             backgroundImage: NetworkImage(url),
//             radius: 150.0),
//       // Change AssetImage to NetworkImage and within the brackets of the
//       // constructor you'll be able to place a link to the location of the image file
//       // that you wish to put inside the CircleAvatar.
//       SizedBox(
//         height: 15.0,
//       ),
//       //checks if data has been received, if not shows a progress indicator until profile is set up
//       //should set a default image for new users in user management so it displays that the first time user
//       //clicks on their profile
//       displayName == null

//           ? CircularProgressIndicator()
//           : Text('$displayName',
//               style: TextStyle(
//                 fontSize: 30.0,
//               ))
//     ],
//   ),
// ))
