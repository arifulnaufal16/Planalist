import 'package:Planalist/garden/addGarden.dart';
import 'package:Planalist/garden/addPlant.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'myTreeDetails.dart';

class MyGardenDetails extends StatefulWidget {
  @override
  _MyGardenDetailsState createState() => _MyGardenDetailsState();
}

class _MyGardenDetailsState extends State<MyGardenDetails> {
  final ValueNotifier<double> headerNegativeOffset = ValueNotifier<double>(0);
  final ValueNotifier<bool> appbarShadow = ValueNotifier<bool>(false);

  final double maxHeaderHeight = 250.0;
  final double minHeaderHeight = 56.0;
  final double bodyContentRatioMin = 0.6;
  final double bodyContentRatioMax = 1.0;

  ///must be between min and max values of body content ratio.
  final double bodyContentRatioParallax = .9;

  @override
  void dispose() {
    headerNegativeOffset.dispose();
    appbarShadow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //just for status bar color

      body: Stack(
        children: <Widget>[
          Stack(children: [
            Container(
                child: ValueListenableBuilder<double>(
                    valueListenable: headerNegativeOffset,
                    builder: (context, offset, child) {
                      return Transform.translate(
                        offset: Offset(0, offset * -1),
                        child: SizedBox(
                          child: Container(
                            child: Image(
                              image: AssetImage('image/image1.png'),
                            ),
                          ),
                        ),
                      );
                    })),
            NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                if (notification.extent == bodyContentRatioMin) {
                  appbarShadow.value = false;
                  headerNegativeOffset.value = 0;
                } else if (notification.extent == bodyContentRatioMax) {
                  appbarShadow.value = true;
                  headerNegativeOffset.value =
                      maxHeaderHeight - minHeaderHeight;
                } else {
                  double newValue = (maxHeaderHeight - minHeaderHeight) -
                      ((maxHeaderHeight - minHeaderHeight) *
                          ((bodyContentRatioParallax - (notification.extent)) /
                              (bodyContentRatioMax -
                                  bodyContentRatioParallax)));
                  appbarShadow.value = false;
                  if (newValue >= maxHeaderHeight - minHeaderHeight) {
                    appbarShadow.value = true;
                    newValue = maxHeaderHeight - minHeaderHeight;
                  } else if (newValue < 0) {
                    appbarShadow.value = false;
                    newValue = 0;
                  }
                  headerNegativeOffset.value = newValue;
                }
                return true;
              },
              child: Stack(
                children: <Widget>[
                  DraggableScrollableSheet(
                    initialChildSize: bodyContentRatioMin,
                    minChildSize: bodyContentRatioMin,
                    maxChildSize: bodyContentRatioMax,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Stack(
                        children: <Widget>[
                          Container(
                            child: Material(
                              type: MaterialType.canvas,
                              color: Colors.white,
                              elevation: 2.0,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24.0),
                                topRight: Radius.circular(24.0),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Divider(
                                        indent:
                                            MediaQuery.of(context).size.width /
                                                    4 +
                                                20,
                                        endIndent:
                                            MediaQuery.of(context).size.width /
                                                    4 +
                                                20,
                                        thickness: 5,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "Durian Garden",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30,
                                          fontFamily: 'PoppinsStyle',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      child: Text(
                                        "Garden Ciputat",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 16,
                                          fontFamily: 'PoppinsStyle',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          prefixIcon: Container(
                                            // add padding to adjust icon
                                            child: Icon(
                                              Icons.search,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 0.0,
                                            horizontal: 20,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      child: Divider(
                                        indent: 20,
                                        endIndent: 20,
                                        thickness: 5,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Center(
                                      child: ButtonTheme(
                                        minWidth:
                                            MediaQuery.of(context).size.width,
                                        child: RaisedButton(
                                          // onPressed: () {},

                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  child: AddPlant(),
                                                  ctx: context),
                                            );
                                          },
                                          color: Colors.green,
                                          splashColor: Colors.green,
                                          child: Text(
                                            "Add Plant",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                                fontFamily: 'PoppinsStyle',
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w100),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Expanded(
                                      child: MediaQuery.removePadding(
                                        context: context,
                                        removeTop: true,
                                        child: ListView.builder(
                                          controller: scrollController,
                                          itemCount: 20,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // if you need this
                                                  side: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    width: 1,
                                                  ),
                                                ),
                                                child: InkWell(
                                                    splashColor: Colors.blue
                                                        .withAlpha(30),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .fade,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    800),
                                                            child:
                                                                MyTreeDetails(),
                                                            ctx: context),
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(15),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 20),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          60.0),
                                                              child: Image(
                                                                image: AssetImage(
                                                                    'image/image1.png'),
                                                                height: 60,
                                                              ),
                                                            ),
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  "#01 Durian"),
                                                              Text(
                                                                  "Kebon Durian Jaksel"),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            )
          ]),
        ],
      ),
    );
  }
}
