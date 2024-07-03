import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:webspark_test_task/model/types/search_result.dart';
import 'package:webspark_test_task/model/types/search_task.dart';

class SearchApi {
  String url;
  SearchApi(this.url);

  Future<List<SearchTask>> fetchTasks() async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body)['data'] as List<dynamic>)
          .map((e) => SearchTask.fromJson(e))
          .toList();
    }

    throw Exception(response.body);
  }

  checkTask(List<SearchResult> result) async {
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: jsonEncode(
        result
            .map((e) => {
                  'id': e.task.id,
                  'result': e.toJson(),
                })
            .toList(),
      ).toString(),
    );

    if (response.statusCode == 200) {
      return;
    }

    throw Exception(response.body);
  }
}
