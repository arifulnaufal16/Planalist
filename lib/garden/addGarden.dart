import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Planalist/main.dart' as main;
import 'package:http/http.dart' as http;

class AddGarden extends StatefulWidget {
  @override
  _AddGardenState createState() => _AddGardenState();
}

class PostGarden {
  final String garden_id;
  // final String plant_id;
  final String garden_name;
  final String size_m2;
  final String location;
  final String created_by;
  PostGarden({
    this.garden_id,
    // this.plant_id,
    this.garden_name,
    this.size_m2,
    this.location,
    this.created_by,
  });
  factory PostGarden.fromJson(Map<String, dynamic> json) {
    return PostGarden(
        garden_id: json["garden_id"],
        // plant_id: json["plant_id"],
        garden_name: json["garden_name"],
        size_m2: json["size_m2"],
        location: json["location"],
        created_by: json["created_by"]);
  }
  static Future<PostGarden> connectToAPI(
    String garden_name,
    String size_m2,
    String location,
    String created_by,
  ) async {
    String lh = main.defaultLocalhost;
    String apiURL = "$lh/api/gardens";
    final apiResult = await http.post(apiURL, body: {
      // "plant_id": plant_id,
      "garden_name": garden_name,
      "size_m2": size_m2,
      "location": location,
      "created_by": "1",
    });
    if (apiResult.statusCode == 200) {
      final jsonObject = jsonEncode(apiResult.body);
      print(jsonObject);
    }
  }
}

class _AddGardenState extends State<AddGarden> {
  final formKey = GlobalKey<FormState>();
  String garden_name;
  String size_m2;
  String location;
  File _image;
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  static const TextStyle header = const TextStyle(
      color: Colors.black,
      fontFamily: 'PoppinsStyle',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w100,
      fontSize: 16);
  FocusNode myFocusNode = new FocusNode();

  Widget titleContent() {
    return Form(
      key: formKey,
      child: Container(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.grey,
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                _image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50),
                              ),
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Text("Nama Garden"),
                ),
                SizedBox(height: 10),
                Container(
                  child: TextFormField(
                    onSaved: (newValue) {
                      garden_name = newValue;
                    },
                    autofocus: false,
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.transparent,
                      filled: true,
                      labelText: "Name",
                      labelStyle: TextStyle(
                          color:
                              FocusNode().hasFocus ? Colors.blue : Colors.grey),
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
                SizedBox(height: 20),
                Container(
                  child: Text("Lokasi garden"),
                ),
                SizedBox(height: 10),
                Container(
                  child: TextFormField(
                    autofocus: false,
                    onSaved: (newValue) {
                      location = newValue;
                    },
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.transparent,
                      filled: true,
                      labelText: "Lokasi",
                      labelStyle: TextStyle(
                          color:
                              FocusNode().hasFocus ? Colors.blue : Colors.grey),
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
                SizedBox(height: 20),
                Container(
                  child: Text("Ukuran Garden"),
                ),
                SizedBox(height: 10),
                Container(
                  child: TextFormField(
                    autofocus: false,
                    onSaved: (newValue) {
                      size_m2 = newValue;
                    },
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.transparent,
                      filled: true,
                      labelText: "m2",
                      labelStyle: TextStyle(
                          color:
                              FocusNode().hasFocus ? Colors.blue : Colors.grey),
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
                SizedBox(height: 20),
                SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text("Pohon"),
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text("Buah"),
                        )),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        autofocus: false,
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.transparent,
                          filled: true,
                          labelText: "Tree",
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
                      child: TextField(
                        autofocus: false,
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.transparent,
                          filled: true,
                          labelText: "Fruits",
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      // onPressed: () {},
                      onPressed: () {
                        formKey.currentState.save();
                        // print(widget.plant_length);
                        // print(plant_code.runtimeType);
                        PostGarden.connectToAPI(
                            garden_name, size_m2, location, "1");
                      },
                      color: Colors.green,
                      splashColor: Colors.green,
                      child: Text(
                        "Save Garden",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontFamily: 'PoppinsStyle',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.navigate_before,
          color: Colors.black,
        ),
        title: Text("Add Garden", style: header),
        actions: [
          Icon(
            Icons.more_vert,
            color: Colors.black,
          )
        ],
      ),
      body: Container(padding: EdgeInsets.all(20), child: titleContent()),
    ));
  }
}
