import 'dart:convert';
import 'dart:io';
import 'package:Planalist/garden/myGardenDetails.dart';
import 'package:Planalist/main.dart' as main;
import 'package:http/http.dart' as http;
import 'package:custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class AddPlant extends StatefulWidget {
  @override
  _AddPlantState createState() => _AddPlantState();
  final int garden_id;
  final String garden_name;
  AddPlant(this.garden_id, this.garden_name);
}

class PostPlant {
  final String garden_id;
  // final String plant_id;
  final String plant_code;
  final String height;
  final String width;
  final String plant_type;
  final String created_by;
  PostPlant({
    this.garden_id,
    // this.plant_id,
    this.plant_code,
    this.height,
    this.width,
    this.plant_type,
    this.created_by,
  });
  factory PostPlant.fromJson(Map<String, dynamic> json) {
    return PostPlant(
        garden_id: json["garden_id"],
        // plant_id: json["plant_id"],
        plant_code: json["plant_code"],
        height: json["height"],
        width: json["width"],
        plant_type: json["plant_type"],
        created_by: json["created_by"]);
  }
  static Future<PostPlant> connectToAPI(
      String garden_id,
      // String plant_id,
      String plant_code,
      String height,
      String width,
      String plant_type,
      String created_by) async {
    String lh = main.defaultLocalhost;
    String apiURL = "$lh/api/gardens/plants";
    final apiResult = await http.post(apiURL, body: {
      "garden_id": garden_id,
      // "plant_id": plant_id,
      "plant_code": plant_code,
      "height": height,
      "width": width,
      "plant_type": plant_type,
      "created_by": created_by,
    });
    final jsonObject = jsonEncode(apiResult.body);
    print(jsonObject);
  }
}

class _AddPlantState extends State<AddPlant> {
  final formKey = GlobalKey<FormState>();
  String plant_code;
  String height;
  String width;
  String plant_type;
  PostPlant postPlant = null;
  int _checkboxValue;
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
    List<String> myList = ['Duren', 'Mangga', 'Kopi'];
    return Container(
      child: Form(
        key: formKey,
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
                  child: Text("No."),
                ),
                SizedBox(height: 10),
                Container(
                  child: TextFormField(
                    onSaved: (value) => setState(() => plant_code = value),
                    autofocus: false,
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.transparent,
                      filled: true,
                      labelText: "No.Tanaman",
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
                  child: Text("Jenis Pohon"),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomDropdown(
                    valueIndex: _checkboxValue,
                    hint: "Jenis Pohon",
                    disabledColor: Colors.grey.shade100,
                    enabledColor: Colors.grey.shade200,
                    items: [
                      CustomDropdownItem(text: "Duren"),
                      CustomDropdownItem(text: "Mangga"),
                      CustomDropdownItem(text: "Kopi"),
                    ],
                    onChanged: (newValue) {
                      setState(() {
                        _checkboxValue = newValue;
                        plant_type = myList[newValue];
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text("Tinggi"),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text("Diameter"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
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
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
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
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
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
                        PostPlant.connectToAPI(widget.garden_id.toString(),
                            plant_code, height, width, plant_type, "1");
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              duration: Duration(milliseconds: 500),
                              child: MyGardenDetails(
                                  widget.garden_id, widget.garden_name),
                              ctx: context),
                        );
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
        title: Text("Add Plant", style: header),
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
