import 'package:my_first_app_223070/models/joke_model.dart';

class FavoriteJokesProvider {
  static final FavoriteJokesProvider _instance = FavoriteJokesProvider._internal();

  factory FavoriteJokesProvider() {
    return _instance;
  }

  FavoriteJokesProvider._internal();

  final List<Joke> _favorites = [];

  List<Joke> get favorites => List.unmodifiable(_favorites);

  void toggleFavorite(Joke joke) {
    if (_favorites.contains(joke)) {
      _favorites.remove(joke);
    } else {
      _favorites.add(joke);
    }
  }

  bool isFavorite(Joke joke) {
    return _favorites.contains(joke);
  }
}