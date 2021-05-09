import 'package:Planalist/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

String defaultLocalhost = 'http://192.168.43.4:3000';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
