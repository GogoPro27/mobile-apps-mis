import 'package:flutter/material.dart';
import 'package:my_first_app_223070/models/joke_model.dart';
import 'package:my_first_app_223070/providers/favorite_jokes_provider.dart';
import 'package:my_first_app_223070/providers/joke_cache_provider.dart';

class JokeListScreen extends StatefulWidget {
  final String jokeType;

  JokeListScreen({required this.jokeType});

  @override
  _JokeListScreenState createState() => _JokeListScreenState();
}

class _JokeListScreenState extends State<JokeListScreen> {
  late Future<List<Joke>> _futureJokes;

  @override
  void initState() {
    super.initState();
    _futureJokes = JokeCacheProvider().getJokes(widget.jokeType); // Fetch jokes once
  }

  void _toggleFavorite(Joke joke) {
    setState(() {
      FavoriteJokesProvider().toggleFavorite(joke);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.jokeType} Jokes'),
      ),
      body: FutureBuilder<List<Joke>>(
        future: _futureJokes,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error loading jokes: ${snapshot.error}'));
          }
          final jokes = snapshot.data!;
          return ListView.builder(
            itemCount: jokes.length,
            itemBuilder: (ctx, index) {
              final joke = jokes[index];
              final isFavorite = FavoriteJokesProvider().isFavorite(joke);

              return ListTile(
                title: Text(joke.setup),
                subtitle: Text(joke.punchline),
                trailing: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    _toggleFavorite(joke);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}