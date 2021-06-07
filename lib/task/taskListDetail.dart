import 'package:flutter/material.dart';
import 'package:Planalist/task/newTask.dart';
import 'myTask.dart';
import 'package:page_transition/page_transition.dart';

class TaskListDetail extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<TaskListDetail> {
  var valuefirst = [false, false, false];

  Widget rowTaskListDetail(int index) {
    return Column(
      children: [
        if (!this.valuefirst[index])
          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Theme.of(context).dividerColor)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Checkbox(
                  checkColor: Colors.white70,
                  activeColor: Colors.black,
                  value: this.valuefirst[index],
                  onChanged: (bool value) {
                    setState(() {
                      this.valuefirst[index] = value;
                    });
                  },
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Text('1102', style: TextStyle(fontSize: 16.0))),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    'Siram Pohon ',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 10),
      ],
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
              leading: IconButton(
                icon: Icon(Icons.navigate_before),
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 500),
                        child: MyTask(),
                        ctx: context),
                  );
                },
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
          child: Stack(
            children: [
              Container(
                child: ListView(
                  padding: EdgeInsets.only(bottom: 100),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Center(
                        child: Text(
                          "Garden Ciputat",
                          style: TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                    rowTaskListDetail(0),
                    rowTaskListDetail(1),
                  ],
                ),
              ),
              Positioned(
                right: 1,
                bottom: 1,
                child: FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 500),
                          child: NewTask(),
                          ctx: context),
                    );
                  },
                  child: Icon(Icons.add),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
