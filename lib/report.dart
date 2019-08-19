// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class Report extends StatefulWidget {
//   @override
//   _ReportState createState() => _ReportState();
// }

// class _ReportState extends State<Report> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }

// class ReportTabs extends StatefulWidget {
//   @override
//   _ReportTabsState createState() => _ReportTabsState();
// }

// class _CardEditState extends State<CardEdit> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           leading: Row(
//             children: <Widget>[
//               SizedBox(
//                 width: screenW(8),
//               ),
//               IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       PageTransition(
//                           type: PageTransitionType.leftToRight,
//                           child: ProfilePage()));
//                 },
//                 color: Colors.white,
//                 icon: Icon(Icons.arrow_back_ios),
//               ),
//             ],
//           ),
//           elevation: 0.0,
//           backgroundColor: Color(0xFF1458EA),
//           title: Text(
//             'Edit Cards',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           bottom: TabBar(
//             indicatorColor: Colors.white,
//             tabs: <Widget>[
//               Tab(
//                 child: Text(
//                   'Social',
//                   style: TextStyle(color: Colors.white, fontSize: 17),
//                 ),
//               ),
//               Tab(
//                 child: Text(
//                   'Professional',
//                   style: TextStyle(color: Colors.white, fontSize: 17),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [SocialCardEdit(), ProfessionalCardEdit()],
//         ),
//       ),
//     );
//   }
// }