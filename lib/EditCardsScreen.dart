import 'package:Dime/homePage.dart';
import 'package:Dime/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:flutter_search_panel/flutter_search_panel.dart';
import 'package:flutter_search_panel/search_item.dart';
import 'login.dart';

String selectedItemString;
String selectedWItemString;

String selectedItemString2;
String selectedWItemString2;

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;

class TabsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabs App',
      theme: ThemeData(primarySwatch: Colors.amber,
      primaryColor: Colors.black,
      fontFamily: 'Futura'
      ),
      home: CardEdit(),
    );
  }
}

String amount;

class SocialCardEdit extends StatefulWidget {
  @override
  _SocialCardEditState createState() => _SocialCardEditState();
}

class _SocialCardEditState extends State<SocialCardEdit> {
  Widget _buildAddButton() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.purple[400],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.add,
            color: Colors.white,
            size: 15.0,
          ),
          Text(
            "Add New Tag",
            style: TextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ],
      ),
    );
  }

  String text = "Nothing to show";
  @override
  Widget build(BuildContext context) {
    List<SearchItem<int>> data2 = [
      SearchItem(0, 'Please select your university'),
      SearchItem(1, 'University of British Columbia'),
      SearchItem(2, 'University of Calgary'),
      SearchItem(3, 'University of Western Ontario'),
      SearchItem(4, 'University of Waterloo'),
    ];
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
    Stack(children: <Widget>[
      Column(children: <Widget>[
        Container(
          color: Colors.grey[100],
          height: screenH(310),
          width: screenW(600),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: screenH(30),
              ),
              Container(
                height: screenH(250),
                width: screenW(370),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.35),
                          blurRadius: (20),
                          spreadRadius: (5),
                          offset: Offset(0, 5)),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: screenH(20),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: screenW(20),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(currentUserModel.displayName,
                                style: TextStyle(
                                  fontSize: screenF(18),
                                )),
                            SizedBox(
                              height: screenH(2),
                            ),
                            Text("University of Western Ontario",
                                style: TextStyle(
                                    fontSize: screenF(13),
                                    color: Colors.purple)),
                            SizedBox(
                              height: screenH(2),
                            ),
                            Text("Computer Science, 2022",
                                style: TextStyle(
                                    fontSize: screenF(13), color: Colors.grey)),
                          ],
                        ),
                        SizedBox(
                          width: screenW(70),
                        ),
                        Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(currentUserModel.photoUrl),
                              radius: 21,
                            ),

                            FlatButton(
                              onPressed: (){},
                              color: Colors.transparent,
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.edit, size: 12, color: Colors.blueAccent[700],),
                                  SizedBox(width: 2,),
                                  Text("Edit", textAlign: TextAlign.left, style: TextStyle(fontSize: 12, color: Colors.blueAccent[700]),),
                                ],
                              ),
                            )

                          ],
                        ),

                        // IconButton(
                        //   onPressed: () {},
                        //   color: Colors.black,
                        //   icon: Icon(Icons.create),
                        // )
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenW(30.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Icon(
                                FontAwesome.snapchat_square,
                                color: Color(0xFFfffc00),
                              ),
                              SizedBox(
                                width: screenW(10),
                              ),
                              Text("namrapatel9",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenF(12))),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Icon(
                                MaterialCommunityIcons.instagram,
                                color: Color(0xFF8803fc),
                              ),
                              SizedBox(
                                width: screenW(10),
                              ),
                              Text("namrajpatel",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenF(12))),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Icon(
                                MaterialCommunityIcons.twitter_box,
                                color: Colors.blue,
                              ),
                              Text("namrapatel",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenF(12))),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenH(25),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 20.0),
                        Text('Interests:',
                            style: TextStyle(
                                color: Colors.grey, fontSize: screenF(13))),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text('*interests*',
                            style: TextStyle(
                                color: Colors.black, fontSize: screenF(13)))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
            color: Colors.grey[100],
            height: screenH(415),
            child: ListView(
              children: <Widget>[
              Column(children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Name',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Theme(
                        // data: theme.copyWith(primaryColor: Colors.black),
                        data: new ThemeData(
                            primaryColor: Colors.black,
                            accentColor: Colors.black,
                            hintColor: Colors.black),
                        child: TextField(
                          decoration: InputDecoration(
                              border: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black))),
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                          cursorColor: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'University',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 800,
                      height: 70,
                      color: Colors.white,
                      child: FlutterSearchPanel<int>(
                        padding: EdgeInsets.all(10.0),
                        selected: 0,
                        title: 'Select University',
                        data: data2,
                        icon: new Icon(Icons.school, color: Colors.black),
                        color: Color(0xFFECE9E4),
                        textStyle: new TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                        onChanged: (int value) {
                          print(value);
                        },
                      ),
                    ),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 20.0),
                //   child: Column(
                //     children: <Widget>[
                //       Theme(
                //         // data: theme.copyWith(primaryColor: Colors.black),
                //         data: new ThemeData(
                //             primaryColor: Colors.black,
                //             accentColor: Colors.black,
                //             hintColor: Colors.black),
                //         child: TextField(
                //           decoration: InputDecoration(
                //               border: new UnderlineInputBorder(
                //                   borderSide:
                //                       new BorderSide(color: Colors.black))),
                //           style: TextStyle(fontSize: 18, color: Colors.grey),
                //           cursorColor: Colors.black,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Program',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Theme(
                        // data: theme.copyWith(primaryColor: Colors.black),
                        data: new ThemeData(
                            primaryColor: Colors.black,
                            accentColor: Colors.black,
                            hintColor: Colors.black),
                        child: TextField(
                          decoration: InputDecoration(
                              border: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black))),
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                          cursorColor: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Snapchat',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Theme(
                        // data: theme.copyWith(primaryColor: Colors.black),
                        data: new ThemeData(
                            primaryColor: Colors.black,
                            accentColor: Colors.black,
                            hintColor: Colors.black),
                        child: TextField(
                          decoration: InputDecoration(
                              prefixText: '@',
                              prefixStyle: TextStyle(color: Colors.grey),
                              border: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black))),
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                          cursorColor: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Instagram',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Theme(
                        // data: theme.copyWith(primaryColor: Colors.black),
                        data: new ThemeData(
                            primaryColor: Colors.black,
                            accentColor: Colors.black,
                            hintColor: Colors.black),
                        child: TextField(
                          decoration: InputDecoration(
                              prefixText: '@',
                              prefixStyle: TextStyle(color: Colors.grey),
                              border: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black))),
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                          cursorColor: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Twitter',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Theme(
                        // data: theme.copyWith(primaryColor: Colors.black),
                        data: new ThemeData(
                            primaryColor: Colors.black,
                            accentColor: Colors.black,
                            hintColor: Colors.black),
                        child: TextField(
                          decoration: InputDecoration(
                              prefixText: '@',
                              prefixStyle: TextStyle(color: Colors.grey),
                              border: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black))),
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                          cursorColor: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: 330.0,
                  child: FlutterTagging(
                    textFieldDecoration: InputDecoration(
                        labelText: "Enter interest tags",
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    addButtonWidget: _buildAddButton(),
                    chipsColor: Colors.purple[400],
                    chipsFontColor: Colors.white,
                    deleteIcon: Icon(Icons.cancel, color: Colors.white),
                    chipsPadding: EdgeInsets.all(2.0),
                    chipsFontSize: 14.0,
                    chipsSpacing: 5.0,
                    suggestionsCallback: (pattern) async {
                      return await TagSearchService.getSuggestions(pattern);
                    },
                    onChanged: (result) {
                      setState(() {
                        text = result.toString();
                      });
                    },
                  ),
                ),
              ]),
              SizedBox(
                height: 50.0,
              ),
              Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.pink),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 50,
                    child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      elevation: screenH(5),
                      onPressed: () {},
                      backgroundColor: Color(0xFFECE9E4),
                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontSize: screenF(20), color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 50,)
                ],
              )
            ]))
      ]),
    ])
      ],
    );
  }
}

