import 'package:flutter/material.dart';
import 'package:my_first_app_223070/screens/home_screen.dart';
import 'package:my_first_app_223070/screens/random_joke_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        RandomJokeScreen.routeName: (ctx) => RandomJokeScreen(),
      },
    );
  }
}

void main() {
  runApp(MyApp());
}