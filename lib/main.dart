import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _message = 'Unknown message.';
  static const plataform = MethodChannel('ro-fe.com/native-code-example');

  Future<void> _getMessage() async {
    String messageFromNativeCode;
    try {
      messageFromNativeCode =
          await plataform.invokeMethod('getMessageFromNativeCode');
    } on PlatformException catch (e) {
      messageFromNativeCode = 'Failed to get message: ${e.message}';
    }

    setState(() {
      _message = messageFromNativeCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Platform.isIOS ? Colors.amberAccent : Colors.red,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _getMessage,
                child: const Text('Get Message'),
              ),
              Text(
                _message,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
