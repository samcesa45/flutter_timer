import 'package:flutter/material.dart';
import 'package:flutter_timer/presentation/screens/timer_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Timer',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(72, 74, 126, 1),
        ),
        useMaterial3: true,
      ),
      home: const TimerScreen(),
    );
  }
}
