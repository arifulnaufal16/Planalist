import 'package:Planalist/login.dart';
import 'package:flutter/material.dart';
import 'package:Planalist/splashscreen.dart';
import 'package:page_transition/page_transition.dart';

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
    'image/image1.png',
    '',
  ];

  List<String> titles = [
    'Title1',
    'Title2',
    'Title3',
    'WELCOME',
    '',
  ];

  List<String> description = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit q.',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit s.',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit r.',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit t.',
    '',
  ];
  bool myButton = false;
  bool visibleScroll = true;
  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages - 1; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return Visibility(
      visible: true,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        height: 15.0,
        width: 15.0,
        decoration: BoxDecoration(
          color: isActive ? Colors.green : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
      ),
    );
  }

  Widget infoPage(photos, titles, description, i) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage(photos[i]),
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.0),
                Text(
                  titles[i],
                  style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'PoppinsStyle',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w200),
                ),
                SizedBox(height: 15.0),
                Text(
                  description[i],
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'PoppinsStyle',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonNext() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
          _currentPage != _numPages - 1
              ? Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: FlatButton(
                      height: 50,
                      minWidth: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Colors.amber,
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                            size: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: FlatButton(
                      height: 50,
                      minWidth: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Colors.amber,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: Login(),
                              duration: Duration(microseconds: 800),
                              ctx: context),
                          // MaterialPageRoute(builder: (context) {
                          //   return Login();
                          // }),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(
              height: 600.0,
              child: PageView(
                physics: ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: <Widget>[
                  infoPage(photos, titles, description, 0),
                  infoPage(photos, titles, description, 1),
                  infoPage(photos, titles, description, 2),
                  infoPage(photos, titles, description, 3),
                ],
              ),
            ),
            buttonNext()
          ],
        ),
      ),
    );
  }
}
