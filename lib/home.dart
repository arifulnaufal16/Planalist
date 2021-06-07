import 'package:Planalist/garden/addGarden.dart';
import 'package:Planalist/task/myTask.dart';
import 'package:Planalist/profile/myProfile.dart';
import 'package:Planalist/garden/myGarden.dart';
import 'package:Planalist/planalist_icon_icons.dart';
import 'package:Planalist/profile/myProfileSetting.dart';
import 'package:Planalist/task/newTask.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int selectedTabIndex = 0;
  void onNavBarTapped(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final listPage = <Widget>[
      MyTask(),
      MyGarden(),
      MyProfile(),
    ];

    final bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(PlanalistIcon.home, size: 30),
          title: Container(height: 0, child: Text(''))),
      BottomNavigationBarItem(
          icon: Icon(PlanalistIcon.watering, size: 30),
          title: Container(height: 0, child: Text(''))),
      BottomNavigationBarItem(
          icon: Icon(PlanalistIcon.account, size: 30),
          title: Container(height: 0, child: Text(''))),
    ];

    final bottomNavBar = BottomNavigationBar(
      items: bottomNavBarItems,
      currentIndex: selectedTabIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      onTap: onNavBarTapped,
    );
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/myTask': (context) => MyTask(),
        '/myGarden': (context) => MyGarden(),
        '/myProfile': (context) => MyProfile(),
      },
      home: Scaffold(
          key: _scaffoldKey,
          body: Center(child: listPage[selectedTabIndex]),
          bottomNavigationBar: Container(
            height: 64,
            margin: EdgeInsets.fromLTRB(24, 0, 24, 20),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  spreadRadius: 0.2,
                  blurRadius: 1,
                  offset: Offset(0, 1.7),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              child: bottomNavBar,
            ),
          )),
    );
  }
}
