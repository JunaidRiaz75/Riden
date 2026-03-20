import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riden/notification.dart';

// ✅ COUNTER CONTROLLER - GetX State Management
class CounterController extends GetxController {
  RxInt counter = 0.obs;

  void incrementCounter() {
    counter.value++;
  }

  void decrementCounter() {
    counter.value--;
  }

  void resetCounter() {
    counter.value = 0;
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // ✅ Change MaterialApp to GetMaterialApp
      title: 'GetX Counter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: NotificationsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ✅ CHANGED: StatefulWidget → StatelessWidget
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // ✅ Get.put() - Dependency Injection (Creates controller once)
    final counterController = Get.put(CounterController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),

            // ✅ Obx() - Reactive widget (rebuilds when counter.value changes)
            Obx(
              () => Text(
                '${counterController.counter.value}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),

            SizedBox(height: 32),

            // ✅ Additional buttons to show GetX features
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Decrement Button
                FloatingActionButton(
                  onPressed: counterController.decrementCounter,
                  tooltip: 'Decrement',
                  heroTag: 'decrement',
                  child: const Icon(Icons.remove),
                ),
                SizedBox(width: 16),

                // Reset Button
                FloatingActionButton(
                  onPressed: () {
                    counterController.resetCounter();
                    Get.snackbar(
                      'Reset',
                      'Counter has been reset to 0',
                      snackPosition: SnackPosition.BOTTOM,
                      duration: Duration(milliseconds: 800),
                    );
                  },
                  tooltip: 'Reset',
                  heroTag: 'reset',
                  backgroundColor: Colors.orange,
                  child: const Icon(Icons.refresh),
                ),
              ],
            ),

            SizedBox(height: 24),

            // ✅ Show reactive state in text
            Obx(
              () => Text(
                counterController.counter.value > 10
                    ? 'Counter is greater than 10! 🎉'
                    : 'Counter is ${counterController.counter.value}',
                style: TextStyle(
                  fontSize: 16,
                  color: counterController.counter.value > 10
                      ? Colors.green
                      : Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),

      // ✅ Increment Button
      floatingActionButton: FloatingActionButton(
        onPressed: counterController.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
