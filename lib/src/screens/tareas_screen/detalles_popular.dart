import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:practica2/src/main.dart';
import 'package:practica2/src/network/api_popular.dart';

class DetallesPopularScreen extends StatelessWidget {
  const DetallesPopularScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? fechaSalida = DateTime.tryParse(detallesPopular['release_date']);
    String? mes = '';
    String? generos = '';
    final detalle = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>; //cone sta instruccion es posible recuperar los parametros enviados en el Navigator.pushNamed(..., arguments:"...")
    print('${detalle['id']}');
    print(detallesPopular['id']);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light); // 1

    switch (fechaSalida!.month) {
      case 1:
        mes = 'Enero';
        break;
      case 2:
        mes = 'Febrero';
        break;
      case 3:
        mes = 'Marzo';
        break;
      case 4:
        mes = 'Abril';
        break;
      case 5:
        mes = 'Mayo';
        break;
      case 6:
        mes = 'Junio';
        break;
      case 7:
        mes = 'Julio';
        break;
      case 8:
        mes = 'Agosto';
        break;
      case 9:
        mes = 'Septiembre';
        break;
      case 10:
        mes = 'Octubre';
        break;
      case 11:
        mes = 'Noviembre';
        break;
      case 12:
        mes = 'Diciembre';
        break;
      default:
        mes = 'Sin fecha';
    }


    /***********************Muestra hasta un maximo de 3 generos por pelicula******************************************************** */
    if (detalle['genresIdsLength'] >= 3) {
      print(
          'ANAILIS ${detallesPopular['original_title']} : ${detallesPopular['genres']}, LONGITUD: ${detallesPopular['genres'].length}');
      print('Gen 1: ${detallesPopular['genres'][0]['name']}');
      print('Gen 2: ${detallesPopular['genres'][1]['name']}');
      print('Gen 3: ${detallesPopular['genres'][2]['name']}');
      generos =
          '${detallesPopular['genres'][0]['name']}, ${detallesPopular['genres'][1]['name']}, ${detallesPopular['genres'][2]['name']}';
    } else {
      if (detalle['genresIdsLength'] == 2) {
        generos =
            '${detallesPopular['genres'][0]['name']}, ${detallesPopular['genres'][1]['name']}';
      } else {
        if (detalle['genresIdsLength'] == 1) {
          generos = '${detallesPopular['genres'][0]['name']}';
        } else {
          generos = 'Sin genero';
        }
      }
    }

    print("Este es el runtime ${detallesPopular['runtime']}");
    /*****************Mostrar fotos de actores***************************************** */
    var _listaCasting = <Widget>[];
    for( int i = 0; i<actoresPopular.length; i++){
      actoresPopular[i]['profile_path'] != null ? _listaCasting.add(//Si el actor tiene foto, entonces agrega el widget para mostrarla
        Row(
          children: [
            Column(
              children: [
                CircleAvatar(
                  maxRadius: 50,
                  backgroundImage: NetworkImage('https://image.tmdb.org/t/p/w500/${actoresPopular[i]['profile_path']}'),
                ),
                SizedBox(height: 5,),
                Text("${actoresPopular[i]['original_name']}", style: TextStyle(color: Colors.white),),
                SizedBox(height: 5,),
                Text("${actoresPopular[i]['character']}", style: TextStyle(color: Colors.white38),),
                SizedBox(height: 20,)
              ],
            ),
            SizedBox(width: 25,)
          ],
        )
      ) : null; //si no tiene foto, entonces no agrega nada
    }



    return Scaffold(
        body: Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('https://image.tmdb.org/t/p/w500/${detallesPopular['poster_path']}'), //pone como fondo la imagen del poster
                    fit: BoxFit.cover))),
        GlassmorphicContainer(
            width: double.infinity,
            height: double.infinity,
            borderRadius: 0,
            linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black45.withOpacity(0.1),
                  Colors.black45.withOpacity(0.05),
                ],
                stops: [
                  0.1,
                  1,
                ]),
            border: 0,
            blur: 100,
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFffffff).withOpacity(0.5),
                Color((0xFFFFFFFF)).withOpacity(0.5),
              ],
            ),
            child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 50),
                child: ListView(
                  physics: BouncingScrollPhysics(), //para elimminar el scroll glow/overscroll del ListView
                  padding: EdgeInsets.zero, //esto remueve el espacio que quedaba en la parte superior del list
                  children: [
                    Container(
                        //height: 60,
                        //color: Colors.green,
                        child: IconButton(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back, color: Colors.white))
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                                'https://image.tmdb.org/t/p/w500/${detallesPopular['poster_path']}',
                                width: 150)),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 180,
                                child: Text("${detalle['titulo']}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25))),
                            SizedBox(height: 20),
                            Text(
                                "Estreno: ${fechaSalida.day} de $mes de ${fechaSalida.year}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11)),
                            SizedBox(height: 10),
                            Text("$generos",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 10)),
                            SizedBox(height: 10),
                            (detallesPopular['runtime'] == 0) ? Text("Sin informacion", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200, fontSize: 10)) :  Text("${detallesPopular['runtime']} min", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200, fontSize: 10)),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Container(
                                    //para que la imagen se muestre requiere ancho y altura
                                    width: 31,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                './imgs/imdb-logo.png'),
                                            fit: BoxFit.fill))),
                                SizedBox(width: 5),
                                Text("${detallesPopular['vote_average']}/10 ",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 11)),
                                //Container(width: 180, child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et tellus condimentum, blandit turpis sed, tempus tortor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque rhoncus turpis dolor, eu dapibus metus dapibus sit amet. Ut venenatis dui at tellus luctus semper. Mauris interdum semper orci. Nullam in mattis enim. Quisque tincidunt elit eu tortor blandit luctus. Nulla et nisl eu dui faucibus malesuada sit amet eget lorem. Etiam felis felis, sodales eget pellentesque a, ultrices non libero. Proin non ipsum sed dui mattis tempor. Etiam vitae tellus nulla. Quisque at euismod ante. In nec fermentum leo, id semper nisl. Sed vestibulum consectetur placerat. Vestibulum in posuere magna. Ut sodales varius arcu, non fringilla mauris consequat vel. Maecenas vestibulum sollicitudin enim. Aenean imperdiet velit arcu, nec dictum urna tincidunt at. Duis auctor elit quis lorem pellentesque accumsan. Sed cursus, magna in luctus malesuada, lacus magna ultrices nisl, malesuada ultricies urna nisl et massa. Quisque ultricies pharetra placerat. Cras elit neque, tincidunt non maximus et, suscipit nec nisl. Donec blandit molestie rutrum. Curabitur velit dui, convallis nec magna vel, tempus scelerisque lorem. Quisque imperdiet elit id ante varius mattis. Maecenas sodales metus non fermentum fringilla. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin condimentum faucibus urna at mollis. Aliquam rutrum dolor a urna sollicitudin, a congue dui aliquet. Morbi imperdiet libero in enim porta suscipit. Nulla facilisi. Nulla facilisi. Morbi accumsan condimentum iaculis. Praesent aliquet et tortor id mattis. Aliquam nec urna tortor. Sed feugiat gravida neque eu vestibulum. Donec velit tellus, elementum eget congue quis, faucibus et nisl. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Praesent lobortis sapien ac vulputate elementum. Praesent aliquet euismod venenatis. Nulla nec velit euismod, iaculis ex in, venenatis nisl. Etiam facilisis convallis dolor, at condimentum nisl. Pellentesque tincidunt, felis lobortis dignissim ullamcorper, nisi diam lacinia ipsum, ac gravida dui nisi at enim. Nullam elementum a metus quis venenatis. Morbi non malesuada orci. Etiam eget consectetur urna. Duis nec mollis sem. Ut et diam sit amet metus placerat tincidunt non rhoncus lectus. Maecenas felis est, accumsan vitae varius nec, porttitor ut lorem. Vestibulum accumsan, lacus eget feugiat pellentesque, purus neque hendrerit libero, a imperdiet lorem leo et ligula. Aenean hendrerit vehicula dolor sed tristique. Nulla mollis dignissim nulla, quis porttitor ante finibus et. Nulla rutrum dolor sed orci faucibus maximus a et risus. Etiam vehicula nibh sit amet convallis porta. Duis non elit vel risus cursus mollis nec at dui. Nam mi diam, dapibus vulputate pretium et, tempor sit amet massa. Integer et purus id metus blandit malesuada vitae eu ex. Aenean rutrum malesuada hendrerit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25))),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    FlatButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      padding: const EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xFF21C7CF),
                                Color(0xFF32ECB9)
                              ]),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 88.0,
                              minHeight:
                                  50.0), // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.play_arrow_rounded, color: Colors.white, size: 35,),
                              SizedBox(width: 5),
                              Text('Reproducir',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                      SizedBox(height: 20,),
                    Divider(color: Colors.white24, thickness: 0.5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [ //onPressed insertar idUsuario, idPelicula y favorito (true / false)
                        IconButton(onPressed: (){}, icon: Icon(Icons.star_outline_rounded, color: Colors.white,)), //true = Icons.star_rate_rounded
                        SizedBox(width: 10,),
                        Text("Favorito", style: TextStyle(color: Colors.white38),) //true = Colors.white
                      ],
                    ),
                    //SizedBox(height: 20,),
                    Divider(color: Colors.white24, thickness: 0.5,),
                      SizedBox(height: 20,),
                    Text("Sinopsis", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 15,),
                    detallesPopular['overview'] != '' ? Text("${detallesPopular['overview']}", style: TextStyle(color: Colors.white),) : Text("No hay descripción disponible.", style: TextStyle(color: Colors.white),),
                      SizedBox(height: 20,),
                    Divider(color: Colors.white24, thickness: 0.5,),
                    Text("Actores", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20,),
                    Container(
                      width: 180,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _listaCasting
                        )
                      )
                    )
                  ],
                )
              )
            )
      ],
    )
  );
  }
}


/*
Widget _listaCasting(){
  if (1 == 1) {
    for (var i = 0; i < 5; i++) {
      
    }
  } else {
    return Text("Sin actores");
  }
}

Widget _actor(){
  return Column(
    children: [
      CircleAvatar(

      ),
      Text("")
    ],
  );
}*/