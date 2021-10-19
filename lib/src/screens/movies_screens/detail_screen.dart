import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>; //cone sta instruccion es posible recuperar los parametros enviados en el Navigator.pushNamed(..., arguments:"...")
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://image.tmdb.org/t/p/w500/${movie['posterpath']}'),
          //fit: BoxFit.cover
        )
      ),
    );
  }
}