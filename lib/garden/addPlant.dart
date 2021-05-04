import 'dart:io';
import 'package:Planalist/home.dart';
import 'package:custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

class AddPlant extends StatefulWidget {
  @override
  _AddPlantState createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
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
    return Container(
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
                child: TextField(
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
                  hint: "Garden",
                  disabledColor: Colors.grey.shade100,
                  enabledColor: Colors.grey.shade200,
                  items: [
                    CustomDropdownItem(text: "General"),
                    CustomDropdownItem(text: "Garden"),
                    CustomDropdownItem(text: "Other"),
                  ],
                  onChanged: (newValue) {
                    setState(() => _checkboxValue = newValue);
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
                    child: TextField(
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
                    child: TextField(
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
                      Navigator.pop(
                        context,
                        // PageTransition(
                        //     type: PageTransitionType.fade,
                        //     duration: Duration(milliseconds: 500),
                        //     // child: Home(),
                        //     ctx: context),
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

class _checkboxValue {}
