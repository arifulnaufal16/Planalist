import 'dart:convert';
import 'package:Planalist/loading.dart';
import 'package:Planalist/task/taskListDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:Planalist/main.dart' as main;
import 'package:http/http.dart' as http;

import '../planalist_icon_icons.dart';
import 'newTask.dart';

class MyTask extends StatefulWidget {
  @override
  _MyTaskState createState() => _MyTaskState();
}

int x = 0;
Color mainColor = Color(0xFF2B9348);
Color secondColor = Color(0xffA3F7BF);

class Garden {
  final int index = 0;
  final int garden_id;
  final String garden_name;
  final String garden_loc;
  Garden({this.garden_id, this.garden_name, this.garden_loc});
  factory Garden.fromJson(Map<String, dynamic> json) {
    return Garden(
      garden_id: json['garden_id'],
      garden_name: json['garden_name'],
      garden_loc: json['location'],
    );
  }
}

class Task {
  final int index = 0;
  final int task_id;
  final int garden_id;
  final String task_type;
  final String treatment;
  final String annotation;
  String status;
  final String start_date;
  final String end_date;
  Task(
      {this.task_id,
      this.garden_id,
      this.task_type,
      this.treatment,
      this.annotation,
      this.status,
      this.start_date,
      this.end_date});
  factory Task.fromJson(Map<String, dynamic> json) {
    return new Task(
      task_id: json['task_id'],
      garden_id: json['garden_id'],
      task_type: json['task_type'],
      treatment: json['treatment'],
      annotation: json['annotation'],
      start_date: json['start_date'],
      end_date: json['end_date'],
      status: json['status'],
    );
  }
}

class _MyTaskState extends State<MyTask> {
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  // bool visibilityCard = false;
  // Widget cardGardenList() {
  //   return Card(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(10),
  //       ),
  //     ),
  //     child: InkWell(
  //       splashColor: Colors.blue.withAlpha(30),
  //       onTap: () {
  //         Navigator.push(
  //           context,
  //           PageTransition(
  //               type: PageTransitionType.fade,
  //               duration: Duration(milliseconds: 500),
  //               child: TaskListDetail(),
  //               ctx: context),
  //         );
  //       },
  //       child: Container(
  //         width: MediaQuery.of(context).size.width,
  //         padding: EdgeInsets.all(20),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'Garden Ciputat',
  //               style: TextStyle(
  //                   fontFamily: 'PoppinsStyle',
  //                   fontStyle: FontStyle.normal,
  //                   fontWeight: FontWeight.w700),
  //             ),
  //             Container(
  //               padding: EdgeInsets.only(left: 20, top: 10),
  //               child: Column(
  //                 children: [
  //                   Text(
  //                     'List 1',
  //                     style: TextStyle(
  //                         fontFamily: 'PoppinsStyle',
  //                         fontStyle: FontStyle.normal,
  //                         fontWeight: FontWeight.w100),
  //                   ),
  //                   Text(
  //                     'List 1',
  //                     style: TextStyle(
  //                         fontFamily: 'PoppinsStyle',
  //                         fontStyle: FontStyle.normal,
  //                         fontWeight: FontWeight.w100),
  //                   ),
  //                   Text(
  //                     'List 1',
  //                     style: TextStyle(
  //                         fontFamily: 'PoppinsStyle',
  //                         fontStyle: FontStyle.normal,
  //                         fontWeight: FontWeight.w100),
  //                   ),
  //                   Text(
  //                     'List 1',
  //                     style: TextStyle(
  //                         fontFamily: 'PoppinsStyle',
  //                         fontStyle: FontStyle.normal,
  //                         fontWeight: FontWeight.w100),
  //                   ),
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  int _selectedIndexs = 0;
  bool isLoading = false;
  int card = 0;
  List data;
  List garden;
  List<Task> _task = [];

  Future<List<Garden>> getGarden() async {
    String lh = main.defaultLocalhost;
    http.Response response = await http.get('$lh/api/gardens');
    data = json.decode(response.body);
    garden = data.map((garden) => new Garden.fromJson(garden)).toList();
    if (mounted) {
      setState(() {});
    }
  }

