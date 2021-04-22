import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'myGardenDetails.dart';

class MyGarden extends StatefulWidget {
  @override
  _MyGardenState createState() => _MyGardenState();
}

class _MyGardenState extends State<MyGarden> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: ListView(
        children: [
          Container(
            child: Text(
              "Garden",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'PoppinsStyle',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              // child: InkWell(
              //   splashColor: Colors.blue.withAlpha(30),
              //   onTap: () {
              //     print('Card tapped.');
              //   },
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Garden Ciputat",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                              fontFamily: 'PoppinsStyle',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          ButtonTheme(
                            height: 25.0,
                            minWidth: 20,
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration: Duration(milliseconds: 800),
                                      child: MyGardenDetails(),
                                      ctx: context),
                                );
                              },
                              child: Text(
                                "Detail",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'PoppinsStyle',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(
                                  color: Colors.green,
                                  width: 1,
                                ),
                              ),
                              splashColor: Colors.green,
                              textColor: Colors.green,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Pohon",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'PoppinsStyle',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w100),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "10",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'PoppinsStyle',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          VerticalDivider(
                            width: 10,
                            color: Colors.black,
                            thickness: 2,
                            indent: 20,
                            endIndent: 30,
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Buah",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'PoppinsStyle',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "100",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'PoppinsStyle',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          VerticalDivider(
                            width: 10,
                            color: Colors.black,
                            thickness: 2,
                            indent: 20,
                            endIndent: 30,
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sakit",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'PoppinsStyle',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w100),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "100",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'PoppinsStyle',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // ),
        ],
      ),
    );
  }
}
