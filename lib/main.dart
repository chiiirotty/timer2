import 'dart:async';

import 'package:flutter/material.dart';

import 'next_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _minute = 0;
  int _second = 0;
  int _millisecond = 0;
  Timer? _timer;
  bool _isRunning = false;

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void initState() {
    super.initState();

  }

  void _incrementCounter() {
    setState(() {
      _second++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$_minute',
                  style: TextStyle(fontSize: 60),
                ),
                Text(
                  ':',
                  style: TextStyle(fontSize: 60),
                ),
                Text(
                  '$_second',
                  style: TextStyle(fontSize: 60),
                ),
                Text(
                  ':',
                  style: TextStyle(fontSize: 60),
                ),
                Text(
                  '$_millisecond',
                  style: TextStyle(fontSize: 60),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                resetTimer();
              },
              child: Text('Reset'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleTimer,
        tooltip: 'Increment',
        child: const Icon(Icons.timer),
      ),
    );
  }

  void toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
        setState(() {
          _millisecond++;
        });
        if (_millisecond == 1000) {
          setState(() {
            _second++;
            _millisecond = 0;
          });
        }
        if (_second == 60) {
          setState(() {
            _minute++;
            _second = 0;
          });
          // resetTimer();
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => NextPage()),
          //     );
        }
      });
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void resetTimer() {
    _timer?.cancel();

    setState(() {
      _minute = 0;
      _second = 0;
      _millisecond = 0;
      _isRunning = false;
    });
  }
}
