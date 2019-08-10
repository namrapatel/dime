import 'package:Dime/EditCardsScreen.dart';
import 'package:flutter/material.dart';
import 'models/commentTags.dart';
import 'socialComments.dart';

class ProfComments extends StatefulWidget {
  @override
  _ProfCommentsState createState() => _ProfCommentsState();
}

class _ProfCommentsState extends State<ProfComments> {
   GlobalKey<AutoCompleteTextFieldState<UserTag>> key = new GlobalKey();

     List<UserTag> suggestions = [
//    "Apple",
//    "Armidillo",
//    "Actual",
//    "Actuary",
//    "America",
//    "Argentina",
//    "Australia",
//    "Antarctica",
//    "Blueberry",
//    "Cheese",
//    "Danish",
//    "Eclair",
//    "Fudge",
//    "Granola",
//    "Hazelnut",
//    "Ice Cream",
//    "Jely",
//    "Kiwi Fruit",
//    "Lamb",
//    "Macadamia",
//    "Nachos",
//    "Oatmeal",
//    "Palm Oil",
//    "Quail",
//    "Rabbit",
//    "Salad",
//    "T-Bone Steak",
//    "Urid Dal",
//    "Vanilla",
//    "Waffles",
//    "Yam",
//    "Zest"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        elevation: 0.4,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'University of Waterloo',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  'Professional Feed',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Flexible(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: 15,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        contentPadding: EdgeInsets.all(15),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/img/dhruvpatel.jpeg'),
                          radius: 25,
                        ),
                        title: Row(
                          children: <Widget>[
                            Text("Dhruv Patel",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text("2 hrs ago",
                            style: TextStyle(fontSize: 12,
                            color: Color(0xFF063F3E)
                            ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          children: <Widget>[
                            SizedBox(
                              height: screenH(10),
                            ),
                            Text("This was a really dope post about cool stuff and stuff and stuff"),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(-2, 0),
                  blurRadius: 5,
                ),
              ]),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15,),
                  ),
                  Expanded(
                    child:  Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 22,
                            vertical: MediaQuery.of(context).size.height / 72),
                        child: SimpleAutoCompleteTextField(
                        key: key,
                        decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 30,
                                  bottom: MediaQuery.of(context).size.height / 155,
                                  top: MediaQuery.of(context).size.height / 155,
                                  right: MediaQuery.of(context).size.width / 30),
                              hintText: 'Enter Comment',
                              hintStyle: TextStyle(color: Colors.grey)
                              ),
                        controller: TextEditingController(),
                        suggestions: suggestions,
                        clearOnSubmit: false,
                            
                            ),
                      ),

                      ),
                    ),

                  SizedBox(
                    width: screenW(20),
                  ),
                  
Container(
        width: 40,
        height: 40,
        child: FloatingActionButton(
            elevation: 5,
            backgroundColor: Color(0xFF063F3E),
            heroTag: 'fabb4',
            child: Icon(Icons.send, color: Colors.white, size: 20,),
            onPressed: (){}
        )
    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
