import 'package:custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  int _checkboxValue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Container(
            child: AppBar(
              backgroundColor: Colors.white,
              leading: Icon(
                Icons.navigate_before,
                color: Colors.black,
              ),
              title: Container(
                child: Text(
                  "Add Task",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {},
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
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text("Task Type"),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomDropdown(
                      valueIndex: _checkboxValue,
                      hint: "Hint",
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
                  Text("Nomor Pohon"),
                  SizedBox(height: 5),
                  Container(
                    child: TextField(
                      autofocus: false,
                      style: TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 6.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Nama Kegiatan"),
                  SizedBox(height: 5),
                  Container(
                    child: TextField(
                      autofocus: false,
                      style: TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 6.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Nama Kebun"),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomDropdown(
                      valueIndex: _checkboxValue,
                      hint: "Hint",
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}