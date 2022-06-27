import 'dart:convert';
import 'package:eat_project/models/Movie.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

class MovieRepository {
  Future<List<Movie>> loadMovies() async {
    var queryPram = {
      'api_key': 'dbc168107d516bd7c3121da5439ce5c1',
    };

    //var uri =
    //    'https://api.themoviedb.org/3/movie/550?api_key=dbc168107d516bd7c3121da5439ce5c1';

    //var uri = Uri.https('api.themoviedb.org', '/3/movie/popular', queryPram);
    var uri = Uri.http('hajin220.dothome.co.kr', '/ttt.php');
    var response = await http.get(uri);

    final document = html_parser.parse(response.body);
    //final result = document.getElementsByTagName('body');
    print(utf8.decode(response.bodyBytes));
    //print(response);
    if (response.body != null) {
      Map<String, dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      if (body["results"] != null) {
        List<dynamic> list = body["results"];
        return list.map<Movie>((item) => Movie.fromJson(item)).toList();
      }
    } else {
      throw Exception('Failed to load post');
    }

    return [];
  }
}
