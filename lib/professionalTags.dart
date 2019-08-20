import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'login.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'viewCards.dart';

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
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: ProfInterestPage(
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
                      .document(profCardId)
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

class ProfDataSearch extends SearchDelegate<String> {
  Iterable<ProfInterestTile> suggestions = [];
  dynamic suggestionList = [];
  List<ProfInterestTile> interestList = [
    new ProfInterestTile("Philosophy"),
    new ProfInterestTile("Business"),
    new ProfInterestTile("Finance"),
    new ProfInterestTile("Social Work"),
    new ProfInterestTile("Software"),
    new ProfInterestTile("Chemistry"),
    new ProfInterestTile("Health Care"),
    new ProfInterestTile("Product Management"),
    new ProfInterestTile("Law"),
    new ProfInterestTile("Art"),
    new ProfInterestTile("Technology"),
    new ProfInterestTile("History"),
    new ProfInterestTile("Management"),
    new ProfInterestTile("Aviation"),
    new ProfInterestTile("Data"),
    new ProfInterestTile("Economics"),
    new ProfInterestTile("Fitness"),
    new ProfInterestTile("Math"),
    new ProfInterestTile("Biology"),
    new ProfInterestTile("Banking"),
    new ProfInterestTile("Literature"),
    new ProfInterestTile("Marketing"),
    new ProfInterestTile("Computer Science"),
    new ProfInterestTile("Research"),
    new ProfInterestTile("Physics"),
    new ProfInterestTile("Startups"),
    new ProfInterestTile("Design"),
    new ProfInterestTile("Trading"),
    new ProfInterestTile("Commerce"),
    new ProfInterestTile("Linguistics"),
    new ProfInterestTile("Politics"),
    new ProfInterestTile("Supply Chain"),
    new ProfInterestTile("Software"),
    new ProfInterestTile("Neuroscience"),
    new ProfInterestTile("Engineering"),
    new ProfInterestTile("Film"),
    new ProfInterestTile("Accounting"),
    new ProfInterestTile("Agriculture"),
    new ProfInterestTile("Anthropology"),
    new ProfInterestTile("Architecture"),
    new ProfInterestTile("Archaeology"),
    new ProfInterestTile("Bioengineering"),
    new ProfInterestTile("Geosciences"),
    new ProfInterestTile("Statistics"),
    new ProfInterestTile("Kinesiology"),
    new ProfInterestTile("Microbiology"),
    new ProfInterestTile("E-Commerce"),
    new ProfInterestTile("Political Science"),
    new ProfInterestTile("Pre-medicine"),
    new ProfInterestTile("Sociology"),
    new ProfInterestTile("Machine Learning"),
    new ProfInterestTile("Artificial Intelligence"),
    new ProfInterestTile("Design"),
    new ProfInterestTile("Construction"),
    new ProfInterestTile("Higher Education"),
    new ProfInterestTile("Economics"),
    new ProfInterestTile("Entrepreneurship"),
    new ProfInterestTile("Economics"),
    new ProfInterestTile("Investmenting"),
    new ProfInterestTile("Trading"),
    new ProfInterestTile("Cosmetics"),
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading

    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          profInterests.clear();
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults

    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    print('less than 3 interests');
    suggestions = query.isEmpty
        ? interestList
        : interestList.where(
            (interest) => (interest.interest.toLowerCase().contains(query)));
    suggestions.toList();
    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return suggestions.toList()[index];
        },
        itemCount: suggestions.length);
  }
}
