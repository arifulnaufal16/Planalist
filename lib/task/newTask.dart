import 'dart:convert';
import 'package:Planalist/task/myTask.dart';
import 'package:custom_dropdown/custom_dropdown.dart';
import 'package:Planalist/main.dart' as main;
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:http/http.dart' as http;
import 'package:group_button/group_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'taskListDetail.dart';
import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  _NewTaskState createState() => _NewTaskState();
}

class Garden {
  final int garden_id;
  final String garden_name;
  Garden({this.garden_id, this.garden_name});
  factory Garden.fromJson(Map<String, dynamic> json) {
    return Garden(
      garden_id: json['garden_id'],
      garden_name: json['garden_name'],
    );
  }
}

class PostTask {
  final String garden_id;
  final String task_type;
  final String treatment;
  final String annotation;
  final String status;
  final String start_date;
  final String end_date;
  final String created_by;

  PostTask(
      {this.garden_id,
      this.task_type,
      this.treatment,
      this.annotation,
      this.status,
      this.start_date,
      this.end_date,
      this.created_by});
  factory PostTask.fromJson(Map<String, dynamic> json) {
    return PostTask(
      garden_id: json["garden_id"],
      // plant_id: json["plant_id"],
      task_type: json["task_type"],
      treatment: json["treatment"],
      annotation: json["annotation"],
      status: json["status"],
      start_date: json["start_date"],
      end_date: json["end_date"],
      created_by: json["created_by"],
    );
  }
  static Future<PostTask> connectToAPI(
    String garden_id,
    // String plant_id,
    String task_type,
    String treatment,
    String annotation,
    String status,
    String start_date,
    String end_date,
    String created_by,
  ) async {
    String lh = main.defaultLocalhost;
    String apiURL = "$lh/api/tasks";
    final apiResult = await http.post(apiURL, body: {
      "garden_id": garden_id,
      // "plant_id": plant_id,
      "task_type": task_type,
      "treatment": treatment,
      "annotation": annotation,
      "status": status,
      "start_date": start_date,
      "end_date": end_date,
      "created_by": created_by,
    });
    final jsonObject = jsonEncode(apiResult.body);
    print(jsonObject);
  }
}

class _NewTaskState extends State<NewTask> {
  final formKey = GlobalKey<FormState>();
  int _kebun;
  int _perlakuan = 0;
  int _jenis = 0;

  String garden_id;
  String task_type;
  String treatment;
  String annotation;
  String status;
  String created_by;
  DateTime selectedDateNow = DateTime.now();
  DateTime selectedDateEnd = DateTime.now();

  String startdate;
  String enddate;

  List data;
  List garden;
  Future<List<Garden>> getGardens() async {
    String lh = main.defaultLocalhost;
    http.Response response = await http.get('$lh/api/gardens');
    data = json.decode(response.body);
    garden = data.map((garden) => Garden.fromJson(garden)).toList();
    setState(() {});
  }

