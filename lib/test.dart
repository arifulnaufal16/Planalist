import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

int x = 0;
Color mainColor = Color(0xFF2B9348);
Color secondColor = Color(0xffA3F7BF);

class _TestState extends State<Test> {
  int _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 120.0,
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () {
                        setState(() {
                          if (_selectedIndex == index) {
                            _selectedIndex = -1;
                          } else {
                            _selectedIndex = index;
                          }
                        });
                      },
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: index == _selectedIndex
                                    ? mainColor
                                    : secondColor,
                              ),
                              child: Center(
                                child: Text(
                                  'ALL',
                                  style: TextStyle(
                                      color: index == _selectedIndex
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          Text("Garden")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                'Demo Headline 2',
                style: TextStyle(fontSize: 18),
              ),
              Container(
                child: Text(x.toString()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
