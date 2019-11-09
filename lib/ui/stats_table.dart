import 'package:flutter/material.dart';
import 'package:flutter_visual_accelerometer/core/history.dart';
import 'package:flutter_visual_accelerometer/ui/home.dart';

class StatsTable extends StatelessWidget {
  @override
  StatsTable(this.history, {Key key}) : super(key: key);

  final HistoryStore<HistoryType, Coordinate> history;

  @override
  Widget build(BuildContext context) {
    var tableRows = List<TableRow>();

    tableRows.add(TableRow(children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          child: Text(
            'Accelerometer\nWith gravity',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          child: Text(
            'Accelerometer\nWithout gravity',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          child: Text(
            'Gyroscope',
            style: TextStyle(fontWeight: FontWeight.bold),
          ))
    ]));

    var historyAccelerometer = history.get(HistoryType.accelerometer);
    var historyUserAccelerometer = history.get(HistoryType.userAccelerometer);
    var historyGyroscope = history.get(HistoryType.gyroscope);

    for (int i = history.size - 1; i > 0; i--) {
      tableRows.add(TableRow(children: [
        _buildCoordinateCell(historyAccelerometer[i]),
        _buildCoordinateCell(historyUserAccelerometer[i]),
        _buildCoordinateCell(
          historyGyroscope[i],
        ),
      ]));
    }

    return Table(
      border: TableBorder.all(width: 1),
      children: tableRows,
    );
  }

  Widget _buildCoordinateCell(Coordinate value) {
    if (value == null) return null;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      child: Text(
        "X: " +
            value.x.toStringAsPrecision(5) +
            "\nY: " +
            value.y.toStringAsPrecision(5) +
            "\nZ: " +
            value.z.toStringAsPrecision(5),
        style: TextStyle(fontSize: 10),
      ),
    );
  }
}
