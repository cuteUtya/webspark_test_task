import 'package:flutter/material.dart';
import 'package:webspark_test_task/model/repository/search_api.dart';
import 'package:webspark_test_task/model/types/search_result.dart';
import 'package:webspark_test_task/view/result_list_screen.dart';

class ProcessScreen extends StatefulWidget {
  final String apiUrl;

  const ProcessScreen({super.key, required this.apiUrl});

  @override
  State<StatefulWidget> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  double progress = 0;
  String statusText = '';
  late SearchApi api = SearchApi(widget.apiUrl);

  List<SearchResult> calculationResults = [];

  @override
  void initState() {
    process();
    super.initState();
  }

  void setProgress(double p, {String? s}) {
    setState(() {
      progress = p;
      statusText = s ?? statusText;
    });
  }

  void process() async {

    setProgress(0.2, s: 'Fetching tasks');
    var tasks = await api.fetchTasks();
    setProgress(0.5, s: 'Starting process tasks');

    for (var t in tasks) {
      setProgress(
        0.5 + ((tasks.indexOf(t) + 1) * (0.5 / tasks.length)),
        s: 'Processing ${tasks.indexOf(t) + 1}/${tasks.length}',
      );
      calculationResults.add(t.findShortestPath());
    }

    setProgress(
      1,
      s: 'All calculation was finished, you can send your results to server',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: progress == 1
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            if (progress == 1) const Spacer(),
            Text(statusText),
            const SizedBox(height: 16),
            Text('${(progress * 100).toStringAsFixed(0)}%'),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress,
            ),
            if (progress == 1) const Spacer(),
            if (progress == 1)
              TextButton(
                onPressed: () async {
                    var r = await api.checkTask(calculationResults);


                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (e) => ResultListScreen(results: calculationResults),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                ),
                child: const Text(
                  'Send data to the server',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
