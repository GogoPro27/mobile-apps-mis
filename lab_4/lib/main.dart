import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab4/providers/exam_provider.dart';
import 'package:lab4/screens/calendar_screen.dart';
import 'package:lab4/screens/add_event_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExamProvider(),
      child: MaterialApp(
        title: 'Exam Schedule',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => const CalendarScreen(),
          '/add-event': (context) => const AddEventScreen(),
        },
      ),
    );
  }
}