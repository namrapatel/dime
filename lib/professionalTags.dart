import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'login.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'viewCards.dart';

import 'homePage.dart';

List<String> profInterests = [];

class ProfInterestTile extends StatefulWidget {
  ProfInterestTile(this.interest);
  final String interest;

  @override
  _ProfInterestTileState createState() => _ProfInterestTileState();
}

class _ProfInterestTileState extends State<ProfInterestTile> {
  bool value1 = false;

  @override
  Widget build(BuildContext context) {
    if (profInterests.contains(widget.interest)) {
      setState(() {
        value1 = true;
      });
    } else {
      setState(() {
        value1 = false;
      });
    }

    return Container(
        decoration: BoxDecoration(color: Colors.white),
        height: screenH(97),
        width: screenW(372),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
                onTap: () {},
                trailing: Container(
                  height: screenH(97),
                  width: screenW(200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Checkbox(
                          activeColor: Colors.black,
                          checkColor: Colors.white,
                          value: value1,
                          onChanged: (bool value) {
                            setState(() {
                              value1 = value;
                              if (value1 == true) {
                                profInterests.add(widget.interest);
                                if (profInterests.length == 3) {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              ProfInterestPage(
                                                  interests: profInterests)));
                                }
                              } else {
                                profInterests.remove(widget.interest);
                              }

                              Set<String> selections = profInterests.toSet();
                              print(selections);
                              profInterests = selections.toList();
                            });
                          }),
                    ],
                  ),
                ),
                title: Text(widget.interest)),
            Divider(
              color: Colors.grey[400],
              height: screenH(1),
            )
          ],
        ));
  }
}
//}

class ProfInterestPage extends StatefulWidget {
  const ProfInterestPage({this.interests});
  final List<String> interests;

  @override
  _ProfInterestPageState createState() =>
      _ProfInterestPageState(this.interests);
}

class _ProfInterestPageState extends State<ProfInterestPage> {
  final List<String> interests;
  _ProfInterestPageState(this.interests);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      child: Column(
        children: <Widget>[
          SizedBox(height: screenH(100)),
          Text("Selected Interests",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          SizedBox(height: screenH(10)),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: Center(
              child: Text(
                "Here are your 3 chosen interests. Remember to save the changes on the editing screen.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            height: screenH(30),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.08,
            height: MediaQuery.of(context).size.height / 900,
            color: Colors.grey[300],
          ),
          SizedBox(height: screenH(10)),
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(
                  MaterialCommunityIcons.account_tie,
                  color: Colors.black,
                ),
                trailing: Icon(
                  Icons.done,
                  color: Colors.black,
                ),
                title: Text(interests[index]),
              );
            },
            itemCount: interests.length,
            shrinkWrap: true,
          ),
          SizedBox(
            height: screenH(20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                color: Color(0xFF1976d2),
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Firestore.instance
                      .collection('users')
                      .document(currentUserModel.uid)
                      .collection('profcard')
                      .document('prof')
                      .updateData({'interests': interests});
                  Firestore.instance
                      .collection('users')
                      .document(currentUserModel.uid)
                      .updateData({'profInterests': interests});
                  profInterests.clear();

                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                width: screenW(20),
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                color: Color(0xFF1976d2),
                child: Text(
                  "Edit Interests",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  profInterests.clear();
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ],
      ),
    ));
  }
}

