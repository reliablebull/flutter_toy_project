import 'package:eat_project/models/Movie.dart';
import 'package:flutter/material.dart';
import '../repository/movie_repository.dart';

class MovieProvider extends ChangeNotifier {
  MovieRepository _movieRepository = MovieRepository();

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  loadMovies() async {
    List<Movie> listMovies = await _movieRepository.loadMovies();
    if (listMovies != []) _movies = listMovies;
    //_movieRepository.test();
    notifyListeners();
  }
}
