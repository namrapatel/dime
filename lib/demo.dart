  //  Container(
  //                 width: MediaQuery.of(context).size.width / 1.8,
  //                 height: 50,
  //                   decoration: BoxDecoration(
  //                     color: Color(0xFF1976d2),
  //                     borderRadius: BorderRadius.circular(20)),
  //                 child: Row(
  //                   children: <Widget>[
  //                     SizedBox(
  //                       width: 20,
  //                     ),
  //                     Text("Reason for Event  ",
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 17
  //                     ),
  //                     ),
  //                     SizedBox(
  //                       width: 20,
  //                     ),
  //                     IconButton(
  //                       icon: Icon(Icons.keyboard_arrow_down, color: Colors.white,),
  //                       onPressed: (){
  //                       showCupertinoModalPopup(
                          
  //                         context: context,
  //                         builder: (BuildContext context) => CupertinoActionSheet(
  //                           cancelButton: CupertinoActionSheetAction(
  //                                 child: const Text('Cancel'),
  //                                 isDefaultAction: true,
  //                                 onPressed: () {
  //                                   Navigator.pop(context, 'Cancel');
  //                                 },
  //                               ),
  //                             title: const Text('Select one of the following options for why you are at this event',
  //                             style: TextStyle(fontSize: 18),
  //                             ),
  //                             message: const Text('If you do not see an exact reason for your case, please choose the closest one  '),
  //                             actions: <Widget>[
  //                               CupertinoActionSheetAction(
  //                                 child: const Text('Build Relationships'),
  //                                 onPressed: () {
                                    
  //                                   Navigator.pop(context, 'Build Relationships');
  //                                 },
  //                               ),
  //                               CupertinoActionSheetAction(
  //                                 child: const Text('Engage in Content'),
  //                                 onPressed: () {
                                    
  //                                   Navigator.pop(context, 'Event Content');
  //                                 },
  //                               ),
  //                               CupertinoActionSheetAction(
  //                                 child: const Text('To Motivate Myself'),
  //                                 onPressed: () {
                               
  //                                   Navigator.pop(context, 'Motivation');
  //                                 },
  //                               ),
  //                               CupertinoActionSheetAction(
  //                                 child: const Text('Key Conversations'),
  //                                 onPressed: () {
                                    
  //                                   Navigator.pop(context, 'Two');
  //                                 },
  //                               )
  //                             ],
  //                             ),
  //                       );
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //               ),