  Future<Null> deleteTask(String tid) async {
    String lh = main.defaultLocalhost;
    http.Response response = await http.delete('$lh/api/tasks/$tid');
    setState(() {
      final data = jsonDecode(response.body);
      _task.removeWhere((element) => element.task_id.toString() == tid);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Data berhasil dihapus')));
    });
  }

  Future<Null> updateTask(String tid) async {
    String lh = main.defaultLocalhost;
    http.Response response = await http.put('$lh/api/tasks/$tid');
    setState(() {
      final data = jsonDecode(response.body);
      print(data);
    });
  }

  Future<Null> getTask(int garden_id) async {
    List<Task> _data1 = [];
    String lh = main.defaultLocalhost;
    final http.Response response = await http.get('$lh/api/$garden_id/tasks');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var i = 0; i < data.first['tasks'].length; i++) {
        _data1.add(Task.fromJson(data.first['tasks'][i]));
      }
      _task = _data1;
      isLoading = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  static const TextStyle content = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontFamily: 'PoppinsStyle',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle content1 = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontFamily: 'PoppinsStyle',
    fontStyle: FontStyle.normal,
  );

  void initialize() async {
    await getGarden();
    await getTask(garden[_selectedIndexs].garden_id);
  }

  void initState() {
    super.initState();
    initialize();
  }

  Future<void> _showMyDialog(String tid) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          // title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Kamu yakin ingin menghapus list ini?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Ya',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                deleteTask(tid);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  var assigned = [];
  var done = [];
  Widget build(BuildContext context) {
    print(_task.length);
    for (var i = 0; i < _task.length; i++) {
      assigned.add(false);
      done.add(true);
    }
    return MaterialApp(
      home: Scaffold(
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
            actions: [
              Container(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.green,
                  ),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 800),
                          child: NewTask(),
                          ctx: context),
                    ).then((v) {
                      if (v is String) {
                        getTask(int.parse(v));
                      }
                    });
                  },
                ),
              ),
              // if (selectedTabIndex == 1)
              //   Container(
              //     padding: EdgeInsets.only(right: 10),
              //     child: IconButton(
              //       icon: Icon(
              //         PlanalistIconUpdate.vector,
              //         color: Colors.green,
              //       ),
              //       onPressed: () {
              //         Navigator.push(
              //           context,
              //           PageTransition(
              //               type: PageTransitionType.fade,
              //               duration: Duration(milliseconds: 800),
              //               child: AddGarden(),
              //               ctx: context),
              //         );
              //       },
              //     ),
              //   ),
              // if (selectedTabIndex == 2)
              //   Container(
              //     padding: EdgeInsets.only(right: 10),
              //     child: IconButton(
              //       icon: Icon(
              //         PlanalistIcon.setting,
              //         color: Colors.black,
              //       ),
              //       onPressed: () {
              //         Navigator.push(
              //           context,
              //           PageTransition(
              //               type: PageTransitionType.fade,
              //               duration: Duration(milliseconds: 800),
              //               child: MyProfileSettings(),
              //               ctx: context),
              //         );
              //       },
              //     ),
              //   )
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
          body: ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 120.0,
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: garden == null ? 0 : garden.length,
                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndexs = index;
                          _task.clear();
                          isLoading = true;
                          getTask(garden[_selectedIndexs].garden_id);
                        });
                      },
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: index == _selectedIndexs
                                    ? mainColor
                                    : secondColor,
                              ),
                              child: Center(
                                child: Text(
                                  garden[index].garden_name,
                                  style: TextStyle(
                                      color: index == _selectedIndexs
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          Text(garden[index].garden_loc)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text("My Tasks"),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 1), // changes position of shadow
                      )
                    ],
                  ),
                  child: isLoading == true
                      ? Loading()
                      : _task.isEmpty
                          ? Text("Data Tidak Ditemukan")
                          : ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: _task.length,
                              itemBuilder: (BuildContext context, int i) {
                                String gardens =
                                    garden[_selectedIndexs].garden_name;
                                String st = _task[i].start_date;
                                String tid = _task[i].task_id.toString();
                                String ed = _task[i].end_date;
                                String tt = _task[i].task_type;
                                String t = _task[i].treatment;
                                String a = _task[i].annotation;
                                String stat = _task[i].status;
                                return Visibility(
                                  visible: stat == 'Assigned' ? true : false,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Icon(Icons.location_on),
                                                Text("$gardens"),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              print(tid);
                                              _showMyDialog("$tid");
                                            },
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons
                                                      .calendar_today_rounded),
                                                  SizedBox(width: 10),
                                                  Text("$st - $ed")
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1,
                                                  child: Checkbox(
                                                    checkColor: Colors.white70,
                                                    activeColor: Colors.black,
                                                    value: (stat == "Assigned")
                                                        ? assigned[i]
                                                        : done[i],
                                                    onChanged:
                                                        (bool value) async {
                                                      await updateTask(tid);
                                                      setState(() {
                                                        _task[i].status =
                                                            'Done';
                                                        if (stat ==
                                                            "Assigned") {
                                                          assigned[i] = value;
                                                        } else {
                                                          done[i] = value;
                                                        }
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    'Data berhasil di update')));
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  // Text("Perlakuan", style: content),
                                                  child: Text("Jenis Perlakuan",
                                                      style: content),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  //     Text("Pupuk Anorganik NPK kontol",
                                                  child: Text("$tt",
                                                      style: content1),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1,
                                                  child: Container()),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: Text("Perlakuan",
                                                    style: content),
                                              ),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  child: Text(
                                                    "$t",
                                                    style: content1,
                                                  )),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            child: Text("$a"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text("Done Task"),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 1), // changes position of shadow
                      )
                    ],
                  ),
                  child: _task.isEmpty
                      ? Text("Data Tidak Ditemukan")
                      : ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: _task.length,
                          itemBuilder: (BuildContext context, int i) {
                            String gardens =
                                garden[_selectedIndexs].garden_name;
                            String st = _task[i].start_date;
                            String tid = _task[i].task_id.toString();
                            String ed = _task[i].end_date;
                            String tt = _task[i].task_type;
                            String t = _task[i].treatment;
                            String a = _task[i].annotation;
                            String stat = _task[i].status;
                            print(_task.length);
                            return Visibility(
                              visible: stat == 'Done' ? true : false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Icon(Icons.location_on),
                                            Text("$gardens"),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          print(tid);
                                          _showMyDialog("$tid");
                                        },
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                  Icons.calendar_today_rounded),
                                              SizedBox(width: 10),
                                              Text("$st - $ed")
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              // child: Checkbox(
                                              //   checkColor: Colors.white70,
                                              //   activeColor: Colors.black,
                                              //   value: (stat == "Assigned")
                                              //       ? assigned[i]
                                              //       : done[i],
                                              //   onChanged: (bool value) {
                                              //     updateTask(tid);
                                              //     setState(() {
                                              //       if (stat == "Assigned") {
                                              //         assigned[i] = value;
                                              //       } else {
                                              //         done[i] = value;
                                              //       }
                                              //     });
                                              //   },
                                              // ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              // Text("Perlakuan", style: content),
                                              child: Text("Jenis Perlakuan",
                                                  style: content),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              //     Text("Pupuk Anorganik NPK kontol",
                                              child:
                                                  Text("$tt", style: content1),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              child: Container()),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            child: Text("Perlakuan",
                                                style: content),
                                          ),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              child: Text(
                                                "$t",
                                                style: content1,
                                              )),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text("$a"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          )),
    );
  }
}
// ListView(
//   padding: EdgeInsets.all(20),
//   children: [
//     Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           "My Task",
//           style: TextStyle(
//             fontSize: 16,
//             fontFamily: 'PoppinsStyle',
//             fontStyle: FontStyle.normal,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         FlatButton(
//           textColor: Colors.grey,
//           highlightColor: Colors.transparent,
//           splashColor: Colors.transparent,
//           child: Text(
//             "See All",
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.black,
//               fontFamily: 'PoppinsStyle',
//               fontStyle: FontStyle.normal,
//               fontWeight: FontWeight.w100,
//             ),
//           ),
//           onPressed: () {
//             setState(() {
//               visibilityCard = !visibilityCard;
//             });
//           },
//         ),
//       ],
//     ),
//     // SizedBox(height: 10.0),
//     cardGardenList(),
//     if (!this.visibilityCard)
//       for (int i = 0; i < 2; i++) cardGardenList(),
//   ],
// );
