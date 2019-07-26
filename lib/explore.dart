import 'package:Dime/socialPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sticky_infinite_list/sticky_infinite_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'profAtEvent.dart';
import 'package:circular_splash_transition/circular_splash_transition.dart';
import 'package:page_transition/page_transition.dart';
import 'homePage.dart';
import 'login.dart';
import 'EditCardsScreen.dart';
import 'package:xlive_switch/xlive_switch.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {

void _settingModalBottomSheet(context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
          return Container(
            height: MediaQuery.of(context).size.height,
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                backgroundColor: Color(0xFFECE9E4),
                appBar: AppBar(
                  title: Text("Filter by"),
                  bottom: TabBar(
                    tabs: <Widget>[
                  Tab(icon: Icon(MaterialCommunityIcons.bus_school), text: "School",),
                  Tab(icon: Icon(FontAwesome.book), text: "Interests",),
                  Tab(icon: Icon(Entypo.graduation_cap), text: "Grad Year",),
                    ],
                  ),
                ),
                body: TabBarView(
            children: [
              ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: _myListView(context),
                      )
                      
                    ],
                  )
                ],
              ),
              ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: _myListView2(context),
                      )
                      
                    ],
                  )
                ],

              ),
              ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: _myListView3(context),
                      )
                      
                    ],
                  )
                ],
              ),
              
            ],
          ),
              ),
            )
          );
      }
    );
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
      backgroundColor: Color(0xFFECE9E4),
        body: ListView(
          //physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            Column(
              children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height / 28,),
                  Row(
                    children: <Widget>[
                      SizedBox(width: MediaQuery.of(context).size.width / 50,),
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 45,),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 17, 0, 0, 100),
                      ),
                      Text("Explore", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      SizedBox(width: MediaQuery.of(context).size.width / 18.5,),
                      Container(
                      //color: Colors.white,
                      width: MediaQuery.of(context).size.width / 1.3,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
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
                              hintText: 'Search for people, interests, school ...'),
                        ),
                      ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 58.5,),
                IconButton(
                  icon: Icon(Icons.filter_list, color: Colors.black),
                  onPressed: (){
                    _settingModalBottomSheet(context);
                  },
                ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height/10),
                    child: _myListView4(context),
                  ),
                  
                  
              ],
            )
          ],
        )
      );
  }
  


    Widget _myListView(BuildContext context) {
      return CheckboxGroup(
      checkColor: Colors.white,
      activeColor: Colors.black,
      labels: <String>[
        "Waterloo",
        "Western",
        "UBC",
        "Calgary",
        "UofA",
        "McMaster",
        "UofT",
        "Harvard"
      ],
      onChange: (bool isChecked, String label, int index) => print("isChecked: $isChecked   label: $label  index: $index"),
      onSelected: (List<String> checked) => print("checked: ${checked.toString()}"),
    );
    }


    Widget _myListView2(BuildContext context) {
      return CheckboxGroup(
      checkColor: Colors.white,
      activeColor: Colors.black,
      labels: <String>[
        "Badminton",
        "Flutter",
        "Basketball",
        "Philosophy",
        "Acting",
        "Music",
        "Painting",
        "Startups"
      ],
      onChange: (bool isChecked, String label, int index) => print("isChecked: $isChecked   label: $label  index: $index"),
      onSelected: (List<String> checked) => print("checked: ${checked.toString()}"),
    );
    }


    Widget _myListView3(BuildContext context) {
      return CheckboxGroup(
      checkColor: Colors.white,
      activeColor: Colors.black,
      labels: <String>[
        "2019",
        "2020",
        "2021",
        "2022",
        "2023",
        "2024",
        "2025",
        "2026"
      ],
      onChange: (bool isChecked, String label, int index) => print("isChecked: $isChecked   label: $label  index: $index"),
      onSelected: (List<String> checked) => print("checked: ${checked.toString()}"),
    );
    }










    Widget _myListView4(BuildContext context) {

      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/img/dhruvpatel.jpeg'),
            ),
            title: Text('Dhruv Patel'),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );


    }



}

