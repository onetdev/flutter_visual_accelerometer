import 'package:flutter/material.dart';
import 'package:flutter_visual_accelerometer/main.dart';

class StatsTable extends StatelessWidget {
  @override
  StatsTable(this.accelerometer, this.userAccelerometer, this.gyroscope,
      {Key key})
      : super(key: key);

  final History<List<double>> accelerometer;
  final History<List<double>> userAccelerometer;
  final History<List<double>> gyroscope;

  @override
  Widget build(BuildContext context) {
    var tableRows = List<TableRow>();

    tableRows.add(TableRow(children: [
      Text('Accelerometer\nWith gravity'),
      Text('Accelerometer\nWithout gravity'),
      Text('Gyroscope')
    ]));

    for (int i = accelerometer.items.length - 1; i > 0; i--) {
      tableRows.add(TableRow(children: [
        coordinateBuilder(accelerometer.items[i]),
        coordinateBuilder(userAccelerometer.items[i]),
        coordinateBuilder(gyroscope.items[i]),
      ]));
    }

    return Table(
      children: tableRows,
      border: TableBorder.all(width: 1),
    );
  }

  Text coordinateBuilder(List<double> values) {
    return Text(
      "x: " +
          values[0].toStringAsPrecision(5) +
          "\ny: " +
          values[1].toStringAsPrecision(5) +
          "\nz: " +
          values[2].toStringAsPrecision(5),
      style: TextStyle(fontSize: 10),
    );
  }
}
