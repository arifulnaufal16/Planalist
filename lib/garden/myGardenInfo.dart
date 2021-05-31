import 'dart:convert';
import 'package:Planalist/home.dart';
import 'package:custom_dropdown/custom_dropdown.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Planalist/main.dart' as main;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class MyGardenInfo extends StatefulWidget {
  @override
  _MyGardenInfoState createState() => _MyGardenInfoState();
  final int garden_id;
  final String garden_name;
  MyGardenInfo(this.garden_id, this.garden_name);
}

class Garden {
  final int garden_id;
  final String garden_name;
  final int size_m2;
  final String location;
  Garden({
    this.garden_id,
    this.garden_name,
    this.size_m2,
    this.location,
  });
  factory Garden.fromJson(Map<String, dynamic> json) {
    return Garden(
      garden_id: json['garden_id'],
      garden_name: json['garden_name'],
      size_m2: json['size_m2'],
      location: json['location'],
    );
  }
}

Garden gardens = new Garden();
GardenUpdate gardenUpdate = new GardenUpdate();

class GardenUpdate {
  final String garden_name;
  final String size_m2;
  final String location;
  GardenUpdate({this.garden_name, this.size_m2, this.location});
  factory GardenUpdate.fromJson(Map<String, dynamic> json) {
    return new GardenUpdate(
      garden_name: json['garden_name'],
      size_m2: json['size_m2'],
      location: json['location'],
    );
  }
}

class _MyGardenInfoState extends State<MyGardenInfo> {
  final _formKey = GlobalKey<FormState>();

  Future<Null> deleteGarden(String gid) async {
    String lh = main.defaultLocalhost;
    http.Response response = await http.delete('$lh/api/gardens/$gid');
    setState(() {
      final data = jsonDecode(response.body);
    });
  }

  List _garden;
  Future<Garden> getGarden(String gid) async {
    String lh = main.defaultLocalhost;
    final http.Response response = await http.get('$lh/api/gardens/$gid');
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      gardens = Garden.fromJson(userMap);
      setState(() {});
    }
  }

  Future<GardenUpdate> updatePlant(
      String gid, String gn, String sz, String lc) async {
    String lh = main.defaultLocalhost;
    final http.Response response =
        await http.put('$lh/api/gardens/$gid', body: {
      "garden_id": gid,
      "garden_name": gn,
      "size_m2": sz,
      "location": lc,
    });
    if (response.statusCode == 200) {
      final jsonObject = jsonEncode(response.body);
      print(jsonObject);
      setState(() {});
    }
  }

  void initialize() async {}

  void initState() {
    super.initState();
    getGarden(widget.garden_id.toString());

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
                deleteGarden(pid);
                Navigator.pop(context);
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
    String gname;
    String size;
    String location;
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
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("Update Garden"),
                            SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                setState(() {
                                  gname = value;
                                  // width = int.parse(w);
                                });
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Masukkan nama garden';
                                }
                              },
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Colors.transparent,
                                filled: true,
                                labelText: "Nama Garden",
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
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              onSaved: (value) {
                                setState(() {
                                  size = value;
                                  // width = int.parse(w);
                                });
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Masukkan luas garden';
                                }
                              },
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Colors.transparent,
                                filled: true,
                                labelText: "Ukuran (m2)",
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
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                setState(() {
                                  location = value;
                                  // width = int.parse(w);
                                });
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Masukkan lokasi garden';
                                }
                              },
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Colors.transparent,
                                filled: true,
                                labelText: "Lokasi",
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
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                child: Text("Submit"),
                                onPressed: () {
                                  if (_formKey.currentState.validate() ==
                                      true) {
                                    _formKey.currentState.save();
                                    updatePlant(widget.garden_id.toString(),
                                        gname, size, location);
                                    setState(() {
                                      getGarden(widget.garden_id.toString());
                                    });
                                    Navigator.pop(
                                      context,
                                    );
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  void handleClick(String value) {
    switch (value) {
      case 'Edit':
        _showMyDialogEdit(widget.garden_id.toString());
        setState(() {});
        break;
      case 'Delete':
        _showMyDialog(widget.garden_id.toString());
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
    String gid = widget.garden_id.toString();
    String gname = gardens.garden_name;
    String size = gardens.size_m2.toString();
    String loc = gardens.location;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.navigate_before),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context, gardens.garden_id);
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
                        Text("$gid", style: boldFont),
                        SizedBox(height: 6),
                        Text("Garden Nmae : $gname", style: descFont),
                        SizedBox(height: 6),
                        Text("Lokasi : $loc", style: descFont),
                        SizedBox(height: 6),
                        Text("Ukuran per meter kubik: $size", style: descFont),
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
