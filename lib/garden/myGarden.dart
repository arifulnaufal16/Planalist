import 'dart:convert';
import 'package:Planalist/garden/myGardenInfo.dart';
import 'package:flutter/material.dart';
import 'package:Planalist/main.dart' as main;
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import '../loading.dart';
import '../planalist_icon_icons.dart';
import 'addGarden.dart';
import 'myGardenDetails.dart';

class MyGarden extends StatefulWidget {
  @override
  _MyGardenState createState() => _MyGardenState();
  final int index = 0;
  final int garden_id;
  final String garden_name;
  final String location;
  final String plantcount;
  final String gardenhealthy;
  final String gardensick;

  // final int plantcount;
  // final int gardenhealthy;
  // final int gardensick;
  MyGarden(
      {this.garden_id,
      this.garden_name,
      this.plantcount,
      this.location,
      this.gardenhealthy,
      this.gardensick});
  factory MyGarden.fromJson(Map<String, dynamic> json) {
    return MyGarden(
      garden_id: json['garden_id'],
      garden_name: json['garden_name'],
      plantcount: json['plants_total'],
      location: json['location'],
      gardenhealthy: json['plants_healthy'],
      gardensick: json['plants_sick'],
    );
  }
}

class _MyGardenState extends State<MyGarden> {
  bool isLoading = true;
  List data;
  List garden;
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  Future<List<MyGarden>> getGarden() async {
    String lh = main.defaultLocalhost;
    http.Response response = await http.get('$lh/api/gardens');
    data = json.decode(response.body);
    garden = data.map((garden) => new MyGarden.fromJson(garden)).toList();
    print(garden[0].location);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  void initz() async {
    await getGarden();
  }

  void initState() {
    super.initState();
    this.initz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: new AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 52,
        leading: Container(
          padding: EdgeInsets.only(left: 20),
          child: new IconButton(
            icon: new Icon(
              PlanalistIcon.menu,
              color: Colors.black,
            ),
            onPressed: () => _key.currentState.openDrawer(),
          ),
        ),
        title: Container(
          padding: EdgeInsets.only(left: 0),
          child: Text(
            "Planalist",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: 'PoppinsStyle',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                PlanalistIconUpdate.vector,
                color: Colors.green,
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      duration: Duration(milliseconds: 800),
                      child: AddGarden(),
                      ctx: context),
                ).then((v) {
                  if (v is String) {
                    initz();
                  }
                });
              },
            ),
          ),
          // if (selectedTabIndex == 2)
          //   Container(
          //     padding: EdgeInsets.only(right: 10),
          //     child: IconButton(
          //       icon: Icon(
          //         PlanalistIcon.setting,
          //         color: Colors.black,
          //       ),
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           PageTransition(
          //               type: PageTransitionType.fade,
          //               duration: Duration(milliseconds: 800),
          //               child: MyProfileSettings(),
          //               ctx: context),
          //         );
          //       },
          //     ),
          //   )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 120,
              child: new DrawerHeader(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.grey),
                  ),
                ),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            color: Colors.red,
                            height: 24,
                            width: 24,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Hello,"),
                                Text("Daffa"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 32,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                PlanalistIcon.account,
                color: Colors.black,
              ),
              title: Text(
                'Account',
                style: TextStyle(
                  fontFamily: 'PoppinsStyle',
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w100,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                PlanalistIcon.chart,
                color: Colors.black,
              ),
              title: Text(
                'Activity',
                style: TextStyle(
                  fontFamily: 'PoppinsStyle',
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w100,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                PlanalistIcon.setting,
                color: Colors.black,
              ),
              title: Text(
                'My Setting',
                style: TextStyle(
                  fontFamily: 'PoppinsStyle',
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w100,
                ),
              ),
              onTap: () {},
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              leading: Icon(
                PlanalistIcon.help,
                color: Colors.black,
              ),
              title: Text(
                'Help Center',
                style: TextStyle(
                  fontFamily: 'PoppinsStyle',
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w100,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                PlanalistIcon.play,
                color: Colors.black,
              ),
              title: Text(
                'Video Tutorial',
                style: TextStyle(
                  fontFamily: 'PoppinsStyle',
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w100,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: isLoading == true
          ? Loading()
          : Padding(
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
                            onTap: () async {
                              final int gardenId = garden[index].garden_id;
                              final String garden_name =
                                  garden[index].garden_name;
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 200),
                                  child: MyGardenInfo(gardenId, garden_name),
                                  ctx: context,
                                ),
                              ).then((v) {
                                if (v is Null) {
                                  initz();
                                }
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                            onPressed: () async {
                                              final int gardenId =
                                                  garden[index].garden_id;
                                              final String garden_name =
                                                  garden[index].garden_name;
                                              final String loc =
                                                  garden[index].location;

                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType
                                                      .bottomToTop,
                                                  duration: Duration(
                                                      milliseconds: 200),
                                                  child: MyGardenDetails(
                                                      gardenId,
                                                      garden_name,
                                                      loc),
                                                  ctx: context,
                                                ),
                                              ).then((v) {
                                                if (v is Null) {
                                                  initz();
                                                }
                                              });
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
                                              borderRadius:
                                                  BorderRadius.circular(30),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Pohon",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontFamily: 'PoppinsStyle',
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight:
                                                        FontWeight.w100),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                garden[index]
                                                    .plantcount
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontFamily: 'PoppinsStyle',
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight:
                                                        FontWeight.w700),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Sehat",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontFamily: 'PoppinsStyle',
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight:
                                                        FontWeight.w100),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                garden[index]
                                                    .gardenhealthy
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontFamily: 'PoppinsStyle',
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight:
                                                        FontWeight.w700),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Sakit",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontFamily: 'PoppinsStyle',
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight:
                                                        FontWeight.w100),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                garden[index]
                                                    .gardensick
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontFamily: 'PoppinsStyle',
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight:
                                                        FontWeight.w700),
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
            ),
    );
  }
}
