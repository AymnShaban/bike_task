import 'package:bike_task/exports.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task View'),
        // backgroundColor: AppTheme.primaryColor,
      ),
      body: DiagonalGradientBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to the Task View',
                  style: TextStyle(
                    color: AppTheme.textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                GradientButton(
                  label: 'Start Task',
                  onPressed: () {
                    // Handle button press
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