class ProfessionalCardEdit extends StatefulWidget {
  @override
  _ProfessionalCardEditState createState() => _ProfessionalCardEditState();
}

class _ProfessionalCardEditState extends State<ProfessionalCardEdit> {
  Widget _buildAddButton() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.purple[400],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.add,
            color: Colors.white,
            size: 15.0,
          ),
          Text(
            "Add New Tag",
            style: TextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ],
      ),
    );
  }

  String text = "Nothing to show";
  @override
  Widget build(BuildContext context) {
    List<SearchItem<int>> data2 = [
      SearchItem(0, 'Please select your university'),
      SearchItem(1, 'University of British Columbia'),
      SearchItem(2, 'University of Calgary'),
      SearchItem(3, 'University of Western Ontario'),
      SearchItem(4, 'University of Waterloo'),
    ];
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
    Stack(children: <Widget>[
      Column(children: <Widget>[
        Container(
          color: Colors.grey[100],
          height: screenH(310),
          width: screenW(600),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: screenH(250),
                width: screenW(370),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.35),
                          blurRadius: (20),
                          spreadRadius: (5),
                          offset: Offset(0, 5)),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: screenH(20),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: screenW(20),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(currentUserModel.displayName,
                                style: TextStyle(
                                  fontSize: screenF(18),
                                )),
                            SizedBox(
                              height: screenH(2),
                            ),
                            Text("University of Western Ontario",
                                style: TextStyle(
                                    fontSize: screenF(13),
                                    color: Colors.purple)),
                            SizedBox(
                              height: screenH(2),
                            ),
                            Text("Computer Science, 2022",
                                style: TextStyle(
                                    fontSize: screenF(13), color: Colors.grey)),
                          ],
                        ),
                        SizedBox(
                          width: screenW(70),
                        ),
                        Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(currentUserModel.photoUrl),
                              radius: 21,
                            ),

                            FlatButton(
                              onPressed: (){},
                              color: Colors.transparent,
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.edit, size: 12, color: Colors.blueAccent[700],),
                                  SizedBox(width: 2,),
                                  Text("Edit", textAlign: TextAlign.left, style: TextStyle(fontSize: 12, color: Colors.blueAccent[700]),),
                                ],
                              ),
                            )
                          ],
                        ),

                        // IconButton(
                        //   onPressed: () {},
                        //   color: Colors.black,
                        //   icon: Icon(Icons.create),
                        // )
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenW(30.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Icon(
                                MaterialCommunityIcons.github_box,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: screenW(10),
                              ),
                              Text("namrapatel",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenF(12))),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Icon(
                                FontAwesome.linkedin_square,
                                color: Color(0xFF0077B5),
                              ),
                              SizedBox(
                                width: screenW(10),
                              ),
                              Text("namrapatel",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenF(12))),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Icon(
                                MaterialCommunityIcons.twitter_box,
                                color: Colors.blue,
                              ),
                              Text("namrapatel",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenF(12))),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenH(25),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 20.0),
                        Text('Interests:',
                            style: TextStyle(
                                color: Colors.grey, fontSize: screenF(13))),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text('*interests*',
                            style: TextStyle(
                                color: Colors.black, fontSize: screenF(13)))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
            color: Colors.grey[100],
            height: screenH(415),
            child: ListView(children: <Widget>[
              Column(children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Name',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Theme(
                        // data: theme.copyWith(primaryColor: Colors.black),
                        data: new ThemeData(
                            primaryColor: Colors.black,
                            accentColor: Colors.black,
                            hintColor: Colors.black),
                        child: TextField(
                          decoration: InputDecoration(
                              border: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black))),
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                          cursorColor: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'University',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 800,
                      height: 70,
                      color: Colors.white,
                      child: FlutterSearchPanel<int>(
                        padding: EdgeInsets.all(10.0),
                        selected: 0,
                        title: 'Select University',
                        data: data2,
                        icon: new Icon(Icons.school, color: Colors.black),
                        color: Color(0xFFECE9E4),
                        textStyle: new TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                        onChanged: (int value) {
                          print(value);
                        },
                      ),
                    ),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 20.0),
                //   child: Column(
                //     children: <Widget>[
                //       Theme(
                //         // data: theme.copyWith(primaryColor: Colors.black),
                //         data: new ThemeData(
                //             primaryColor: Colors.black,
                //             accentColor: Colors.black,
                //             hintColor: Colors.black),
                //         child: TextField(
                //           decoration: InputDecoration(
                //               border: new UnderlineInputBorder(
                //                   borderSide:
                //                       new BorderSide(color: Colors.black))),
                //           style: TextStyle(fontSize: 18, color: Colors.grey),
                //           cursorColor: Colors.black,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Program',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Theme(
                        // data: theme.copyWith(primaryColor: Colors.black),
                        data: new ThemeData(
                            primaryColor: Colors.black,
                            accentColor: Colors.black,
                            hintColor: Colors.black),
                        child: TextField(
                          decoration: InputDecoration(
                              border: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black))),
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                          cursorColor: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'GitHub',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Theme(
                        // data: theme.copyWith(primaryColor: Colors.black),
                        data: new ThemeData(
                            primaryColor: Colors.black,
                            accentColor: Colors.black,
                            hintColor: Colors.black),
                        child: TextField(
                          decoration: InputDecoration(
                              prefixText: '@',
                              prefixStyle: TextStyle(color: Colors.grey),
                              border: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black))),
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                          cursorColor: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'LinkedIn',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Theme(
                        // data: theme.copyWith(primaryColor: Colors.black),
                        data: new ThemeData(
                            primaryColor: Colors.black,
                            accentColor: Colors.black,
                            hintColor: Colors.black),
                        child: TextField(
                          decoration: InputDecoration(
                              prefixText: '@',
                              prefixStyle: TextStyle(color: Colors.grey),
                              border: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black))),
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                          cursorColor: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Twitter',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Theme(
                        // data: theme.copyWith(primaryColor: Colors.black),
                        data: new ThemeData(
                            primaryColor: Colors.black,
                            accentColor: Colors.black,
                            hintColor: Colors.black),
                        child: TextField(
                          decoration: InputDecoration(
                              prefixText: '@',
                              prefixStyle: TextStyle(color: Colors.grey),
                              border: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black))),
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                          cursorColor: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: 330.0,
                  child: FlutterTagging(
                    textFieldDecoration: InputDecoration(
                        labelText: "Enter interest tags",
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    addButtonWidget: _buildAddButton(),
                    chipsColor: Colors.purple[400],
                    chipsFontColor: Colors.white,
                    deleteIcon: Icon(Icons.cancel, color: Colors.white),
                    chipsPadding: EdgeInsets.all(2.0),
                    chipsFontSize: 14.0,
                    chipsSpacing: 5.0,
                    suggestionsCallback: (pattern) async {
                      return await TagSearchService.getSuggestions(pattern);
                    },
                    onChanged: (result) {
                      setState(() {
                        text = result.toString();
                      });
                    },
                  ),
                ),
              ]),
              SizedBox(
                height: 50.0,
              ),
              Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.pink),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 50,
                    child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      elevation: screenH(5),
                      onPressed: () {},
                      backgroundColor: Color(0xFFECE9E4),
                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontSize: screenF(20), color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 50,)
                ],
              )
            ]))
      ]),
    ])
      ],
    );
  }
}

