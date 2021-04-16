import 'package:Planalist/task/myTask.dart';
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
      Text('Reminder'),
      Text('Profile'),
    ];

    final bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 30),
          title: Container(height: 0, child: Text(''))),
      BottomNavigationBarItem(
          icon: Icon(Icons.water_damage, size: 30),
          title: Container(height: 0, child: Text(''))),
      BottomNavigationBarItem(
          icon: Icon(Icons.people, size: 30),
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
          leading: new IconButton(
            icon: new Icon(Icons.settings),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          title: Text("Planalist", style: TextStyle(fontSize: 16)),
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
                leading: Icon(Icons.account_balance),
                title: Text('Account'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.local_activity),
                title: Text('Activity'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('My Setting'),
                onTap: () {},
              ),
              Divider(color: Colors.black),
              ListTile(
                leading: Icon(Icons.help_center),
                title: Text('Help Center'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.video_library),
                title: Text('Video Tutorial'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Center(child: listPage[selectedTabIndex]),
        bottomNavigationBar: Container(
          height: 64,
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 2),
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
