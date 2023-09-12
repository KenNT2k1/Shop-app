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
      routes: <String, WidgetBuilder>{
        '/a': (BuildContext context) => const Detail1(),
        '/b': (BuildContext context) => const Detail2(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Center(
        child: ElevatedButton(
            child: const Text('Go Detail 1'),
            onPressed: () async {
              final result = await Navigator.pushNamed(context, '/a');
              if (result != null) {
                if (result is String) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.maybeOf(context)
                      ?.showSnackBar(SnackBar(content: Text(result)));
                }
              }
            }),
      ),
    );
  }
}

class Detail1 extends StatelessWidget {
  const Detail1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail 1')),
      body: Center(
        child: ElevatedButton(
            child: const Text('Go Detail 2'),
            onPressed: () async {
              final result = await Navigator.pushNamed(context, '/b');
              if (result != null) {
                if (result is String) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.maybeOf(context)
                      ?.showSnackBar(SnackBar(content: Text(result)));
                }
                if (result is Map && result['go_home'] == true) {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(
                    context,
                    result['message'],
                  );
                }
              } else {}
            }),
      ),
    );
  }
}

class Detail2 extends StatelessWidget {
  const Detail2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail 2')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop({'go_home': true, 'message': 'Hello from detail 2'});
                },
                child: const Text('Back to home page')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop('Hello from detail 2');
                },
                child: const Text('Back to detail 1 page')),
          ],
        ),
      ),
    );
  }
}
