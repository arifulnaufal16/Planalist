import 'package:Planalist/home.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MyTreeDetails extends StatefulWidget {
  @override
  _MyTreeDetailsState createState() => _MyTreeDetailsState();
}

class _MyTreeDetailsState extends State<MyTreeDetails> {
  static const TextStyle header = const TextStyle(
    color: Colors.black,
    fontFamily: 'PoppinsStyle',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w100,
  );

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
                        Text("#01 Durian", style: boldFont),
                        SizedBox(height: 6),
                        Text("Kebon Durian Jaksel", style: descFont)
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
                          2: FlexColumnWidth(2),
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
                                    "Tanggal",
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
                                    "Kondisi",
                                    style: tableFont,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          for (var i = 0; i < 5; i++)
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
                                    "14/08/2000",
                                    style: tableFont,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Icon(Icons.upgrade),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text("Siram Pohon", style: tableFont),
                                ),
                              ],
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reminder",
                      style: boldFont,
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Table(
                        border: TableBorder.symmetric(),
                        columnWidths: const <int, TableColumnWidth>{
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: <TableRow>[
                          for (var i = 0; i < 5; i++)
                            TableRow(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Text(
                                    "14/08/2000",
                                    style: tableFont,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Text(
                                    "Siram Pohon",
                                    style: tableFont,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    )
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
