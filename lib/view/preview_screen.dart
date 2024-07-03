import 'dart:math';

import 'package:flutter/material.dart';
import 'package:webspark_test_task/model/types/search_result.dart';

class PreviewScreen extends StatelessWidget {
  final SearchResult result;

  const PreviewScreen({super.key, required this.result});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview screen'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: result.steps.length,
              ),
              itemCount: result.steps.length * result.steps.length,
              itemBuilder: (context, index) {
                int x = index % result.steps.length;
                int y = index ~/ result.steps.length;
                Point<int> point = Point(x, y);

                Color color;
                if (point == result.task.start) {
                  color = Color(0xFF64FFDA);
                } else if (point == result.task.end) {
                  color = Color(0xFF009688);
                } else if (result.task.field[y][x] == 'X') {
                  color = Color(0xFF000000);
                } else if (result.steps.contains(point)) {
                  color = Color(0xFF4CAF50);
                } else {
                  color = Color(0xFFFFFFFF);
                }

                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: color,
                  ),
                  child: Text('($x, $y)'),
                );
              },
            ),
          ),
          Text(result.path),
        ],
      ),
    );
  }
}
