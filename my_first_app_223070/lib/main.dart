import 'package:flutter/material.dart';
import 'package:my_first_app_223070/models/joke_model.dart';
import 'package:my_first_app_223070/screens/favorite_jokes_screen.dart';
import 'package:my_first_app_223070/screens/home_screen.dart';
import 'package:my_first_app_223070/screens/random_joke_screen.dart';
import 'package:my_first_app_223070/services/api_services.dart';
import 'package:my_first_app_223070/services/notification_service.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();

  NotificationService.scheduleNotification(
    title: 'Scheduled Notification',
    body: 'This notification was scheduled!',
    scheduledDate: DateTime.now().add(Duration(seconds: 5)), 
  );

  runApp(MyApp());
}

Joke? globalJoke;


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Sets the initial screen
      routes: {
        RandomJokeScreen.routeName: (context) => RandomJokeScreen(),
        FavoriteJokesScreen.routeName: (context) => FavoriteJokesScreen(),
      },
    );
  }
}

