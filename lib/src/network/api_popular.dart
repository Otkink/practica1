import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practica2/src/main.dart';
import 'package:practica2/src/models/popular_details_model.dart';
import 'package:practica2/src/models/popular_model.dart';

class ApiPopular {//AppiPopularから変更した
  var URL = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=c8ed4c571bc0d009d0740cb9b5d08921&language=es-Mx&page=1');

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

  dynamic getPopularDetails(int id) async{
    print("Me ha llamado $id");
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/$id?api_key=c8ed4c571bc0d009d0740cb9b5d08921&language=es-Mx'));
    print(response.statusCode);
    if(response.statusCode == 200){
      print("validado :)");
      var popular = jsonDecode(response.body);
      detallesPopular = popular;
      //List<dynamic> popu = popular;
      //Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(response.body));
      /*print(popular['overview']);
      print(popular['original_title']);
      print(popular['genres'][0]['name']);*/
      print('$id, ${detallesPopular['original_title']}');
      print(detallesPopular['genres'][0]['name']);
      //List<PopularMoviesDetailsModel> listPopularDetails = data.map((movie) => PopularMoviesDetailsModel.fromMap(movie)).toList();
      //return listPopularDetails;
      return popular;
    }else{
      print("fallido");
      return null;
    }
  }

  dynamic getActores(int id) async{ //id = id de la Pelicula
    print("Me ha llamado $id");
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/$id/credits?api_key=c8ed4c571bc0d009d0740cb9b5d08921'));
    print(response.statusCode);
    if(response.statusCode == 200){
      print("validado :)");
      var popular = jsonDecode(response.body)['cast'];
      actoresPopular = popular;
      //List<dynamic> popu = popular;
      //Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(response.body));
      /*print(popular['overview']);
      print(popular['original_title']);
      print(popular['genres'][0]['name']);*/
      print(actoresPopular.length);
      print('$id, ${actoresPopular[0]['original_name']}');
      //print(actoresPopular['genres'][0]['name']);
      //List<PopularMoviesDetailsModel> listPopularDetails = data.map((movie) => PopularMoviesDetailsModel.fromMap(movie)).toList();
      //return listPopularDetails;
      return popular;
    }else{
      print("fallido");
      return null;
    }
  }

}