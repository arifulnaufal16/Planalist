import 'package:Planalist/task/taskListDetail.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

class MyTask extends StatefulWidget {
  @override
  _MyTaskState createState() => _MyTaskState();
}

int x = 0;
Color mainColor = Color(0xFF2B9348);
Color secondColor = Color(0xffA3F7BF);

class _MyTaskState extends State<MyTask> {
  // bool visibilityCard = false;
  // Widget cardGardenList() {
  //   return Card(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(10),
  //       ),
  //     ),
  //     child: InkWell(
  //       splashColor: Colors.blue.withAlpha(30),
  //       onTap: () {
  //         Navigator.push(
  //           context,
  //           PageTransition(
  //               type: PageTransitionType.fade,
  //               duration: Duration(milliseconds: 500),
  //               child: TaskListDetail(),
  //               ctx: context),
  //         );
  //       },
  //       child: Container(
  //         width: MediaQuery.of(context).size.width,
  //         padding: EdgeInsets.all(20),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'Garden Ciputat',
  //               style: TextStyle(
  //                   fontFamily: 'PoppinsStyle',
  //                   fontStyle: FontStyle.normal,
  //                   fontWeight: FontWeight.w700),
  //             ),
  //             Container(
  //               padding: EdgeInsets.only(left: 20, top: 10),
  //               child: Column(
  //                 children: [
  //                   Text(
  //                     'List 1',
  //                     style: TextStyle(
  //                         fontFamily: 'PoppinsStyle',
  //                         fontStyle: FontStyle.normal,
  //                         fontWeight: FontWeight.w100),
  //                   ),
  //                   Text(
  //                     'List 1',
  //                     style: TextStyle(
  //                         fontFamily: 'PoppinsStyle',
  //                         fontStyle: FontStyle.normal,
  //                         fontWeight: FontWeight.w100),
  //                   ),
  //                   Text(
  //                     'List 1',
  //                     style: TextStyle(
  //                         fontFamily: 'PoppinsStyle',
  //                         fontStyle: FontStyle.normal,
  //                         fontWeight: FontWeight.w100),
  //                   ),
  //                   Text(
  //                     'List 1',
  //                     style: TextStyle(
  //                         fontFamily: 'PoppinsStyle',
  //                         fontStyle: FontStyle.normal,
  //                         fontWeight: FontWeight.w100),
  //                   ),
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  int _selectedIndexs = 0;
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 120.0,
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) => InkWell(
                        onTap: () {
                          setState(() {
                            if (_selectedIndexs == index) {
                              _selectedIndexs = -1;
                              x = x + 1;
                              print(x);
                            } else {
                              _selectedIndexs = index;
                            }
                          });
                        },
                        child: Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: index == _selectedIndexs
                                      ? mainColor
                                      : secondColor,
                                ),
                                child: Center(
                                  child: Text(
                                    'ALL',
                                    style: TextStyle(
                                        color: index == _selectedIndexs
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                            Text("Garden")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  'Demo Headline 2',
                  style: TextStyle(fontSize: 18),
                ),
                Container(
                  child: Text(x.toString()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// ListView(
//   padding: EdgeInsets.all(20),
//   children: [
//     Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           "My Task",
//           style: TextStyle(
//             fontSize: 16,
//             fontFamily: 'PoppinsStyle',
//             fontStyle: FontStyle.normal,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         FlatButton(
//           textColor: Colors.grey,
//           highlightColor: Colors.transparent,
//           splashColor: Colors.transparent,
//           child: Text(
//             "See All",
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.black,
//               fontFamily: 'PoppinsStyle',
//               fontStyle: FontStyle.normal,
//               fontWeight: FontWeight.w100,
//             ),
//           ),
//           onPressed: () {
//             setState(() {
//               visibilityCard = !visibilityCard;
//             });
//           },
//         ),
//       ],
//     ),
//     // SizedBox(height: 10.0),
//     cardGardenList(),
//     if (!this.visibilityCard)
//       for (int i = 0; i < 2; i++) cardGardenList(),
//   ],
// );
