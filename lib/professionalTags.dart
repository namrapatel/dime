import 'package:Dime/homePage.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:fancy_on_boarding/page_model.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

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
        title: Text("Choose Social Interest Tags"),
      ),
      body: SingleChildScrollView(
        //physics: NeverScrollableScrollPhysics(),
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

            SizedBox(
              height: 10.0,
            ),
                      Container(
                      //color: Colors.white,
                      width: MediaQuery.of(context).size.width / 1.1,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 22,
                            vertical: MediaQuery.of(context).size.height / 72),
                        child: TextField(
                          decoration: new InputDecoration(
                              icon: Icon(Icons.search),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 30,
                                  bottom: MediaQuery.of(context).size.height / 75,
                                  top: MediaQuery.of(context).size.height / 75,
                                  right: MediaQuery.of(context).size.width / 30),
                              hintText: 'Search for Interests'),
                        ),
                      ),
                ),
            SizedBox(
              height: 10.0,
            ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Startups; Philosophy; Engineering;',
                    style: TextStyle(
                     color: Color(0xFF1976d2), fontSize: 13)),
                  OutlineButton(
                  padding: EdgeInsets.all(5),
                  color: Color(0xFF8803fc),
                  child: new Text("Save tags", style: TextStyle(color: Color(0xFF1976d2), fontSize: 15),),
                 onPressed: (){
                            },
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0))
                          )
                  ],
                ),
                _myListView2(context)
          ],
        ),
      ),
    );
  }

    Widget _myListView2(BuildContext context) {
      return CheckboxGroup(
      checkColor: Colors.white,
      activeColor: Color(0xFF1976d2),
      labels: <String>[
        "Startups",
        "Tech Companies",
        "Arts",
        "Philosophy",
        "Engineering",
        "Music",
        "Painting",
        "Drama and Theatre",
        "Supply Chain",
        "Machine Learning", 
        "Engineering"

      
      ],
      onChange: (bool isChecked, String label, int index) => print("isChecked: $isChecked   label: $label  index: $index"),
      onSelected: (List<String> checked) => print("checked: ${checked.toString()}"),
    );
    }


}

