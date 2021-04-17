import 'package:flutter/material.dart';

class TeamManagement extends StatefulWidget {
  @override
  _TeamManagementState createState() => _TeamManagementState();
}

class _TeamManagementState extends State<TeamManagement> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Container(
            child: AppBar(
              backgroundColor: Colors.white,
              leading: Icon(
                Icons.navigate_before,
                color: Colors.black,
              ),
              title: Container(
                child: Text(
                  "My Task",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text("Team Manajement"),
            )),
      ),
    );
  }
}
