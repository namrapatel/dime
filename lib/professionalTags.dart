import 'package:Dime/homePage.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:fancy_on_boarding/page_model.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:flutter_tagging/flutter_tagging.dart';

class ProfTags extends StatefulWidget {
  final String title = '';
  @override
  _ProfTagsState createState() => _ProfTagsState();
}

class _ProfTagsState extends State<ProfTags> {
  BuildContext context;

  @override
  void initState() {
    super.initState();
  }

  String text = "Nothing to show";
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Professional Interest Tags"),
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
                    text = result.toString();
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
                  child: new Text("Save tags to professional card", style: TextStyle(color: Color(0xFF1976d2), fontSize: 15),),
                 onPressed: (){
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