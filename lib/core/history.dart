class HistoryStore<T, V> {
  HistoryStore({this.size});

  final _store = Map<T, List<V>>();
  final int size;

  add(T type, V coordinate) {
    if (_store[type] == null) _store[type] = List<V>();
    _store[type].add(coordinate);
    if (_store[type].length > size) _store[type].removeAt(0);
  }

  List<V> get(T type) => _store[type];

  int sizeByType(T type) => _store[type]?.length;
}

class Coordinate {
  Coordinate({this.x, this.y, this.z});

  final double x, y, z;
}
