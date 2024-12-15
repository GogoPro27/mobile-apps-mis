import 'package:flutter/material.dart';
import 'package:my_first_app_223070/models/joke_model.dart';
import 'package:my_first_app_223070/services/api_services.dart';

class RandomJokeScreen extends StatefulWidget {
  static const routeName = '/random-joke';

  @override
  _RandomJokeScreenState createState() => _RandomJokeScreenState();
}

class _RandomJokeScreenState extends State<RandomJokeScreen> {
  late Future<Joke> _futureJoke;

  @override
  void initState() {
    super.initState();
    _futureJoke = ApiServices.fetchRandomJoke();
  }

  void _reloadJoke() {
    setState(() {
      _futureJoke = ApiServices.fetchRandomJoke();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Joke'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _reloadJoke,
            tooltip: 'New Random Joke',
          ),
        ],
      ),
      body: FutureBuilder<Joke>(
        future: _futureJoke,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error loading random joke'));
          }
          final joke = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  joke.setup,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  joke.punchline,
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
          );
        },
      ),
    );
  }
}