import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_visual_accelerometer/core/history.dart';
import 'package:flutter_visual_accelerometer/ui/graph.dart';
import 'package:flutter_visual_accelerometer/ui/stats_table.dart';
import 'package:sensors/sensors.dart';

enum HistoryType { accelerometer, userAccelerometer, gyroscope }

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _history = HistoryStore<HistoryType, Coordinate>(size: 10);
  var _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visual Accelerometer'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Graphs(
              _history.get(HistoryType.accelerometer)?.last,
              _history.get(HistoryType.userAccelerometer)?.last,
              _history.get(HistoryType.gyroscope)?.last,
            ),
          ),
          Expanded(
            flex: 1,
            child: StatsTable(_history),
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

  /// Because events doesn't have common ancestor despite they have same
  /// fields we have to manually handle each of them separately.
  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(accelerometerEvents.listen(
      (AccelerometerEvent event) {
        setState(() {
          _history.add(HistoryType.accelerometer,
              Coordinate(x: event.x, y: event.y, z: event.z));
        });
      },
    ));

    _streamSubscriptions.add(gyroscopeEvents.listen(
      (GyroscopeEvent event) {
        setState(() {
          _history.add(HistoryType.gyroscope,
              Coordinate(x: event.x, y: event.y, z: event.z));
        });
      },
    ));

    _streamSubscriptions.add(userAccelerometerEvents.listen(
      (UserAccelerometerEvent event) {
        setState(() {
          _history.add(HistoryType.userAccelerometer,
              Coordinate(x: event.x, y: event.y, z: event.z));
        });
      },
    ));
  }
}
