import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'login.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'viewCards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

List<String> socialInterests = [];

class SocialInterestTile extends StatefulWidget {
  SocialInterestTile(this.interest);
  final String interest;

  @override
  _SocialInterestTileState createState() => _SocialInterestTileState();
}

class _SocialInterestTileState extends State<SocialInterestTile> {
  bool value1 = false;

  @override
  Widget build(BuildContext context) {
    if (socialInterests.contains(widget.interest)) {
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
                                socialInterests.add(widget.interest);
                                if (socialInterests.length == 3) {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: SocialInterestPage(
                                              interests: socialInterests)));
                                }
                              } else {
                                socialInterests.remove(widget.interest);
                              }

                              Set<String> selections = socialInterests.toSet();
                              print(selections);
                              socialInterests = selections.toList();
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

class SocialInterestPage extends StatefulWidget {
  const SocialInterestPage({this.interests});
  final List<String> interests;

  @override
  _SocialInterestPageState createState() =>
      _SocialInterestPageState(this.interests);
}

class _SocialInterestPageState extends State<SocialInterestPage> {
  final List<String> interests;
  _SocialInterestPageState(this.interests);
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
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(
                  Entypo.drink,
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
                color: Color(0xFF8803fc),
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Firestore.instance
                      .collection('users')
                      .document(currentUserModel.uid)
                      .collection('socialcard')
                      .document(socialCardId)
                      .updateData({'interests': interests});
                  Firestore.instance
                      .collection('users')
                      .document(currentUserModel.uid)
                      .updateData({'socialInterests': interests});
                  socialInterests.clear();
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
                color: Color(0xFF8803fc),
                child: Text(
                  "Edit Interests",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  socialInterests.clear();
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

class SocialDataSearch extends SearchDelegate<String> {
  Iterable<SocialInterestTile> suggestions = [];
  dynamic suggestionList = [];
  List<SocialInterestTile> interestList = [
    new SocialInterestTile("Music"),
    new SocialInterestTile("Sports"),
    new SocialInterestTile("Food"),
    new SocialInterestTile("Travel"),
    new SocialInterestTile("Athletics"),
    new SocialInterestTile("Gaming"),
    new SocialInterestTile("Winter Sports"),
    new SocialInterestTile("Hiking"),
    new SocialInterestTile("Movies"),
    new SocialInterestTile("Art"),
    new SocialInterestTile("Fasion"),
    new SocialInterestTile("Adventure"),
    new SocialInterestTile("Books"),
    new SocialInterestTile("Anime"),
    new SocialInterestTile("Theatre"),
    new SocialInterestTile("Photography"),
    new SocialInterestTile("Pets"),
    new SocialInterestTile("Outdoors"),
    new SocialInterestTile("Volunteering"),
    new SocialInterestTile("Automotives"),
    new SocialInterestTile("Cooking"),
    new SocialInterestTile("Drama"),
    new SocialInterestTile("E-Sports"),
    new SocialInterestTile("Writing"),
    new SocialInterestTile("Working Out"),
    new SocialInterestTile("Partying"),
    new SocialInterestTile("Band"),
    new SocialInterestTile("Dance"),
    new SocialInterestTile("TV Shows"),
    new SocialInterestTile("Technology"),
    new SocialInterestTile("Water Sports"),
    new SocialInterestTile("Hip Hop"),
    new SocialInterestTile("Pop"),
    new SocialInterestTile("R&B"),
    new SocialInterestTile("Guitar"),
    new SocialInterestTile("Piano"),
    new SocialInterestTile("Band"),
    new SocialInterestTile("Camping"),
    new SocialInterestTile("Classical"),
    new SocialInterestTile("Jazz"),
    new SocialInterestTile("K-Pop"),
    new SocialInterestTile("Blues"),
    new SocialInterestTile("Rock Music"),
    new SocialInterestTile("Metal Music"),
    new SocialInterestTile("Techno"),
    new SocialInterestTile("Concerts"),
    new SocialInterestTile("Music Festivals"),
    new SocialInterestTile("Technology"),
    new SocialInterestTile("Fiction Books"),
    new SocialInterestTile("Swimming"),
    new SocialInterestTile("Rowing"),
    new SocialInterestTile("Mountain Climbing"),
    new SocialInterestTile("Basketball"),
    new SocialInterestTile("Baseball"),
    new SocialInterestTile("Track and Field"),
    new SocialInterestTile("Hockey"),
    new SocialInterestTile("Golf"),
    new SocialInterestTile("Lacrosse"),
    new SocialInterestTile("Comics"),
    new SocialInterestTile("Fishing"),
    new SocialInterestTile("Horseback Riding"),
    new SocialInterestTile("Badminton"),
    new SocialInterestTile("Tennis"),
    new SocialInterestTile("Volleyball"),
    new SocialInterestTile("Biking"),
    new SocialInterestTile("Soccer"),
    new SocialInterestTile("ATV"),
    new SocialInterestTile("Gymnastics"),
    new SocialInterestTile("Cricket"),
    new SocialInterestTile("Football"),
    new SocialInterestTile("Rugby"),
    new SocialInterestTile("NBA"),
    new SocialInterestTile("NHL"),
    new SocialInterestTile("MLB"),
    new SocialInterestTile("NFL"),
    new SocialInterestTile("Snowboarding"),
    new SocialInterestTile("Skiing"),
    new SocialInterestTile("Skating"),
    new SocialInterestTile("Technology"),
    new SocialInterestTile("Wine"),
    new SocialInterestTile("Fine Dining"),
    new SocialInterestTile("Backpacking"),
    new SocialInterestTile("Classic Movies"),
    new SocialInterestTile("Horror Films"),
    new SocialInterestTile("Indie Films"),
    new SocialInterestTile("Painting"),
    new SocialInterestTile("Sneakerheads"),
    new SocialInterestTile("Sculpting"),
    new SocialInterestTile("Poetry"),
    new SocialInterestTile("Cars"),
    new SocialInterestTile("Baking"),
    new SocialInterestTile("Cosmetics"),
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
          socialInterests.clear();
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