class CardEdit extends StatefulWidget {
  @override
  _CardEditState createState() => _CardEditState();
}

class _CardEditState extends State<CardEdit> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Row(
            children: <Widget>[
              SizedBox(
                width: 8,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                color: Colors.black,
                icon: Icon(Icons.arrow_back_ios),
              ),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Color(0xFFECE9E4),
          title: Text(' '),
          bottom: TabBar(
            indicatorColor: Colors.black,
            tabs: <Widget>[
              Tab(
                child: Text(
                  'Social',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              ),
              Tab(
                child: Text(
                  'Professional',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [SocialCardEdit(), ProfessionalCardEdit()],
        ),
      ),
    );
  }
}

class TagSearchService {
  static Future<List> getSuggestions(String query) async {
    await Future.delayed(Duration(milliseconds: 400), null);
    List<dynamic> tagList = <dynamic>[];
    tagList.add({'name': "Flutter", 'value': 1});
    tagList.add({'name': "HummingBird", 'value': 2});
    tagList.add({'name': "Dart", 'value': 3});
    List<dynamic> filteredTagList = <dynamic>[];
    if (query.isNotEmpty) {
      filteredTagList.add({'name': query, 'value': 0});
    }
    for (var tag in tagList) {
      if (tag['name'].toLowerCase().contains(query)) {
        filteredTagList.add(tag);
      }
    }
    return filteredTagList;
  }
}
