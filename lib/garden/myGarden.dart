import 'dart:convert';
import 'package:Planalist/garden/myGardenInfo.dart';
import 'package:flutter/material.dart';
import 'package:Planalist/main.dart' as main;
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'myGardenDetails.dart';

class MyGarden extends StatefulWidget {
  @override
  _MyGardenState createState() => _MyGardenState();
  final int index = 0;
  final int garden_id;
  final String garden_name;
  final int plantcount;
  MyGarden({this.garden_id, this.garden_name, this.plantcount});
  factory MyGarden.fromJson(Map<String, dynamic> json) {
    return MyGarden(
      garden_id: json['garden_id'],
      garden_name: json['garden_name'],
      plantcount: json['plants.count'],
    );
  }
}

class _MyGardenState extends State<MyGarden> {
  List data;
  List garden;

  Future<List<MyGarden>> getGarden() async {
    String lh = main.defaultLocalhost;
    http.Response response = await http.get('$lh/api/gardens');

    data = json.decode(response.body);
    garden = data.map((garden) => new MyGarden.fromJson(garden)).toList();
    print(garden);
    setState(() {});
  }

  void initState() {
    super.initState();
    getGarden();
  }

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
          ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: garden == null ? 0 : garden.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  // child: InkWell(
                  //   splashColor: Colors.blue.withAlpha(30),
                  //   onTap: () {
                  //     print('Card tapped.');
                  //   },

                  child: new InkWell(
                    onTap: () {
                      final int gardenId = garden[index].garden_id;
                      final String garden_name = garden[index].garden_name;
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 800),
                          child: MyGardenInfo(gardenId, garden_name),
                          ctx: context,
                        ),
                      );
                      print("tapped");
                    },
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
                                  garden[index].garden_name,
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
                                      final int gardenId =
                                          garden[index].garden_id;
                                      final String garden_name =
                                          garden[index].garden_name;
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          duration: Duration(milliseconds: 800),
                                          child: MyGardenDetails(
                                              gardenId, garden_name),
                                          ctx: context,
                                        ),
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
                                        garden[index].plantcount.toString(),
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
              );
            },
          ),

          // ),
        ],
      ),
    );
  }
}
