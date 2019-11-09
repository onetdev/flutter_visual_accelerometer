import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_visual_accelerometer/core/history.dart';

class Graphs extends StatelessWidget {
  @override
  Graphs(this.accelerometer, this.userAccelerometer, this.gyroscope, {Key key})
      : super(key: key);

  final Coordinate accelerometer;
  final Coordinate userAccelerometer;
  final Coordinate gyroscope;

  @override
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    double graphWidth = size.width * .95 / 3;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Graph(accelerometer, size: graphWidth),
        Graph(userAccelerometer, size: graphWidth, valueRangeMax: 6),
        Graph(gyroscope, size: graphWidth, valueRangeMax: 2.5)
      ],
    );
  }
}

class Graph extends StatelessWidget {
  @override
  Graph(this.coordinate,
      {@required this.size, this.valueRangeMax = 10, Key key})
      : super(key: key);

  final Coordinate coordinate;
  final double size;
  final double valueRangeMax;

  @override
  Widget build(BuildContext context) {
    if (coordinate == null) {
      return null;
    }

    double x = coordinate.x;
    double y = coordinate.y;
    double z = coordinate.z;

    double heightRange = size / 2 * .9;
    double minHeight = heightRange * .1;
    double xHeight = max((x / valueRangeMax).abs() * heightRange, minHeight);
    double yHeight = max((y / valueRangeMax).abs() * heightRange, minHeight);
    double zHeight = max((z / valueRangeMax).abs() * heightRange, minHeight);

    return Stack(
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1), color: Colors.black54),
          ),
        ),
        _buildAxis(
            xHeight, Colors.blue, 'X', 120 + (x < 0 ? 180 : 0).toDouble()),
        _buildAxis(yHeight, Colors.red, 'Y', 0 + (y < 0 ? 0 : 180).toDouble()),
        _buildAxis(
            zHeight, Colors.green, 'Z', -120 + (z < 0 ? 180 : 0).toDouble()),
        Positioned(
          bottom: 0,
          right: 0,
          width: 20,
          height: 20,
          child: Text('X', style: TextStyle(color: Colors.blue)),
        ),
        Positioned(
          top: 0,
          left: size / 2,
          width: 20,
          height: 20,
          child: Text('Y', style: TextStyle(color: Colors.red)),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          width: 20,
          height: 20,
          child: Text('Z', style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }

  Widget _buildAxis(double height, Color color, String label, double angle) {
    return Positioned(
      bottom: size / 2,
      left: size / 2,
      width: 4,
      height: height,
      child: Transform.rotate(
        angle: angle * pi / 180,
        alignment: Alignment.bottomCenter,
        child: DecoratedBox(
          decoration: BoxDecoration(color: color),
        ),
      ),
    );
  }
}
