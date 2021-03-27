import 'package:Planalist/login.dart';
import 'package:flutter/material.dart';
import 'package:Planalist/splashscreen.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  int photoIndex = 0;
  int titleIndex = 0;
  int descIndex = 0;

  List<String> photos = [
    'image/image1.png',
    'image/image2.png',
    'image/image3.png',
    '',
  ];

  List<String> titles = [
    'Title1',
    'Title2',
    'Title3',
    '',
  ];

  List<String> description = [
    'lorem ipsum',
    'lorem ipsum',
    'lorem ipsum',
    '',
  ];
  bool myButton = false;

  void _nextImage() {
    setState(() {
      if (photoIndex < 1) {
        photoIndex = photoIndex + 1;
        titleIndex = titleIndex + 1;
        descIndex = descIndex + 1;
      } else if (photoIndex == 1) {
        myButton = true;
        photoIndex = photoIndex + 1;
      } else if (photoIndex > 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return Login();
          }),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(photos[photoIndex]),
                  fit: BoxFit.cover,
                ),
              ),
              height: 400,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(titles[titleIndex]),
                  Text(description[descIndex]),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    onPressed: _nextImage,
                    elevation: 0,
                    child: myButton
                        ? Text("Continue")
                        : Icon(Icons.navigate_next_rounded),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
