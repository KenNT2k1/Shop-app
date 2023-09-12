import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textController = TextEditingController();
  bool _isPrime = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Column(
        children: [
          TextField(
            controller: textController,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          Text(_isPrime
              ? 'Số ${textController.text} là số nguyên tố'
              : 'Số ${textController.text} không phải là số nguyên tố'),
          ElevatedButton(
              onPressed: () {
                i = 2;
                final number = int.tryParse(textController.text) ?? 0;
                setState(() {
                  if (isPrime(number)) {
                    _isPrime = true;
                  } else {
                    _isPrime = false;
                  }
                });
              },
              child: const Text('Check primitive'))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.shuffle),
      ),
    );
  }

  int i = 2;
  bool isPrime(int n) {
    // Corner cases
    if (n == 0 || n == 1) {
      return false;
    }

    // Checking Prime
    if (n == i) return true;

    // Base cases
    if (n % i == 0) {
      return false;
    }
    i++;
    return isPrime(n);
  }
}
