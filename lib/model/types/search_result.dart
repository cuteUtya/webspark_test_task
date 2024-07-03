import 'dart:math';

import 'package:webspark_test_task/model/types/search_task.dart';

class SearchResult {
  final List<Point<int>> steps;
  final String path;
  final SearchTask task;

  SearchResult({
    required this.path,
    required this.steps,
    required this.task,
  });

  Map<String, dynamic> toJson() {
    return {
      'steps': steps.map((e) => {
            'x': e.x,
            'y': e.y,
          }).toList(),
      'path': path,
    };
  }
}
