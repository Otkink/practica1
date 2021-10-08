import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practica2/src/models/popular_model.dart';

class ApiPopular {//AppiPopularから変更した
  var URL = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=c8ed4c571bc0d009d0740cb9b5d08921&language=es-MX&page=1');

  Future<List<PopularMoviesModel>?> getAllPopular() async{
    final response = await http.get(URL);
    if(response.statusCode == 200){
      var popular = jsonDecode(response.body)['results'] as List;
      List<PopularMoviesModel> listPopular = popular.map((movie) => PopularMoviesModel.fromMap(movie)).toList();
      return listPopular;
    }else{
      return null;
    }
  }
}