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
        leading: Container(
            width: MediaQuery.of(context).size.width / 12,
            height: MediaQuery.of(context).size.height / 25,
            decoration: BoxDecoration(
                color: Color(0xFF1458EA),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Icon(
              AntDesign.bulb1,
              color: Colors.white,
              size: screenH(20),
            )),
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
              "Western University",
              style: TextStyle(
                color: Color(0xFF1458EA),
              ),
            ),
            Text("Computer Science, 2022"),
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
