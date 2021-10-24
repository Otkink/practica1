import 'package:flutter/material.dart';
import 'package:practica2/src/main.dart';
import 'package:practica2/src/models/popular_details_model.dart';
import 'package:practica2/src/models/popular_model.dart';
import 'package:practica2/src/network/api_popular.dart';
import 'package:practica2/src/screens/tareas_screen/detalles_popular.dart';

class ListaPopularView extends StatelessWidget {

  final PopularMoviesModel popular;
  

  const ListaPopularView({
    Key? key,
    required this.popular
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
      DateTime? fechaSalida = DateTime.tryParse(popular.releaseDate!);
    //ApiPopular? apiPopular = ApiPopular();
    //apiPopular.getPopularDetails(popular.id!); 
    //_obtenerDetalles();
    //String generos = '';//almacena la lista de generos de cada pelicula
    //print(detallesPopular['genres']);
    //print(detallesPopular['genres'].length);
    
    /*if(popular.genreIds.length >= 3){
      print('ANAILIS ${detallesPopular['original_title']} : ${detallesPopular['genres']}, LONGITUD: ${detallesPopular['genres'].length}');
      print('Gen 1: ${detallesPopular['genres'][0]['name']}');
      print('Gen 2: ${detallesPopular['genres'][1]['name']}');
      print('Gen 3: ${detallesPopular['genres'][2]['name']}');
      generos = '${detallesPopular['genres'][0]['name']}, ${detallesPopular['genres'][1]['name']}, ${detallesPopular['genres'][2]['name']}';
    } else{
      if(popular.genreIds.length == 2){
        generos = '${detallesPopular['genres'][0]['name']}, ${detallesPopular['genres'][1]['name']}';
      }else{
        if(popular.genreIds.length == 1){
          generos = '${detallesPopular['genres'][0]['name']}';
        }else{
          generos = 'Sin genero';
        }
      }
    }*/
    String idioma = "";
    switch (popular.originalLanguage) {
      case "en":
        idioma = "Inglés";
        break;
      case "es":
        idioma = "Español";
        break;
      case "ja":
        idioma = "Japonés";
        break;
      case "zh":
        idioma = "Chino";
        break;
      case "fr":
        idioma = "Francés";
        break;
      case "tr":
        idioma = "Turco";
        break;
      case "ru":
        idioma = "Ruso";
        break;
    }

    return GestureDetector(
      onTap: () async {
        print('${popular.originalTitle}');
        await _obtenerDetalles(); //大事！次のページに進む前に、リクエストが終了するのを待つ必要がある。そうでない場合は、データが保存しない。
        await _obtenerActores(popular.id!);//これは上のことが同じなんだ
        await _obtenerVideo(popular.id!);
        Navigator.pushNamed(context, '/d_pop', arguments: {'id': popular.id, 'titulo': popular.title, 'genresIdsLength': popular.genreIds.length}); //envio tambien el titulo porque en la pagina de detalles de cada pelicula el titulo cambia por otro, aunque similar.
      },
      child: Container(
        margin: EdgeInsets.only(top: 18),
        child: Column(
          children: [
            Container(//quitar container y dejar el Row
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
                boxShadow: [BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0,3.0),
                  blurRadius: 2.5
                )]
              ),
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container( //POSTER DE LA PELICULA
                    //margin: EdgeInsets.only(left: 10, bottom: 10),
                     width: 145,
                    child: Image(image: NetworkImage('https://image.tmdb.org/t/p/w500/${popular.posterPath}'))
                  ),
                  Container( //INFORMACION BASICA DE LA PELICULA
                  //padding: EdgeInsets.,
                    margin: EdgeInsets.only(left: 20, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Container(width: 170, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Text("${popular.originalTitle}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)))),
                        Container(width: 197, child: Text("${popular.title}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17))),
                        SizedBox(height: 5,),
                        //Text("${popular.genreIds}"),
                        //Text("${apiPopular.getPopularDetails(popular.id!)}"),
                        Text("Estreno: ${fechaSalida!.day} / ${fechaSalida.month} / ${fechaSalida.year}", style: TextStyle(color: Colors.grey, fontSize: 14)),
                        //SizedBox(height: 5,),
                        MaterialButton(minWidth: 70, height: 15, onPressed: (){}, color: Colors.orange, shape: StadiumBorder(), child: Text("$idioma", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w300))),
                        //SizedBox(height: 10,),
                        Container( 
                          width: 190, 
                          child: Text(
                            "${popular.overview}", 
                            maxLines: 3, 
                            overflow: TextOverflow.ellipsis, 
                            style: TextStyle(
                              color: Colors.grey, 
                              fontSize: 11
                              )
                            )
                        ),
                        //Text("${detallesPopular['genres'][0]['name']}"),
                        //Container(decoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle), width: 50,height: 50,  child: Text("${popular.voteAverage}")),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AbsorbPointer(
                              child: RaisedButton(
                                onPressed: (){},
                                //color: Colors.teal[100],
                                textColor: Colors.white,
                                child: Ink(
                                  height: 36,
                                  width: 36,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF21C7CF),
                                        Color(0xFF32ECB9)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter
                                    )
                                  ),
                                  child: Center(child: Text("${popular.voteAverage}", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),)),
                                ),
                                shape: CircleBorder()
                                ),
                            ),
                            Text("Ver más", style: TextStyle(color: Color(0xFF32ECB9)) )
                          ],
                        ),
                        //Container(height: 100, width: 100, child: SingleChildScrollView(child: Text("${detallesPopular['overview']}"),),)
                        
                        
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Future<void> _obtenerDetalles() async {
    print("Aqui de nuevo");
    ApiPopular? apiPopular = ApiPopular();
    await apiPopular.getPopularDetails(popular.id!); 
  }

  Future<void> _obtenerActores(int id) async {
    ApiPopular? apiPopular = ApiPopular();
    await apiPopular.getActores(id);
  }

  Future<void> _obtenerVideo(int id) async {
    ApiPopular? apiPopular = ApiPopular();
    await apiPopular.getVideo(id);
  }
}