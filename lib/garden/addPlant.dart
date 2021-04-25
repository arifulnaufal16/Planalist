import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPlant extends StatefulWidget {
  @override
  _AddPlantState createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
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
  );
  FocusNode myFocusNode = new FocusNode();

  Widget titleContent() {
    return Container(
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Color(0xffFDCF09),
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
                  Flexible(
                    child: TextField(
                      autofocus: false,
                      style: TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.transparent,
                        filled: true,
                        labelText: "Name",
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
                child: Text("Deskripsi"),
              ),
              SizedBox(height: 10),
              Container(
                height: 100,
                child: TextField(
                  maxLines: 5,
                  autofocus: false,
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.transparent,
                    labelText: "Description",
                    labelStyle: TextStyle(
                        color:
                            FocusNode().hasFocus ? Colors.blue : Colors.grey),
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
              )
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
        title: Text("Detail", style: header),
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
