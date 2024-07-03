import 'package:flutter/material.dart';
import 'package:webspark_test_task/view/process_screen.dart';

class HomeScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Set valid API base URL in order to continue'),
            const SizedBox(height: 16),
            TextField(controller: controller),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: () {
                  if (!Uri.parse(controller.text).isAbsolute) {
                    showDialog(
                      context: context,
                      builder: (e) => AlertDialog(
                        title: Text('URL is invalid'),
                      ),
                    );
                    return;
                  }

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (d) => ProcessScreen(apiUrl: controller.text),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
                ),
                child: const Text(
                  'Start counting process',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
