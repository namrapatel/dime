import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:search_widget/search_widget.dart';

import 'package:Dime/homePage.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:fancy_on_boarding/page_model.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'EditCardsScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Dime/homePage.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:fancy_on_boarding/page_model.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'EditCardsScreen.dart';

List<String> interests=[];
class SocialTags extends StatefulWidget {
  final String title = '';
  @override
  _SocialTagsStage createState() => _SocialTagsStage();
}

class _SocialTagsStage extends State<SocialTags> {
  BuildContext context;
//  List<String> interests=[];
  int counter=0;
  @override
  void initState() {
    super.initState();
  }

  setInterests(){
    Firestore.instance.collection('users').document(currentUserModel.uid).collection('socialcard').document(socialCardId)
        .updateData({
      'interests': interests
    });

  }

//  String text = "Nothing to show";


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Social Interest Tags"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height/30,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width/30,
                ),
                Text("Choose a max of 3"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlutterTagging(
                textFieldDecoration: InputDecoration(
                    border: OutlineInputBorder(

                    ),
                    hintText: "Tags",
                    labelText: "Search for Tags"),
                addButtonWidget: _buildAddButton(),
                chipsColor: Color(0xFF8803fc),
                chipsFontColor: Colors.white,
                deleteIcon: Icon(Icons.cancel,color: Colors.white),
                chipsPadding: EdgeInsets.all(2.0),
                chipsFontSize: 14.0,
                chipsSpacing: 5.0,
                chipsFontFamily: 'Futura',
                suggestionsCallback: (pattern) async {
                  return await TagSearchService.getSuggestions(pattern);
                },
                onChanged: (result) {
                  setState(() {
                    interests.add(result[counter]['name']);

                    counter++;

                  });
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
                child: new OutlineButton(
                    padding: EdgeInsets.all(15),
                    color: Color(0xFF8803fc),
                    child: new Text("Save tags to social card", style: TextStyle(color: Color(0xFF8803fc), fontSize: 15),),
                    onPressed: (){
                      setInterests();

                    },
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                )
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.pinkAccent,
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










}


class TagSearchService {
  static Future<List> getSuggestions(String query) async {
    await Future.delayed(Duration(milliseconds: 400), null);
    List<dynamic> tagList = <dynamic>[];
    tagList.add({'name': "Flutter", 'value': 1});
    tagList.add({'name': "HummingBird", 'value': 2});
    tagList.add({'name': "Dart", 'value': 3});
    tagList.add({'name': "Watching movies", 'value': 4});
    tagList.add({'name': "Listening to music", 'value': 5});
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

class InterestTile extends StatefulWidget{
  InterestTile(this.interest);
  final String interest;


  @override
  _InterestTileState createState() => _InterestTileState();
}

class _InterestTileState extends State<InterestTile> {
  bool value1 = false;



  @override
  Widget build(BuildContext context) {
    if(interests.contains(widget.interest)){
      setState(() {
        value1=true;
      });
    }else{
      setState(() {
        value1=false;
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
              onTap: (){

              },
//              leading: Text(
//                widget.interest
//              ),
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
                            value1=value;
                            if(value1==true){
                              interests.add(widget.interest);
                            }else{
                              interests.remove(widget.interest);
                            }

//                            if(widget.uid==currentUserModel.uid) {
//                              value1 = false;
//                            }else {
//                              value1=value;
//                              if (value1 == true) {
//                                selectedUsersUids.add(widget.uid);
//                              } else {
//                                selectedUsersUids.remove(widget.uid);
//
//                              }
//                            }
                            Set<String> selections=interests.toSet();
                            print(selections);
                            interests= selections.toList();
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

class DataSearch extends SearchDelegate<
    String> {
  Iterable<InterestTile> suggestions=[];
  dynamic suggestionList=[];
  List<InterestTile> interestList=[new InterestTile("Badminton"),new InterestTile("Flutter")
    ,new InterestTile("Basketball")
    ,new InterestTile("Philosophy")
    ,new InterestTile("Acting")
    ,new InterestTile("Music")
    ,new InterestTile("Painting")
    ,new InterestTile("Startups")
    ,new InterestTile( "Watching Movies")
   ,new InterestTile("Pop music")
    ,new InterestTile("Social Ventures")

  ];

//  final recentSearches=[ContactTile('Dhruv Patel','https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=2250762621659276&height=800&width=800&ext=1565358714&hash=AeTMZgz--e2JNS2J','bK5iO87AyBbyUtkRXOiyGEfVis83',)];


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

    suggestions=query.isEmpty?[]:interestList.where((interest)=>(interest.interest.toLowerCase().contains(query)));
//    for(var suggestion in suggestionList){
//      suggestions.add(new InterestTile(suggestion));
//    }
//    print(suggestionList);
//    print('suggestionlist');
  suggestions.toList();
    print(suggestions);
    print('suggestions');
//    suggestionList= query.isEmpty?[]: allUsers.where(
//            (contact)=>(contact.phoneNumber==null?
//
//        ((contact.contactName.startsWith(query))):
//        ((contact.contactName.startsWith(query))|| ((contact.phoneNumber.startsWith(query)))))).toList();

    return
      ListView.builder(
          shrinkWrap: true,

          itemBuilder: (BuildContext context, int index) {
            return suggestions.toList()[index];
          },itemCount: suggestions.length);


  }

}

//
//List<String> interests=[];
//class SocialTags extends StatefulWidget {
//  @override
//  _SocialTagsState createState() => _SocialTagsState();
//}
//
//class _SocialTagsState extends State<SocialTags> {
//  List<SelectedItemWidget> selectedItems=[];
//  List<LeaderBoard> list = <LeaderBoard>[
//    LeaderBoard("Badminton"),
//    LeaderBoard("Flutter"),
//    LeaderBoard("Basketball"),
//    LeaderBoard("Philosophy"),
//    LeaderBoard("Acting"),
//    LeaderBoard("Music"),
//    LeaderBoard("Painting"),
//    LeaderBoard("Startups"),
//    LeaderBoard("Watching Movies"),
//    LeaderBoard("Pop music"),
//    LeaderBoard("Social Ventures"),
//
//  ];
//
//  setInterests(){
//    Firestore.instance.collection('users').document(currentUserModel.uid).collection('socialcard').document(socialCardId)
//        .updateData({
//      'interests': interests
//    });
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Search Widget"),
//      ),
//      body: Container(
//        child: SingleChildScrollView(
//          padding: EdgeInsets.symmetric(vertical: 16.0),
//          child: Column(
//            children: <Widget>[
//              SizedBox(
//                height: 16.0,
//              ),
//              SearchWidget<LeaderBoard>(
//                dataList: list,
//                hideSearchBoxWhenItemSelected: false,
//                listContainerHeight: MediaQuery.of(context).size.height / 4,
//                queryBuilder: (String query, List<LeaderBoard> list) {
//a
//                  return list.where((LeaderBoard item) => item.username.toLowerCase().contains(query.toLowerCase())).toList();
//                },
//                popupListItemBuilder: (LeaderBoard item) {
//                  return PopupListItemWidget(item);
//                },
//                selectedItemBuilder: (LeaderBoard selectedItem, VoidCallback deleteSelectedItem) {
//                  interests.add(selectedItem.username);
//
//                    selectedItems.add(SelectedItemWidget(selectedItem, deleteSelectedItem));
//
//
//                   return Container(
//                      decoration: BoxDecoration(color: Colors.white),
//                      child: ListView.builder(
//                        shrinkWrap: true,
//                        itemBuilder: (BuildContext context, int index) {
//
//                          return selectedItems[index];
//                        },
//                        itemCount: selectedItems.length,
//                      ));
//
//                },
//                // widget customization
//                noItemsFoundWidget: NoItemsFound(),
//                textFieldBuilder: (TextEditingController controller, FocusNode focusNode) {
//                  return MyTextField(controller, focusNode);
//                },
//              ),
////              OutlineButton(
////                  padding: EdgeInsets.all(5),
////                  color: Color(0xFF8803fc),
////                  child: new Text("Save tags", style: TextStyle(color: Color(0xFF1976d2), fontSize: 15),),
////                  onPressed: (){
////                    setInterests();
////                  },
////                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0))
////              )
//
//
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
//
//class LeaderBoard {
//  final String username;
//
//
//  LeaderBoard(this.username);
//}
//
//class SelectedItemWidget extends StatelessWidget {
//  final LeaderBoard selectedItem;
//  final VoidCallback deleteSelectedItem;
//
//
//  SelectedItemWidget(this.selectedItem, this.deleteSelectedItem);
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      padding: EdgeInsets.symmetric(
//        vertical: 2.0,
//        horizontal: 4.0,
//      ),
//      child: Row(
//        children: <Widget>[
//          Expanded(
//            child: Padding(
//              padding: const EdgeInsets.only(
//                left: 16,
//                right: 16,
//                top: 8,
//                bottom: 8,
//              ),
//              child: Text(
//                selectedItem.username,
//                style: TextStyle(fontSize: 14),
//              ),
//            ),
//          ),
//          IconButton(
//            icon: Icon(Icons.delete_outline, size: 22),
//            color: Colors.grey[700],
//            onPressed:
//              deleteSelectedItem
//
//
//
//          ),
//        ],
//      ),
//    );
//  }
//}
//
//class MyTextField extends StatelessWidget {
//  final TextEditingController controller;
//  final FocusNode focusNode;
//
//  MyTextField(this.controller, this.focusNode);
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//      child: TextField(
//        controller: controller,
//        focusNode: focusNode,
//        style: new TextStyle(fontSize: 16, color: Colors.grey[600]),
//        decoration: InputDecoration(
//          enabledBorder: OutlineInputBorder(
//            borderSide: BorderSide(color: Color(0x4437474F)),
//          ),
//          focusedBorder: OutlineInputBorder(
//            borderSide: BorderSide(color: Theme
//                .of(context)
//                .primaryColor),
//          ),
//          suffixIcon: Icon(Icons.search),
//          border: InputBorder.none,
//          hintText: "Search here...",
//          contentPadding: EdgeInsets.only(
//            left: 16,
//            right: 20,
//            top: 14,
//            bottom: 14,
//          ),
//        ),
//      ),
//    );
//  }
//}
//
//class NoItemsFound extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Row(
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          Icon(
//            Icons.folder_open,
//            size: 24,
//            color: Colors.grey[900].withOpacity(0.7),
//          ),
//          SizedBox(width: 10.0),
//          Text(
//            "No Items Found",
//            style: TextStyle(
//              fontSize: 16.0,
//              color: Colors.grey[900].withOpacity(0.7),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
//
//class PopupListItemWidget extends StatelessWidget {
//  final LeaderBoard item;
//
//  PopupListItemWidget(this.item);
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      padding: const EdgeInsets.all(12.0),
//      child: Text(
//        item.username,
//        style: TextStyle(fontSize: 16.0),
//      ),
//    );
//  }
//}

//
//import 'package:Dime/homePage.dart';
//import 'package:fancy_on_boarding/fancy_on_boarding.dart';
//import 'package:fancy_on_boarding/page_model.dart';
//import 'package:flutter/material.dart';
//import 'login.dart';
//import 'package:flutter_tagging/flutter_tagging.dart';
//import 'package:grouped_buttons/grouped_buttons.dart';
//import 'EditCardsScreen.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//class SocialTags extends StatefulWidget {
//  final String title = '';
//  @override
//  _SocialTagsStage createState() => _SocialTagsStage();
//}
//
//class _SocialTagsStage extends State<SocialTags> {
//  BuildContext context;
//List<String> interests=[];
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  setInterests(){
//    Firestore.instance.collection('users').document(currentUserModel.uid).collection('socialcard').document(socialCardId)
//        .updateData({
//      'interests': interests
//    });
//
//  }
//
//  String text = "Nothing to show";
//
//
//  @override
//  Widget build(BuildContext context) {
//
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Choose Social Interest Tags"),
//      ),
//      body: SingleChildScrollView(
//        //physics: NeverScrollableScrollPhysics(),
//        child: Column(
//          children: <Widget>[
//            SizedBox(
//              height: MediaQuery.of(context).size.height/30,
//            ),
//            Row(
//              children: <Widget>[
//                SizedBox(
//                  width: MediaQuery.of(context).size.width/30,
//                ),
//                Text("Choose a max of 3"),
//              ],
//            ),
//
//            SizedBox(
//              height: 10.0,
//            ),
//            Container(
//              //color: Colors.white,
//              width: MediaQuery.of(context).size.width / 1.1,
//              decoration: BoxDecoration(
//                  color: Colors.grey[200],
//                  borderRadius: BorderRadius.circular(20)),
//              child: Padding(
//                padding: EdgeInsets.symmetric(
//                    horizontal: MediaQuery.of(context).size.width / 22,
//                    vertical: MediaQuery.of(context).size.height / 72),
//                child: TextField(
//                  decoration: new InputDecoration(
//                      icon: Icon(Icons.search),
//                      border: InputBorder.none,
//                      focusedBorder: InputBorder.none,
//                      contentPadding: EdgeInsets.only(
//                          left: MediaQuery.of(context).size.width / 30,
//                          bottom: MediaQuery.of(context).size.height / 75,
//                          top: MediaQuery.of(context).size.height / 75,
//                          right: MediaQuery.of(context).size.width / 30),
//                      hintText: 'Search for Interests'),
//                ),
//              ),
//            ),
//            SizedBox(
//              height: 10.0,
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Text('Badminton; Philosophy; Comedy Movies;',
//                    style: TextStyle(
//                        color: Color(0xFF8803fc), fontSize: 13)),
//                OutlineButton(
//                    padding: EdgeInsets.all(5),
//                    color: Color(0xFF8803fc),
//                    child: new Text("Save tags", style: TextStyle(color: Color(0xFF8803fc), fontSize: 15),),
//                    onPressed: (){
//                    },
//                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0))
//                )
//              ],
//            ),
//            _myListView2(context)
//          ],
//        ),
//      ),
//    );
//  }
//
//  Widget _myListView2(BuildContext context) {
//    return CheckboxGroup(
//      checkColor: Colors.white,
//      activeColor: Color(0xFF8803fc),
//      labels: <String>[
//        "Badminton",
//        "Flutter",
//        "Basketball",
//        "Philosophy",
//        "Acting",
//        "Music",
//        "Painting",
//        "Startups",
//        "Watching Movies",
//        "Pop music",
//        "Social Ventures"
//
//
//      ],
//      onChange: (bool isChecked, String label, int index) => print("isChecked: $isChecked   label: $label  index: $index"),
//      onSelected: (List<String> checked) => print("checked: ${checked.toString()}"),
//    );
//  }
//
//
//
//
//
//
//
//
//
//
//}