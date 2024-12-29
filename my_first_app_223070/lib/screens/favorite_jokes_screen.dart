import 'package:flutter/material.dart';
import 'package:my_first_app_223070/providers/favorite_jokes_provider.dart';

class FavoriteJokesScreen extends StatelessWidget {
  static const routeName = '/favorite-jokes';

  @override
  Widget build(BuildContext context) {
    final favoriteJokes = FavoriteJokesProvider().favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Jokes'),
      ),
      body: favoriteJokes.isEmpty
          ? Center(child: Text('No favorite jokes yet!'))
          : ListView.builder(
              itemCount: favoriteJokes.length,
              itemBuilder: (ctx, index) {
                final joke = favoriteJokes[index];
                return ListTile(
                  title: Text(joke.setup),
                  subtitle: Text(joke.punchline),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      FavoriteJokesProvider().toggleFavorite(joke);
                      // Trigger a rebuild
                      (context as Element).markNeedsBuild();
                    },
                  ),
                );
              },
            ),
    );
  }
}