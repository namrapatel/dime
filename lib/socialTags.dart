
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'login.dart';
import 'EditCardsScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<String> socialInterests=[];

class SocialInterestTile extends StatefulWidget{
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
                  onTap: () {
                  },

                  trailing: Container(
                    height: screenH(97),
                    width: screenW(200),
                    child: Row(
                      children: <Widget>[

                        SizedBox(width: 150),

                        Checkbox(
                            activeColor: Colors.black,
                            checkColor: Colors.white,
                            value: value1,
                            onChanged: (bool value) {
                              setState(() {
                                value1 = value;
                                if (value1 == true) {
                                  socialInterests.add(widget.interest);
                                  if(socialInterests.length==3){
                                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: SocialInterestPage(interests:socialInterests)));
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

                  title: Text(widget.interest)
              ),
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
  _SocialInterestPageState createState() => _SocialInterestPageState(this.interests);
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
                SizedBox(height: screenH(10)),
                Text("Selected Interests"),
                SizedBox(height: screenH(10)),
                ListView.builder(itemBuilder:

                    (BuildContext context, int index) {
                      return ListTile(
                        title:Text( interests[index]),
                      );
                    },itemCount: interests.length,shrinkWrap: true, ),
                RaisedButton(
                  child: Text("Save"),
                  onPressed: (){

                      Firestore.instance.collection('users').document(currentUserModel.uid).collection('socialcard').document(socialCardId)
                          .updateData({
                        'interests': interests
                      });

                      Navigator.pop(context);
                      Navigator.pop(context);
                  },
                ),
                RaisedButton(
                  child: Text("Edit Interests"),
                  onPressed: (){
                          interests.clear();
                          Navigator.pop(context);



                  },
                )


              ],
            ),
          )
      );
  }
}

class SocialDataSearch extends SearchDelegate<
    String> {
  Iterable<SocialInterestTile> suggestions=[];
  dynamic suggestionList=[];
  List<SocialInterestTile> interestList=[new SocialInterestTile("Badminton"),new SocialInterestTile("Flutter")
    ,new SocialInterestTile("Basketball")
    ,new SocialInterestTile("Philosophy")
    ,new SocialInterestTile("Acting")
    ,new SocialInterestTile("Music")
    ,new SocialInterestTile("Painting")
    ,new SocialInterestTile("Startups")
    ,new SocialInterestTile( "Watching Movies")
   ,new SocialInterestTile("Pop music")
    ,new SocialInterestTile("Social Ventures")

  ];


  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(
      icon: Icon(Icons.clear),
      onPressed: (){
        query='';

      },
    )];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading

    return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: (){
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
      suggestions =
      query.isEmpty ? [] : interestList.where((interest) => (interest.interest
          .toLowerCase().contains(query)));
      suggestions.toList();
      return
        ListView.builder(
            shrinkWrap: true,

            itemBuilder: (BuildContext context, int index) {
              return suggestions.toList()[index];
            }, itemCount: suggestions.length);

  }

}

