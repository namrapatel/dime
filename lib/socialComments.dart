import 'package:Dime/EditCardsScreen.dart';
import 'package:flutter/material.dart';

class SocialComments extends StatefulWidget {
  @override
  _SocialCommentsState createState() => _SocialCommentsState();
}

class _SocialCommentsState extends State<SocialComments> {
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
                  'Social Feed',
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
                            color: Color(0xFF8803fc)
                            ),
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsets.all(15),
                        subtitle: 
                        Column(
                          children: <Widget>[
                            SizedBox(height: 5,),
                            Text("@NamraPatel this was a really dope post about cool stuff lololol"
                            ),
                             
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
                    padding: EdgeInsets.only(left: 15),
                  ),
                  Expanded(
                    child:                     Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 22,
                            vertical: MediaQuery.of(context).size.height / 72),
                        child: TextField(
                          onTap: (){
                          },
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 30,
                                  bottom: MediaQuery.of(context).size.height / 155,
                                  top: MediaQuery.of(context).size.height / 155,
                                  right: MediaQuery.of(context).size.width / 30),
                              hintText: 'Enter Comment'),
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
            backgroundColor: Color(0xFF8803fc),
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
