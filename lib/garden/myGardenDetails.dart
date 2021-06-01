import 'package:Planalist/garden/addGarden.dart';
import 'package:Planalist/garden/addPlant.dart';
import 'package:Planalist/planalist_icon_icons.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:Planalist/main.dart' as main;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'myTreeDetails.dart';

class MyGardenDetails extends StatefulWidget {
  @override
  _MyGardenDetailsState createState() => _MyGardenDetailsState();
  final int garden_id;
  final String garden_name;
  final String garden_location;
  final int index = 0;
  MyGardenDetails(this.garden_id, this.garden_name, this.garden_location);
}

class Plant {
  final String plant_type;
  final int plant_id;
  final String plant_code;
  Plant({this.plant_code, this.plant_type, this.plant_id});
  factory Plant.fromJson(Map<String, dynamic> json) {
    return new Plant(
      plant_code: json['plant_code'],
      plant_type: json['plant_type'],
      plant_id: json['plant_id'],
    );
  }
}

class Garden {
  final int garden_id;
  final String garden_name;
  final List<Plant> plants;
  Garden({this.garden_id, this.garden_name, this.plants});
  factory Garden.fromJson(Map<String, dynamic> json) {
    return Garden(
        garden_id: json["garden_id"],
        garden_name: json["garden_name"],
        plants: List<Plant>.from(
            json['plants'].map((plants) => Plant.fromJson(plants)))
        // plants: Plant.fromJson(json['plants']),
        );
  }
}

class _MyGardenDetailsState extends State<MyGardenDetails> {
  final ValueNotifier<double> headerNegativeOffset = ValueNotifier<double>(0);
  final ValueNotifier<bool> appbarShadow = ValueNotifier<bool>(false);
  final double maxHeaderHeight = 250.0;
  final double minHeaderHeight = 56.0;
  final double bodyContentRatioMin = 0.6;
  final double bodyContentRatioMax = 1.0;

  ///must be between min and max values of body content ratio.
  final double bodyContentRatioParallax = .9;

  @override
  void dispose() {
    headerNegativeOffset.dispose();
    appbarShadow.dispose();
    super.dispose();
  }

  // Future<List<MyGardenDetails>> getGardenDetails() async {
  //   int garden_id = widget.garden_id;
  //   http.Response response = await http
  //       .get('http://192.168.43.4:3000/api/gardens/$garden_id/plants');

  //   data = json.decode(response.body);
  //   debugPrint(response.body);
  // }

