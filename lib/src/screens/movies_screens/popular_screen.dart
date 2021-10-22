import 'package:flutter/material.dart';
import 'package:practica2/src/models/popular_details_model.dart';
import 'package:practica2/src/models/popular_model.dart';
import 'package:practica2/src/network/api_popular.dart';
import 'package:practica2/src/screens/drawerPelis.dart';
import 'package:practica2/src/views/card_popular.dart';
import 'package:practica2/src/views/lista_popular.dart';

class PopularScreen extends StatefulWidget {
  PopularScreen({Key? key}) : super(key: key);

  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {

  ApiPopular? apiPopular;

  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color(0xFF21C7CF),
      Color(0xFF32ECB9)
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    //Future<List<PopularMoviesDetailsModel>?> details = apiPopular!.getPopularDetails(800497); print(details.toString);
    //_listPopularMoviesDetails(details);
    //List<PopularMoviesDetailsModel>? detailP = apiDetails.data;
    //PopularMoviesDetailsModel popularDet = apiDetails as PopularMoviesDetailsModel;
    //print('${popularDet.overview}');
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Populares", style: TextStyle(foreground: Paint()..shader = linearGradient, fontWeight: FontWeight.bold) ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF21C7CF)),
      ),
      drawer: drawerPelis(),
      body: FutureBuilder(
        future: apiPopular!.getAllPopular(),
        builder: (BuildContext context, AsyncSnapshot<List<PopularMoviesModel>?> snapshot){
          if( snapshot.hasError){
            return Center(child: Text('リクエストにエラーが発生しました'));
          }else{
            if(snapshot.connectionState == ConnectionState.done){
              return _listPopularMovies(snapshot.data);
            }else{
              return CircularProgressIndicator();
            }
          }
        }
        ),
    );
  }
  void _listPopularMoviesDetails(List<PopularMoviesDetailsModel>? movies){
    PopularMoviesDetailsModel popular = movies![0];
    print('${popular.overview}');
  }

  Widget _listPopularMovies(List<PopularMoviesModel>? movies){

    return ListView.builder(
      itemBuilder: (context, index){
       
        PopularMoviesModel popular = movies![index]; 
        apiPopular!.getPopularDetails(popular.id!);
        return ListaPopularView(popular: popular);
      }, 
      //separatorBuilder: (_, __) => Divider(height: 50,), 
      itemCount: movies!.length
      );

  }
}