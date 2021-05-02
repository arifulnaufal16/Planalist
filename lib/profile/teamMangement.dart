import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
            child: ListView(
              children: [
                Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), // if you need this
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                duration: Duration(milliseconds: 800),
                                // child: MyTreeDetails(),
                                ctx: context),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60.0),
                                  child: Image(
                                    image: AssetImage('image/image1.png'),
                                    height: 42,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Daffa Alfarizqi",
                                    style: TextStyle(
                                        fontFamily: 'PoppinsStyle',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "Owner",
                                    style: TextStyle(
                                      fontFamily: 'PoppinsStyle',
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "kristinwatson@gmail.com",
                                    style: TextStyle(
                                      fontFamily: 'PoppinsStyle',
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                child: ButtonTheme(
                                  minWidth: 20,
                                  height: 20,
                                  child: RaisedButton(
                                    // onPressed: () {},

                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade,
                                            duration:
                                                Duration(milliseconds: 500),
                                            ctx: context),
                                      );
                                    },
                                    color: Colors.green,
                                    splashColor: Colors.green,
                                    child: Text(
                                      "Active",
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.white,
                                          fontFamily: 'PoppinsStyle',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w100),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
