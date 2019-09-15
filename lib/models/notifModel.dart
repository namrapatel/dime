import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:Dime/homePage.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
class LikeNotif extends StatefulWidget {
  final String id,name,photo,major,university,gradYear,bio,relationshipStatus,type,timestamp;
  final bool liked;
  const LikeNotif({this.id,this.name,this.photo,this.major,this.university,this.gradYear,this.bio,this.relationshipStatus,
    this.type,this.timestamp,this.liked});

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
            widget.liked==false?
            CircleAvatar(
          backgroundColor: Color(0xFF8803fc),
          radius: screenH(30),
          child: Icon(
              AntDesign.bulb1,
              color: Colors.white,
              size: screenH(25),
            ),
        ):
        CircleAvatar(

    radius: screenH(30),
    child: CachedNetworkImage(imageUrl: widget.photo)
    ),
            widget.relationshipStatus!=null?
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
                          widget.relationshipStatus,
                          style: TextStyle(fontSize: screenH(12.1)),
                        ),
                      ],
                    ),
                  ),
        ):SizedBox(width: 0.0,)
          ],
        ),
        title: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 1.95,
              child: AutoSizeText(
                widget.liked==false?
                "Someone just liked you!":widget.name+ " just liked you!",
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
              widget.bio!=null?widget.bio:""
              ,
              style: TextStyle(
                color: Color(0xFF1458EA),
              ),
            ),
            Text(widget.university!=null?widget.university:"" ),
            widget.major != null && widget.gradYear != null
                ?  Text(widget.major + ", " + widget.gradYear)

                : Text(widget.major != null ? widget.major : ""),

            Text(widget.timestamp!=null?widget.timestamp:"", style: TextStyle(fontSize: 11)),
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
              child: widget.liked==false?IconButton(
                icon: Icon(
                  EvilIcons.like,
                  size: screenH(35),
                ),
                color: Color(0xFF1458EA),
                onPressed: () {},
              ):IconButton(
                icon: Icon(
                  Feather.message_circle,
                  size: screenH(35),
                ),
                color: Color(0xFF1458EA),
                onPressed: () {},
              )
            )
          ],
        ),
      ),
    );
  }
}
