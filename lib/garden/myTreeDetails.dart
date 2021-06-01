import 'dart:convert';
import 'package:Planalist/home.dart';
import 'package:custom_dropdown/custom_dropdown.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Planalist/main.dart' as main;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../loading.dart';

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
  final String updatedAt;
  final List<Growths> growths;
  Plant(
      {this.plant_code,
      this.height,
      this.width,
      this.plant_type,
      this.status,
      this.updatedAt,
      this.growths});
  factory Plant.fromJson(Map<String, dynamic> json) {
    var list = json['growths'] as List;
    List<Growths> growthslist = list.map((i) => Growths.fromJson(i)).toList();
    return new Plant(
      plant_code: json['plant_code'],
      height: json['height'],
      width: json['width'],
      plant_type: json['plant_type'],
      status: json['status'],
      updatedAt: json['updatedAt'],
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
PlantUpdate plantsupdate = new PlantUpdate();

class PlantUpdate {
  final int height;
  final int width;
  final String status;
  final String updatedBy;
  PlantUpdate({this.height, this.width, this.status, this.updatedBy});
  factory PlantUpdate.fromJson(Map<String, dynamic> json) {
    return new PlantUpdate(
      height: json['height'],
      width: json['width'],
      status: json['status'],
    );
  }
}

class _MyTreeDetailsState extends State<MyTreeDetails> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _formkey1 = new GlobalKey<ScaffoldState>();

  bool isLoading = true;
  Future<Null> deletePlant(String pid) async {
    String lh = main.defaultLocalhost;
    http.Response response = await http.delete('$lh/api/gardens/plants/$pid');
    final data = jsonEncode(response.body);
    print(data);
    if (mounted) {
      setState(() {});
    }
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
      print(plants);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<PlantUpdate> updatePlant(
      String pid, String h, String w, String s) async {
    String lh = main.defaultLocalhost;
    final http.Response response =
        await http.put('$lh/api/gardens/plants/$pid', body: {
      "plant_id": pid,
      "height": h,
      "width": w,
      "status": s,
    });
    if (response.statusCode == 200) {
      final jsonObject = jsonEncode(response.body);
      getPlant(pid);
      print(jsonObject);
      setState(() {});
    }
  }

  void initz() async {
    getPlant(widget.plant_id);
  }

  void initState() {
    super.initState();
    initz();
    // _showMyDialogEdit(widget.plant_id);
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
      useRootNavigator: false,
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
                Navigator.pop(context);
                String x;
                Navigator.pop(context, x);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Pohon berhasil dihapus')));

                // Navigator.pop(context);
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

  int _checkboxValue;
  Future _showMyDialogEdit(String pid) {
    String height;
    String width;
    String status;

    List<String> myList = ['HEALTHY', 'SICK'];
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      right: -40.0,
                      top: -40.0,
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          child: Icon(Icons.close),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Update Pohon"),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  onSaved: (value) {
                                    setState(() {
                                      height = value;
                                      // height = int.parse(h);
                                    });
                                  },
                                  autofocus: false,
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    labelText: "Height",
                                    labelStyle: TextStyle(
                                        color: FocusNode().hasFocus
                                            ? Colors.blue
                                            : Colors.grey),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 6.0, top: 8.0),
                                    focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  onSaved: (value) {
                                    setState(() {
                                      width = value;
                                      // width = int.parse(w);
                                    });
                                  },
                                  autofocus: false,
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    labelText: "Diameter",
                                    labelStyle: TextStyle(
                                        color: FocusNode().hasFocus
                                            ? Colors.blue
                                            : Colors.grey),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 6.0, top: 8.0),
                                    focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomDropdown(
                              valueIndex: _checkboxValue,
                              hint: "Status",
                              disabledColor: Colors.grey.shade100,
                              enabledColor: Colors.grey.shade200,
                              items: [
                                CustomDropdownItem(text: "HEALTHY"),
                                CustomDropdownItem(text: "SICK"),
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  _checkboxValue = newValue;
                                  print(_checkboxValue);
                                  status = myList[newValue];
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              child: Text("Submit"),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  updatePlant(
                                      widget.plant_id, height, width, status);
                                  Navigator.pop(context);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Pohon berhasil di update')));
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  String convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    String x = (formatDate(todayDate, [yyyy, '/', mm, '/', dd]));
    return x;
  }

  void handleClick(String value) async {
    switch (value) {
      case 'Edit':
        _showMyDialogEdit(widget.plant_id);

        break;
      case 'Delete':
        await _showMyDialog(widget.plant_id);
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
    String pupd = plants.updatedAt;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.navigate_before),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context, g);
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
        body: isLoading == true
            ? Loading()
            : Container(
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
                                3: FlexColumnWidth(1),
                              },
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: <TableRow>[
                                TableRow(
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "Tanggal Update",
                                          style: tableFont,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "Tinggi",
                                          style: tableFont,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "Diameter",
                                          style: tableFont,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "Status",
                                          style: tableFont,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade300,
                                              width: 1))),
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        convertDateFromString(plants.updatedAt),
                                        style: tableFont,
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        plants.height.toString(),
                                        style: tableFont,
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        plants.width.toString(),
                                        style: tableFont,
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child:
                                          Text(plants.status, style: tableFont),
                                    ),
                                  ],
                                ),
                                if (plants.growths.length != null)
                                  for (var i = 0;
                                      i < plants.growths.length;
                                      i++)
                                    TableRow(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey.shade300,
                                                  width: 1))),
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            convertDateFromString(
                                                plants.growths[i].updatedAt),
                                            style: tableFont,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            plants.growths[i].width.toString(),
                                            style: tableFont,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            plants.growths[i].height.toString(),
                                            style: tableFont,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
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
