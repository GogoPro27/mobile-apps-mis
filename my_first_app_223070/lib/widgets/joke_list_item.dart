import 'package:flutter/material.dart';
import 'package:my_first_app_223070/models/joke_model.dart';

class JokeListItem extends StatelessWidget {
  final Joke joke;

  JokeListItem({required this.joke});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          joke.setup,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(joke.punchline),
      ),
    );
  }
}