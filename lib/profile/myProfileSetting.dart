import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'teamMangement.dart';
import 'personalInfo.dart';

class MyProfileSettings extends StatefulWidget {
  @override
  _MyProfileSettingsState createState() => _MyProfileSettingsState();
}

class _MyProfileSettingsState extends State<MyProfileSettings> {
  Widget settingsContent(String info, int value) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
      ),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 5),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5),
        leading: null,
        title: Text(
          info,
          style: TextStyle(
            fontFamily: 'PoppinsStyle',
            fontSize: 12,
            fontStyle: FontStyle.normal,
          ),
        ),
        trailing: Icon(Icons.navigate_next_outlined),
        onTap: () {
          var values;
          switch (value) {
            case 1:
              values = PersonalInfo();
              break;
            case 2:
              values = TeamManagement();
              break;
          }
          Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 800),
                ctx: context,
                child: values,
              ));
        },
      ),
    );
  }

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
                    "Settings",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'PoppinsStyle',
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                settingsContent("Personal Info", 1),
                // Divider(thickness: 1, indent: 5, endIndent: 5),
                settingsContent("Team Activity", 2),
                // Divider(thickness: 1, indent: 5, endIndent: 5),
                settingsContent("Team Management", 3),
                // Divider(thickness: 1, indent: 5, endIndent: 5),
                settingsContent("Language", 4),
                // Divider(thickness: 1, indent: 5, endIndent: 5),
                settingsContent("Term of Service", 5),
                // Divider(thickness: 1, indent: 5, endIndent: 5),
                settingsContent("Help Center", 6),
                // Divider(thickness: 1, indent: 5, endIndent: 5),
                settingsContent("About Us", 7),
                // Divider(thickness: 1, indent: 5, endIndent: 5),
              ],
            ),
          )),
    );
  }
}
