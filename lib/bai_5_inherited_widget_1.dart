import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inherited widget demo'),
      ),
      body: const Column(
        children: [Parent1(), Parent2()],
      ),
    );
  }
}

class Parent1 extends StatelessWidget {
  const Parent1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Child1();
  }
}

class Parent2 extends StatelessWidget {
  const Parent2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Child2();
  }
}

class Child1 extends StatelessWidget {
  const Child1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Counter:'),
        ElevatedButton(
          child: const Icon(
            Icons.add,
            size: 20,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}

class Child2 extends StatelessWidget {
  const Child2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Counter:'),
        ElevatedButton(
          child: const Icon(
            Icons.add,
            size: 20,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
