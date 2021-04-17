import 'package:Planalist/task/taskListDetail.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

class MyTask extends StatefulWidget {
  @override
  _MyTaskState createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {
  bool visibilityCard = false;
  Widget cardGardenList() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 500),
                child: TaskListDetail(),
                ctx: context),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Garden Ciputat',
                style: TextStyle(
                    fontFamily: 'PoppinsStyle',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Column(
                  children: [
                    Text(
                      'List 1',
                      style: TextStyle(
                          fontFamily: 'PoppinsStyle',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w100),
                    ),
                    Text(
                      'List 1',
                      style: TextStyle(
                          fontFamily: 'PoppinsStyle',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w100),
                    ),
                    Text(
                      'List 1',
                      style: TextStyle(
                          fontFamily: 'PoppinsStyle',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w100),
                    ),
                    Text(
                      'List 1',
                      style: TextStyle(
                          fontFamily: 'PoppinsStyle',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Task",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'PoppinsStyle',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
              ),
            ),
            FlatButton(
              textColor: Colors.grey,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Text(
                "See All",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontFamily: 'PoppinsStyle',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w100,
                ),
              ),
              onPressed: () {
                setState(() {
                  visibilityCard = !visibilityCard;
                });
              },
            ),
          ],
        ),
        // SizedBox(height: 10.0),
        cardGardenList(),
        if (!this.visibilityCard)
          for (int i = 0; i < 2; i++) cardGardenList(),
      ],
    );
  }
}
