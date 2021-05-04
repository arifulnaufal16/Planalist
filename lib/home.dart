import 'package:Planalist/garden/addGarden.dart';
import 'package:Planalist/task/myTask.dart';
import 'package:Planalist/profile/myProfile.dart';
import 'package:Planalist/garden/myGarden.dart';
import 'package:Planalist/planalist_icon_icons.dart';
import 'package:Planalist/profile/myProfileSetting.dart';
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
    return new Scaffold(
        key: _scaffoldKey,
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
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
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
            if (selectedTabIndex == 1)
              Container(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(
                    PlanalistIconUpdate.vector,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 800),
                          child: AddGarden(),
                          ctx: context),
                    );
                  },
                ),
              ),
            if (selectedTabIndex == 2)
              Container(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(
                    PlanalistIcon.setting,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 800),
                          child: MyProfileSettings(),
                          ctx: context),
                    );
                  },
                ),
              )
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
        body: Center(child: listPage[selectedTabIndex]),
        bottomNavigationBar: Container(
          height: 64,
          margin: EdgeInsets.fromLTRB(24, 0, 24, 20),
          decoration: BoxDecoration(
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
        ));
  }
}
