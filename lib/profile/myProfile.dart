import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../planalist_icon_icons.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
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
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 15),
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.black,
                      margin: EdgeInsets.only(right: 20),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Daffa Alfarizqi",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'PoppinsStyle',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Owner",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'PoppinsStyle',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w100),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('Card tapped.');
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 95,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Overseer",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'PoppinsStyle',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w100),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "10",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
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
                                  "Worker",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'PoppinsStyle',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w100),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "100",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
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
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('Card tapped.');
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      height: 95,
                      child: Text("My Task"),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('Card tapped.');
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      height: 95,
                      child: Text("My Garden"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
