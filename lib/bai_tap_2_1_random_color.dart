import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

final colors = <Color>[
  Colors.black,
  Colors.blue,
  Colors.yellow,
  Colors.grey,
  Colors.orange,
  Colors.purple,
];

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
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _getColor(),
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter++;
          });
        },
        child: const Icon(Icons.shuffle),
      ),
    );
  }

  Color _getColor() {
    if (counter % 2 == 0) {
      return Colors.white;
    } else {
      return (colors.toList()..shuffle()).first;
    }
    // counter % 2 == 0 ? Colors.white : (colors.toList()..shuffle()).first;
  }
}
