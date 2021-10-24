import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practica2/src/database/profiles_db.dart';
import 'package:practica2/src/screens/agregar_nota_screen.dart';
import 'package:practica2/src/screens/intenciones_screen.dart';
import 'package:practica2/src/screens/movies_screens/detail_screen.dart';
import 'package:practica2/src/screens/movies_screens/popular_screen.dart';
import 'package:practica2/src/screens/notas_screen.dart';
import 'package:practica2/src/screens/opcion1_screen.dart';
import 'package:practica2/src/screens/profile_screen.dart';
import 'package:practica2/src/screens/splash_screen.dart';
import 'package:practica2/src/screens/tareas_screen/detalles_popular.dart';
import 'package:practica2/src/screens/tareas_screen/tareas_detalle_screen.dart';
import 'package:practica2/src/screens/tareas_screen/tareas_screen.dart';
import 'package:practica2/src/screens/video_player.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      theme: ThemeData( //Cambia el texto del status bar para todas las vistas
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false, // 1
          systemOverlayStyle: SystemUiOverlayStyle.light, // 2
        ),
      ),
      routes: {
        "/opc1": (BuildContext context) => Opcion1Screen(),
        "/intenciones": (BuildContext context) => IntencionesScreen(),
        "/notas": (BuildContext context) => NotasScreen(),
        "/agregar": (BuildContext context) => AgregarNotaScreen(),
        "/perfil": (BuildContext context) => ProfileScreen(),
        "/movie": (BuildContext context) => PopularScreen(),
        "/tareas": (BuildContext context) => TareasScreen(),
        "/t_det": (BuildContext context) => TareaDetalle(),
        "/detail": (BuildContext context) => DetailScreen(),
        "/d_pop": (BuildContext context) => DetallesPopularScreen(),
        "/video": (BuildContext context) => VideoPlayer()
      },
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

late var resultGet; //declaro la variable por fuera de los metodos para que pueda ser usado por cualquier metodo
late var detallesPopular; //almacena el JSON de la pelicula cada vez que se llama a getPopularDetails(int id)
late var actoresPopular; //almacena el JSON de la pelicula cada vez que se llama a getPopularDetails(int id)
late var videoPelicula;