  List<Plant> _list = [];
  List<Plant> _plants = [];
  Future<Null> getPlant() async {
    int garden_id = widget.garden_id;
    String lh = main.defaultLocalhost;
    final http.Response response =
        await http.get('$lh/api/gardens/$garden_id/plants');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // for (Map i in data) {
      //   _list.add(Garden.fromJson(i));
      // }
      _list.clear();
      for (var i = 0; i < data.first['plants'].length; i++) {
        _list.add(Plant.fromJson(data.first['plants'][i]));
      }
      if (mounted) {
        setState(() {});
      }
    }
  }

  void initializ() async {
    await getPlant();
  }

  void initState() {
    super.initState();
    this.initializ();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //just for status bar color
        body: Stack(
          children: <Widget>[
            Stack(children: [
              Container(
                  child: ValueListenableBuilder<double>(
                      valueListenable: headerNegativeOffset,
                      builder: (context, offset, child) {
                        return Transform.translate(
                          offset: Offset(0, offset * -1),
                          child: SizedBox(
                            child: Container(
                              child: Image(
                                image: AssetImage('image/image1.png'),
                              ),
                            ),
                          ),
                        );
                      })),
              NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  if (notification.extent == bodyContentRatioMin) {
                    appbarShadow.value = false;
                    headerNegativeOffset.value = 0;
                  } else if (notification.extent == bodyContentRatioMax) {
                    appbarShadow.value = true;
                    headerNegativeOffset.value =
                        maxHeaderHeight - minHeaderHeight;
                  } else {
                    double newValue = (maxHeaderHeight - minHeaderHeight) -
                        ((maxHeaderHeight - minHeaderHeight) *
                            ((bodyContentRatioParallax -
                                    (notification.extent)) /
                                (bodyContentRatioMax -
                                    bodyContentRatioParallax)));
                    appbarShadow.value = false;
                    if (newValue >= maxHeaderHeight - minHeaderHeight) {
                      appbarShadow.value = true;
                      newValue = maxHeaderHeight - minHeaderHeight;
                    } else if (newValue < 0) {
                      appbarShadow.value = false;
                      newValue = 0;
                    }
                    headerNegativeOffset.value = newValue;
                  }
                  return true;
                },
                child: Stack(
                  children: <Widget>[
                    DraggableScrollableSheet(
                      initialChildSize: bodyContentRatioMin,
                      minChildSize: bodyContentRatioMin,
                      maxChildSize: bodyContentRatioMax,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Stack(
                          children: <Widget>[
                            Container(
                              child: Material(
                                type: MaterialType.canvas,
                                color: Colors.white,
                                elevation: 2.0,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24.0),
                                  topRight: Radius.circular(24.0),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Divider(
                                          indent: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4 +
                                              20,
                                          endIndent: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4 +
                                              20,
                                          thickness: 5,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          widget.garden_name,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontFamily: 'PoppinsStyle',
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on),
                                          SizedBox(width: 10),
                                          Container(
                                            child: Text(
                                              widget.garden_location,
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 16,
                                                fontFamily: 'PoppinsStyle',
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),

                                      // SizedBox(height: 20),
                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //       color: Colors.grey.shade200,
                                      //       borderRadius:
                                      //           BorderRadius.circular(10)),
                                      //   child: TextFormField(
                                      //     cursorColor: Colors.black,
                                      //     decoration: InputDecoration(
                                      //       prefixIcon: Container(
                                      //         // add padding to adjust icon
                                      //         child: Icon(
                                      //           Icons.search,
                                      //           color: Colors.grey.shade500,
                                      //         ),
                                      //       ),
                                      //       contentPadding:
                                      //           EdgeInsets.symmetric(
                                      //         vertical: 0.0,
                                      //         horizontal: 20,
                                      //       ),
                                      //       focusedBorder: OutlineInputBorder(
                                      //         borderSide: new BorderSide(
                                      //             color: Colors.grey),
                                      //         borderRadius:
                                      //             BorderRadius.circular(10),
                                      //       ),
                                      //       enabledBorder: OutlineInputBorder(
                                      //         borderSide: new BorderSide(
                                      //             color: Colors.white),
                                      //         borderRadius:
                                      //             BorderRadius.circular(10),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      Container(
                                        child: Divider(
                                          indent: 20,
                                          endIndent: 20,
                                          thickness: 5,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Center(
                                        child: ButtonTheme(
                                          minWidth:
                                              MediaQuery.of(context).size.width,
                                          child: RaisedButton(
                                            // onPressed: () {},

                                            onPressed: () async {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: AddPlant(
                                                        widget.garden_id,
                                                        widget.garden_name),
                                                    ctx: context),
                                              ).then((v) {
                                                initializ();
                                              });
                                            },
                                            color: Colors.green,
                                            splashColor: Colors.green,
                                            child: Text(
                                              "Add Plant",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.white,
                                                  fontFamily: 'PoppinsStyle',
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w100),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Expanded(
                                        child: MediaQuery.removePadding(
                                          context: context,
                                          removeTop: true,
                                          child: ListView.builder(
                                            controller: scrollController,
                                            itemCount: _list.length,
                                            itemBuilder:
                                                (BuildContext context, int i) {
                                              final plantgarden = _list[i];
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20), // if you need this
                                                    side: BorderSide(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: InkWell(
                                                      splashColor: Colors.blue
                                                          .withAlpha(30),
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      800),
                                                              child: MyTreeDetails(
                                                                  plantgarden
                                                                      .plant_id
                                                                      .toString(),
                                                                  widget
                                                                      .garden_name),
                                                              ctx: context),
                                                        ).then((v) {
                                                          initializ();
                                                        });
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(15),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          20),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            60.0),
                                                                child: Image(
                                                                  image: AssetImage(
                                                                      'image/image1.png'),
                                                                  height: 60,
                                                                ),
                                                              ),
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                plantgarden.plant_code !=
                                                                        null
                                                                    ? Text(plantgarden
                                                                        .plant_code
                                                                        .toString())
                                                                    : Text(
                                                                        "[Belum ada nama pohon]"),
                                                                plantgarden.plant_code !=
                                                                        null
                                                                    ? Text(plantgarden
                                                                        .plant_type
                                                                        .toString())
                                                                    : Text(
                                                                        "[Belum ada tipe pohon]"),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      )),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
