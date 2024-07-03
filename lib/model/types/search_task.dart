import 'dart:collection';
import 'dart:math';

import 'package:webspark_test_task/model/types/search_result.dart';

class SearchTask {
  final String id;
  final List<String> field;
  final Point<int> start;
  final Point<int> end;

  SearchTask({
    required this.end,
    required this.start,
    required this.field,
    required this.id,
  });

  factory SearchTask.fromJson(Map<String, dynamic> json) {
    return SearchTask(
      end: Point(json['end']['x'] as int, json['end']['y'] as int),
      start: Point(json['start']['x'] as int, json['start']['y'] as int),
      field: (json['field'] as List<dynamic>).map((e) => e.toString()).toList(),
      id: json['id'],
    );
  }

  static const List<Point<int>> _directions = [
    Point(0, 1),
    Point(1, 0),
    Point(0, -1),
    Point(-1, 0),
    Point(1, 1),
    Point(1, -1),
    Point(-1, 1),
    Point(-1, -1),
  ];

  SearchResult findShortestPath() {
    int rows = field.length;
    int cols = field[0].length;
    List<List<int>> distances =
        List.generate(rows, (_) => List.generate(cols, (_) => -1));

    Queue<Point<int>> queue = Queue<Point<int>>();
    queue.add(start);
    distances[start.y][start.x] = 0;

    while (queue.isNotEmpty) {
      Point<int> current = queue.removeFirst();

      for (Point<int> direction in _directions) {
        Point<int> neighbor =
            Point(current.x + direction.x, current.y + direction.y);

        if (neighbor.x >= 0 &&
            neighbor.x < cols &&
            neighbor.y >= 0 &&
            neighbor.y < rows &&
            field[neighbor.y][neighbor.x] == '.' &&
            distances[neighbor.y][neighbor.x] == -1) {
          distances[neighbor.y][neighbor.x] =
              distances[current.y][current.x] + 1;
          queue.add(neighbor);

          if (neighbor == end) {
            var p = reconstructPath(distances, start, end);
            return SearchResult(
              task: this,
              path: p.map((e) => '(${e.x},${e.y})').join('->'),
              steps: p,
            );
          }
        }
      }
    }

    throw Exception('Unsolvable task');
  }

  List<Point<int>> reconstructPath(
      List<List<int>> distances, Point<int> start, Point<int> end) {
    List<Point<int>> path = [];
    Point<int> current = end;
    path.add(current);

    while (current != start) {
      for (Point<int> direction in _directions) {
        Point<int> neighbor =
            Point(current.x + direction.x, current.y + direction.y);

        if (neighbor.x >= 0 &&
            neighbor.x < distances[0].length &&
            neighbor.y >= 0 &&
            neighbor.y < distances.length &&
            distances[neighbor.y][neighbor.x] ==
                distances[current.y][current.x] - 1) {
          current = neighbor;
          path.add(current);
          break;
        }
      }
    }
    return path.reversed.toList();
  }
}
