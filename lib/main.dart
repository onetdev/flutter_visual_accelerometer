import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_visual_accelerometer/core/graph.dart';
import 'package:flutter_visual_accelerometer/core/stats_table.dart';
import 'package:sensors/sensors.dart';

void main() => runApp(MyApp());

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
      home: HomePage(),
    );
  }
}

class History<T> {
  History(this.limit);

  final int limit;
  var items = List<T>();

  get last => items[items.length - 1];

  add(T item) {
    if (items.length >= limit) items.removeAt(0);
    items.add(item);
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _accelerometerHistory = History<List<double>>(10);
  var _userAccelerometerHistory = History<List<double>>(10);
  var _gyroscopeHistory = History<List<double>>(10);
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double graphWidth = size.width * .95 / 3;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Visual Accelerometer'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Graph(_accelerometerHistory.last, size: graphWidth),
                Graph(_userAccelerometerHistory.last, size: graphWidth),
                Graph(_gyroscopeHistory.last, size: graphWidth)
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: StatsTable(_accelerometerHistory, _userAccelerometerHistory, _gyroscopeHistory),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(accelerometerEvents.listen(
      (AccelerometerEvent event) {
        setState(() {
          _accelerometerHistory.add(<double>[event.x, event.y, event.z]);
        });
      },
    ));
    _streamSubscriptions.add(gyroscopeEvents.listen(
      (GyroscopeEvent event) {
        setState(() {
          _gyroscopeHistory.add(<double>[event.x, event.y, event.z]);
        });
      },
    ));
    _streamSubscriptions.add(userAccelerometerEvents.listen(
      (UserAccelerometerEvent event) {
        setState(() {
          _userAccelerometerHistory.add(<double>[event.x, event.y, event.z]);
        });
      },
    ));
  }
}
