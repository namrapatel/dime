import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:Dime/homePage.dart';

class LikeNotif extends StatefulWidget {
  @override
  _LikeNotifState createState() => _LikeNotifState();
}

class _LikeNotifState extends State<LikeNotif> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenH(8.0)),
      child: ListTile(
        // leading: Container(
        //     width: MediaQuery.of(context).size.width / 12,
        //     height: MediaQuery.of(context).size.height / 25,
        //     decoration: BoxDecoration(
        //       //Depending on if its social or professional like - it should be a different color, I've put the professional color for now
        //         color: Color(0xFF096664),
        //         borderRadius: BorderRadius.all(Radius.circular(30))),
        //     child: Icon(
        //       AntDesign.bulb1,
        //       color: Colors.white,
        //       size: screenH(20),
        //     )),
        leading: Stack(
          children: <Widget>[
            CircleAvatar(
          backgroundColor: Color(0xFF8803fc),
          radius: screenH(30),
          child: Icon(
              AntDesign.bulb1,
              color: Colors.white,
              size: screenH(25),
            ),
        ),
        Positioned(
                  left: MediaQuery.of(context).size.width / 10000000,
                  top: MediaQuery.of(context).size.height / 23.5,
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.height / 80,
                    backgroundColor: Colors.white,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 600,
                        ),
                        Text(
                          '🔒',
                          style: TextStyle(fontSize: screenH(12.1)),
                        ),
                      ],
                    ),
                  ),
        )
          ],
        ),
        title: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 1.95,
              child: AutoSizeText(
                "Someone just liked you!",
                style: TextStyle(fontWeight: FontWeight.bold),
                minFontSize: 15,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Brain of an engineer. Heart of a designer.",
              style: TextStyle(
                color: Color(0xFF1458EA),
              ),
            ),
            Text("University of Waterloo", ),
            Text("Computer Science, 2022",),
            Text("6m ago", style: TextStyle(fontSize: 11)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.grey[100],
              ),
              child: IconButton(
                icon: Icon(
                  EvilIcons.like,
                  size: screenH(35),
                ),
                color: Color(0xFF1458EA),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
