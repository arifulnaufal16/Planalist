import 'dart:convert';
import 'package:Planalist/home.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Planalist/main.dart' as main;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class MyTreeDetails extends StatefulWidget {
  @override
  _MyTreeDetailsState createState() => _MyTreeDetailsState();
  final String plant_id;
  final String garden_name;
  MyTreeDetails(this.plant_id, this.garden_name);
}

class Plant {
  final String plant_code;
  final int height;
  final int width;
  final String plant_type;
  final String status;
  final List<Growths> growths;
  Plant(
      {this.plant_code,
      this.height,
      this.width,
      this.plant_type,
      this.status,
      this.growths});
  factory Plant.fromJson(Map<String, dynamic> json) {
    var list = json['growths'] as List;
    print(list.runtimeType);
    List<Growths> growthslist = list.map((i) => Growths.fromJson(i)).toList();
    return new Plant(
      plant_code: json['plant_code'],
      height: json['height'],
      width: json['width'],
      plant_type: json['plant_type'],
      status: json['status'],
      growths: growthslist,
    );
  }
}

class Growths {
  final int growth_id;
  final int height;
  final int width;
  final String status;
  final String updatedAt;

  Growths(
      {this.growth_id, this.height, this.width, this.status, this.updatedAt});
  factory Growths.fromJson(Map<String, dynamic> json) {
    return new Growths(
      growth_id: json['growth_id'],
      height: json['height'],
      width: json['width'],
      status: json['status'],
      updatedAt: json['updatedAt'],
    );
  }
}

Plant plants = new Plant();

class _MyTreeDetailsState extends State<MyTreeDetails> {
  Future<Null> deletePlant(String pid) async {
    String lh = main.defaultLocalhost;
    http.Response response = await http.delete('$lh/api/gardens/plants/$pid');
    setState(() {
      final data = jsonDecode(response.body);
    });
  }

  List _plant;
  Future<Plant> getPlant(String pid) async {
    List<Plant> _data1 = [];
    String lh = main.defaultLocalhost;
    final http.Response response =
        await http.get('$lh/api/gardens/plants/$pid');
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      plants = Plant.fromJson(userMap);
      setState(() {});
    }
  }

  void initState() {
    super.initState();
    getPlant(widget.plant_id);
  }

  static const TextStyle header = const TextStyle(
    color: Colors.black,
    fontFamily: 'PoppinsStyle',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w100,
  );

  Future<void> _showMyDialog(String pid) async {
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
                deletePlant(pid);
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    duration: Duration(milliseconds: 800),
                    child: Home(),
                    ctx: context,
                  ),
                );
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

  String convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    String x = (formatDate(todayDate, [yyyy, '/', mm, '/', dd]));
    return x;
  }

  void handleClick(String value) {
    switch (value) {
      case 'Edit':
        setState(() {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 800),
                // child: ,
                ctx: context),
          );
        });
        break;
      case 'Delete':
        _showMyDialog(widget.plant_id);
        setState(() {});
        break;
    }
  }

  static const TextStyle boldFont = const TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: 'PoppinsStyle',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle descFont = const TextStyle(
    color: Colors.grey,
    fontSize: 12,
    fontFamily: 'PoppinsStyle',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w100,
  );
  static const TextStyle tableFont = const TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontFamily: 'PoppinsStyle',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w100,
  );

  @override
  Widget build(BuildContext context) {
    String g = widget.garden_name;
    String pcode = plants.plant_code;
    String ptype = plants.plant_type;
    String ph = plants.height.toString();
    String pw = plants.width.toString();
    String pstat = plants.status;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
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
                    ctx: context),
              );
            },
          ),
          title: Text("Detail", style: header),
          // actions: [
          //   IconButton(
          //     icon: Icon(
          //       Icons.more_vert,
          //       color: Colors.black,
          //     ),

          //   )
          // ],
          actions: <Widget>[
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Edit', 'Delete'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                    textStyle: choice == 'Delete'
                        ? TextStyle(color: Colors.red)
                        : TextStyle(color: Colors.black),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 20),
                      child: Image(
                        image: AssetImage("image/image1.png"),
                        height: 80,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("$pcode", style: boldFont),
                        SizedBox(height: 6),
                        Text("Lokasi : $g", style: descFont),
                        SizedBox(height: 6),
                        Text("Tipe tanaman : $ptype", style: descFont),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Deskripsi", style: boldFont),
                    SizedBox(height: 10),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer varius amet donec sed ornare. ",
                      style: tableFont,
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Kondisi", style: boldFont),
                    SizedBox(height: 10),
                    Container(
                      child: Table(
                        border: TableBorder.symmetric(),
                        columnWidths: const <int, TableColumnWidth>{
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: <TableRow>[
                          TableRow(
                            children: <Widget>[
                              Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Tanggal Update",
                                    style: tableFont,
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Tinggi",
                                    style: tableFont,
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Status",
                                    style: tableFont,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (plants.growths.length != null)
                            for (var i = 0; i < plants.growths.length; i++)
                              TableRow(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 1))),
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      convertDateFromString(
                                          plants.growths[i].updatedAt),
                                      style: tableFont,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      plants.growths[i].height.toString(),
                                      style: tableFont,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(plants.growths[i].status,
                                        style: tableFont),
                                  ),
                                ],
                              ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 10),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Reminder",
              //         style: boldFont,
              //       ),
              //       SizedBox(height: 10),
              //       Container(
              //         child: Table(
              //           border: TableBorder.symmetric(),
              //           columnWidths: const <int, TableColumnWidth>{
              //             0: FlexColumnWidth(1),
              //             1: FlexColumnWidth(1),
              //           },
              //           defaultVerticalAlignment:
              //               TableCellVerticalAlignment.middle,
              //           children: <TableRow>[
              //             for (var i = 0; i < 5; i++)
              //               TableRow(
              //                 children: <Widget>[
              //                   Container(
              //                     padding: EdgeInsets.symmetric(
              //                         vertical: 10, horizontal: 20),
              //                     child: Text(
              //                       "14/08/2000",
              //                       style: tableFont,
              //                     ),
              //                   ),
              //                   Container(
              //                     padding: EdgeInsets.symmetric(
              //                         vertical: 10, horizontal: 20),
              //                     child: Text(
              //                       "Siram Pohon",
              //                       style: tableFont,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
