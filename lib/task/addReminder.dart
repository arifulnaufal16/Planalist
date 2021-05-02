import 'dart:ffi';
import 'package:custom_dropdown/custom_dropdown.dart';
import 'package:group_button/group_button.dart';
import 'package:page_transition/page_transition.dart';
import 'taskListDetail.dart';
import 'package:flutter/material.dart';

class AddRemindedr extends StatefulWidget {
  _AddRemindedrState createState() => _AddRemindedrState();
}

List<bool> isSelected = List.generate(7, (_) => false);

class _AddRemindedrState extends State<AddRemindedr> {
  int _checkboxValue;
  int _checkboxValue1;
  List<bool> _isSelected = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text("Pupuk"),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomDropdown(
                        valueIndex: _checkboxValue,
                        hint: "Jenis Pupuk",
                        items: [
                          CustomDropdownItem(text: "Pemupukan Organik"),
                          CustomDropdownItem(text: "Penyemprotan Pupuk Daun"),
                          CustomDropdownItem(text: "Pemupukan Kocor"),
                          CustomDropdownItem(text: "Pemupukan Anorganik NPK"),
                        ],
                        onChanged: (newValue) {
                          setState(() => _checkboxValue = newValue);
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Obat"),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomDropdown(
                        valueIndex: _checkboxValue1,
                        hint: "Jenis Obat",
                        items: [
                          CustomDropdownItem(
                              text: "Penyemprotan Obat Insektisida"),
                          CustomDropdownItem(
                              text: "Penyemprotan Obat Fungisida"),
                        ],
                        onChanged: (newValue) {
                          setState(() => _checkboxValue = newValue);
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Center(
                child: GroupButton(
                  spacing: 2,
                  isRadio: false,
                  buttonWidth: 49,
                  buttonHeight: 70,
                  direction: Axis.horizontal,
                  onSelected: (index, isSelected) => print(
                      '$index button is ${isSelected ? 'selected' : 'unselected'}'),
                  buttons: ["SEN", "SEL", "RAB", "KAM", "JUM", "SAB", "MIN"],
                  selectedButtons: ["SEN"],
                  selectedTextStyle: TextStyle(
                    fontFamily: 'PoppinsStyle',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                    fontSize: 7,
                    color: Colors.white,
                  ),
                  unselectedTextStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 7,
                    color: Colors.black,
                  ),
                  selectedColor: Colors.green,
                  unselectedColor: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5.0),
                  selectedShadow: <BoxShadow>[
                    BoxShadow(color: Colors.transparent)
                  ],
                  unselectedShadow: <BoxShadow>[
                    BoxShadow(color: Colors.transparent)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
