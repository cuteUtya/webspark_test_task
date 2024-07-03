import 'package:flutter/material.dart';
import 'package:webspark_test_task/model/types/search_result.dart';
import 'package:webspark_test_task/view/preview_screen.dart';

class ResultListScreen extends StatelessWidget {
  final List<SearchResult> results;

  const ResultListScreen({
    super.key,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: results
            .map(
              (e) => GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return PreviewScreen(result: e);
                    }
                  ),
                ),
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(e.path),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
