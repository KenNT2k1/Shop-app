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
        '/c': (BuildContext context) => const Detail3(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/a') {
          final value = settings.arguments as String; // Retrieve the value.
          return MaterialPageRoute(
              builder: (_) => Detail1(data: value)); // Pass it to BarPage.
        }
        if (settings.name == '/b') {
          return MaterialPageRoute(
              builder: (_) => const Detail2()); // Pass it to BarPage.
        }
        return null; // Let `onUnknownRoute` handle this behavior.
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text('Unknown router - ${settings.name}'),
            ),
          ),
        );
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
              final result = await Navigator.pushNamed(context, '/a',
                  arguments: 'From Home screen');
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
  const Detail1({super.key, required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail 1')),
      body: Column(
        children: [
          Text(data),
          Center(
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
        ],
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
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/c');
                },
                child: const Text('Go to detail 3')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Detail4(),
                      ));
                },
                child: const Text('Go to detail 4')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cccc');
                },
                child: const Text('Go to unknown router')),
          ],
        ),
      ),
    );
  }
}

class Detail3 extends StatelessWidget {
  const Detail3({super.key});

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail 3')),
    );
  }
}

class Detail4 extends StatelessWidget {
  const Detail4({super.key});

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail 4')),
    );
  }
}
