import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flushbar/flushbar.dart';

class LocalNotification extends StatelessWidget {
  final String titleMessage;
  final String bodyMessage;
  const LocalNotification(this.titleMessage, this.bodyMessage);

  @override
  Widget build(BuildContext context) {
    return Flushbar(
      margin: EdgeInsets.all(8),
      message: "hello",
      borderRadius: 15,
      messageText: Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              titleMessage,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              bodyMessage,
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      boxShadows: [
        BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            blurRadius: (15),
            spreadRadius: (5),
            offset: Offset(0, 3)),
      ],
      flushbarPosition: FlushbarPosition.TOP,
      icon: Padding(
        padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
        child: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Color(0xFF1458EA),
        ),
      ),
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
