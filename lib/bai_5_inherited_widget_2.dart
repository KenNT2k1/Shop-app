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

class CounterData extends InheritedWidget {
  const CounterData({
    super.key,
    required this.child,
    required this.data,
  }) : super(child: child);

  @override
  final Widget child;
  final MyHomePageState data;

  static MyHomePageState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterData>()?.data;
  }

  @override
  bool updateShouldNotify(CounterData oldWidget) {
    return true;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inherited widget demo'),
      ),
      body: CounterData(
        data: this,
        child: const Column(
          children: [Parent1(), Parent2()],
        ),
      ),
    );
  }

  void incrementCounter() {
    setState(() {
      counter++;
    });
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
        Text('Counter: ${CounterData.of(context)?.counter}'),
        ElevatedButton(
          child: const Icon(
            Icons.add,
            size: 20,
          ),
          onPressed: () {
            CounterData.of(context)?.incrementCounter();
          },
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
        Text('Counter: ${CounterData.of(context)?.counter}'),
        ElevatedButton(
          child: const Icon(
            Icons.add,
            size: 20,
          ),
          onPressed: () {
            CounterData.of(context)?.incrementCounter();
          },
        )
      ],
    );
  }
}
