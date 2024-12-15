import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_first_app_223070/models/joke_model.dart';

class ApiServices {
  static const String baseUrl = 'https://official-joke-api.appspot.com';

  static Future<List<String>> fetchJokeTypes() async {
    final url = Uri.parse('$baseUrl/types');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((e) => e.toString()).toList();
    } else {
      throw Exception('Failed to load joke types');
    }
  }
  

  static Future<List<Joke>> fetchJokesByType(String type) async {
    final url = Uri.parse('$baseUrl/jokes/$type/ten');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((e) => Joke.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load jokes of type $type');
    }
  }

  static Future<Joke> fetchRandomJoke() async {
    final url = Uri.parse('$baseUrl/jokes/random');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      return Joke.fromJson(jsonData);
    } else {
      throw Exception('Failed to load random joke');
    }
  }
}