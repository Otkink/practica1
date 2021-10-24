import 'package:flutter/material.dart';
import 'package:practica2/src/main.dart';
import 'package:practica2/src/network/api_popular.dart';

class FavoritosScreen extends StatefulWidget {
  FavoritosScreen({Key? key}) : super(key: key);

  @override
  _FavoritosScreenState createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    var _listaFavoritos = <Widget>[];
    for( int i = 0; i<actoresPopular.length; i++){
      if (actoresPopular[i]['profile_path'] != null){
      _listaFavoritos.add(//Si el actor tiene foto, entonces agrega el widget para mostrarla
        GestureDetector(
          onTap: () async {
            //print('${popular.originalTitle}');
            await _obtenerDetalles(detallesPopular['id']); //大事！次のページに進む前に、リクエストが終了するのを待つ必要がある。そうでない場合は、データが保存しない。
            await _obtenerActores(detallesPopular['id']);//これは上のことが同じなんだ
            await _obtenerVideo(detallesPopular['id']);
            Navigator.pushNamed(context, '/d_pop', arguments: {'id': detallesPopular['id'], 'titulo': detallesPopular['title'], 'genresIdsLength': detallesPopular['genres'].length}); //envio tambien el titulo porque en la pagina de detalles de cada pelicula el titulo cambia por otro, aunque similar.
          },
          child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500/${detallesPopular['poster_path']}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text("${detallesPopular['title']}"),
                ],
              ),
            ),
        ),
      );} //si no tiene foto, entonces no agrega nada
    }

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.all(18.0),
                    onPressed: (){Navigator.pop(context);}, 
                    icon: Icon(Icons.arrow_back, color: Colors.white,),
                    
                  ),
                  Text(
                    'Favoritos',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    ),
                  ),
                  AbsorbPointer( //inhabilita la interaccion con este widget
                    child: IconButton( 
                      padding: EdgeInsets.all(18.0),
                      onPressed: (){}, 
                      icon: Icon(Icons.star_rate_rounded, color: Colors.white,),
                      
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF21C7CF),
                    Color(0xFF32ECB9)
                  ]
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 20.0,
                    spreadRadius: 1.0
                  )
                ]
              ),
            ),
            preferredSize: Size(
              MediaQuery.of(context).size.width,
              150.0
            ),
            ),
      body: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 20),
        child: GridView.count(
          physics: BouncingScrollPhysics(),
          shrinkWrap: false,
          childAspectRatio:  (itemWidth / itemHeight),
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          crossAxisCount: 2, //2 columnas
          scrollDirection: Axis.vertical,
          children: _listaFavoritos,
        ),
      ),
    );
  }

  Future<void> _obtenerDetalles(int id) async {
    print("Aqui de nuevo");
    ApiPopular? apiPopular = ApiPopular();
    await apiPopular.getPopularDetails(id); 
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