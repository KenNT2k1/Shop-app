import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final streamCounter =
      Stream<int>.periodic(const Duration(seconds: 1), (count) => count)
          .take(5000);

  final streamDemo2 = StreamController<int>.broadcast();

  var current = 0;
  @override
  void initState() {
    streamDemo2.stream.listen((content) {
      print("data: $content");
      current = content;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Column(
          children: [
            StreamBuilder<int>(
                stream: streamCounter,
                initialData: 0,
                builder: (context, snapshot) {
                  print('build - 1');
                  return Center(
                    child: Text('${snapshot.data!}'),
                  );
                }),
            StreamBuilder<int>(
              initialData: 0,
              stream: streamDemo2.stream,
              builder: (context, snapshot) {
                print('build - 2');
                return Text('${snapshot.data}');
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_circle),
          onPressed: () async {
            streamDemo2.sink.add(current + 1);
          },
        ),
      ),
    );
  }
}
