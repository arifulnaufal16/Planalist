import 'package:Planalist/task/taskListDetail.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

class MyTask extends StatefulWidget {
  @override
  _MyTaskState createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {
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
                type: PageTransitionType.leftToRight,
                duration: Duration(milliseconds: 800),
                child: TaskListDetail(),
                ctx: context),
          );
        },
        child: Container(
          width: 300,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Garden Ciputat'),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Column(
                  children: [
                    Text('List 1'),
                    Text('List 1'),
                    Text('List 1'),
                    Text('List 1'),
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
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "See All",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        SizedBox(height: 15.0),
        Column(
          children: [
            cardGardenList(),
            cardGardenList(),
            cardGardenList(),
          ],
        ),
      ],
    );
  }
}