  _selectDateNow(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDateNow, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDateNow)
      setState(() {
        selectedDateNow = picked;
      });
  }

  _selectDateEnd(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDateEnd, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDateEnd)
      setState(() {
        selectedDateEnd = picked;
      });
  }

  List<String> jenisKegiatan = ['Pemberian Pupuk', 'Pemberian Obat'];
  List<String> pupuk = [
    'Pemupukan Organik',
    'Penyemprotan Pupuk Daun',
    'Penyemprotan Kocor',
    'Penyemprotan Anorganik NPK'
  ];
  List<String> obat = [
    'Penyemprotan Obat Insektisida',
    'Penyemprotan Obat Fungisida'
  ];

  void initState() {
    super.initState();
    getGardens();
  }

  @override
  Widget build(BuildContext context) {
    int x = garden != null ? garden.length : 0;
    return MaterialApp(
      home: Form(
        key: formKey,
        child: Scaffold(
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
                          child: TaskListDetail(),
                          ctx: context),
                    );
                  },
                ),
                title: Container(
                  child: Text(
                    "Add Task",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () async {
                        formKey.currentState.save();
                        if (startdate == null) {
                          startdate = DateTime.now().toString();
                          print(startdate);
                        }
                        if (enddate == null) {
                          enddate = DateTime.now().toString();
                          print(enddate);
                        }
                        if (garden_id == null ||
                            task_type == null ||
                            treatment == null ||
                            annotation == null) {
                        } else {
                          await PostTask.connectToAPI(
                              garden_id,
                              task_type,
                              treatment,
                              annotation,
                              "Assigned",
                              startdate,
                              enddate,
                              "1");
                          Navigator.pop(
                            context,
                            garden_id,
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
          body: Container(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text("Nama Kebun"),
                      SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: x == 0
                            ? Container()
                            : CustomDropdown(
                                openColor: Colors.grey.shade100,
                                valueIndex: _kebun,
                                hint: "Nama Kebun",
                                items: [
                                  for (int i = 0; i < x; i++)
                                    CustomDropdownItem(
                                        text: garden[i].garden_name),
                                ],
                                onChanged: (newValue) {
                                  setState(() {
                                    _kebun = newValue;
                                    garden_id =
                                        garden[_kebun].garden_id.toString();
                                    print(garden_id);
                                  });
                                },
                              ),
                      ),
                      SizedBox(height: 20),
                      Text("Jenis Kegiatan"),
                      SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CustomDropdown(
                          openColor: Colors.grey.shade100,
                          valueIndex: _perlakuan,
                          hint: "Jenis Kegiatan",
                          items: [
                            CustomDropdownItem(text: "Pemberian Pupuk"),
                            CustomDropdownItem(text: "Pemberian Obat"),
                          ],
                          onChanged: (newValue) {
                            setState(() {
                              _perlakuan = newValue;
                              _jenis = 0;
                              task_type = jenisKegiatan[_perlakuan];
                              print(task_type);
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      if (_perlakuan == 0) Text("Jenis Pupuk"),
                      if (_perlakuan == 1) Text("Jenis Obat"),
                      SizedBox(height: 5),
                      if (_perlakuan == 0)
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CustomDropdown(
                            openColor: Colors.grey.shade100,
                            valueIndex: _jenis,
                            hint: "Jenis Pupuk",
                            items: [
                              CustomDropdownItem(text: "Pemupukan Organik"),
                              CustomDropdownItem(
                                  text: "Penyemprotan Pupuk Daun"),
                              CustomDropdownItem(text: "Penyemprotan Kocor"),
                              CustomDropdownItem(
                                  text: "Penyemprotan Anorganik NPK")
                            ],
                            onChanged: (newValue) {
                              setState(() {
                                _jenis = newValue;
                                treatment = pupuk[_jenis];
                                print(treatment);
                              });
                            },
                          ),
                        ),
                      if (_perlakuan == 1)
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CustomDropdown(
                            openColor: Colors.grey.shade100,
                            valueIndex: _jenis,
                            hint: "Jenis Obat",
                            items: [
                              CustomDropdownItem(
                                  text: "Penyemprotan Obat Insektisida"),
                              CustomDropdownItem(
                                  text: "Penyemprotan Obat Fungisida"),
                            ],
                            onChanged: (newValue) {
                              setState(() {
                                _jenis = newValue;
                                treatment = obat[_jenis];
                                print(treatment);
                              });
                            },
                          ),
                        ),
                      SizedBox(height: 20),
                      Text("Keterangan"),
                      SizedBox(height: 5),
                      Container(
                        height: 100,
                        child: TextFormField(
                          onSaved: (value) {
                            setState(() {
                              annotation = value;
                              print(annotation);
                              // width = int.parse(w);
                            });
                          },
                          maxLines: 5,
                          autofocus: false,
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.transparent,
                            labelStyle: TextStyle(
                                color: FocusNode().hasFocus
                                    ? Colors.blue
                                    : Colors.grey),
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 6.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text("Rentang Mulai"),
                      SizedBox(height: 5),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            _selectDateNow(context);
                            startdate =
                                "${selectedDateNow.toLocal()}".split(' ')[0];
                            print(startdate);
                          }, // Refer step 3
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_today_rounded),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "${selectedDateNow.toLocal()}".split(' ')[0],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text("Rentang Selesai"),
                      SizedBox(height: 5),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            _selectDateEnd(context);
                            enddate =
                                "${selectedDateEnd.toLocal()}".split(' ')[0];
                            print(enddate);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_today_rounded),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "${selectedDateEnd.toLocal()}".split(' ')[0],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                      // Column(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: <Widget>[
                      //     Text(
                      //       "${selectedDate.toLocal()}".split(' ')[0],
                      //       style: TextStyle(
                      //           fontSize: 55, fontWeight: FontWeight.bold),
                      //     ),
                      //     SizedBox(
                      //       height: 20.0,
                      //     ),
                      //     RaisedButton(
                      //       onPressed: () =>
                      //           _selectDate(context), // Refer step 3
                      //       child: Text(
                      //         'Select date',
                      //         style: TextStyle(
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //       color: Colors.greenAccent,
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
