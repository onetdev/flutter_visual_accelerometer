import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Graph extends StatelessWidget {
  @override
  Graph(this.coordinates,
      {@required this.size, this.valueRangeMax = 10, Key key})
      : super(key: key);

  final List<double> coordinates;
  final double size;
  final double valueRangeMax;

  @override
  Widget build(BuildContext context) {
    double x = coordinates[0];
    double y = coordinates[1];
    double z = coordinates[2];

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
        _buildAxis(xHeight, Colors.blue, 'X', 120 + (x.isNegative ? 180 : 0).toDouble()),
        _buildAxis(yHeight, Colors.red, 'Y', 0 + (!y.isNegative ? 180 : 0).toDouble() ),
        _buildAxis(zHeight, Colors.green, 'Z', -120 + (z.isNegative ? 180 : 0).toDouble()),
        Positioned(
          top: 0,
          left: 0,
          width: 20,
          height: 20,
          child: Transform.rotate(angle: 0.0, child: Text('X')),
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
        child: const DecoratedBox(
          decoration: const BoxDecoration(color: Colors.green),
        ),
      ),
    );
  }
}
