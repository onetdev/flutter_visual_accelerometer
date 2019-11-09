import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_visual_accelerometer/ui/home.dart';

void main() {
  /// For the sake of the table and our sanity, the orientation is locked into
  /// portrait
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Visual Accelerometer',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.teal[900],
        accentColor: Colors.cyan[600],
      ),
      home: Home(),
    );
  }
}