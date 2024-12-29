import 'package:my_first_app_223070/models/joke_model.dart';
import 'package:my_first_app_223070/services/api_services.dart';

class JokeCacheProvider {
  static final JokeCacheProvider _instance = JokeCacheProvider._internal();

  factory JokeCacheProvider() {
    return _instance;
  }

  JokeCacheProvider._internal();

  final Map<String, List<Joke>> _jokeCache = {};

  Future<List<Joke>> getJokes(String jokeType) async {
    if (_jokeCache.containsKey(jokeType)) {
      return _jokeCache[jokeType]!;
    }
    final jokes = await ApiServices.fetchJokesByType(jokeType);
    _jokeCache[jokeType] = jokes;
    return jokes;
  }
}