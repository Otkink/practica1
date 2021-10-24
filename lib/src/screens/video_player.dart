import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practica2/src/main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  VideoPlayer({Key? key}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  YoutubePlayerController? _controller ;


  @override
  Widget build(BuildContext context) {
    print('SOY NULL $videoPelicula');
    print('SOY NULL ${videoPelicula.toString()}');
      if(videoPelicula.toString() != '[]'){
        _controller = YoutubePlayerController(
        initialVideoId: videoPelicula[0]['key'],
        flags: YoutubePlayerFlags(
          controlsVisibleAtStart: true,
            autoPlay: true,
            mute: false,
            hideControls: false
          ),
        );
      }
    //final detalle = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>; //cone sta instruccion es posible recuperar los parametros enviados en el Navigator.pushNamed(..., arguments:"...")
    if(videoPelicula.toString() != '[]'){
      if(videoPelicula[0]['key'] != ''){
      return YoutubePlayer(
        controller: _controller!,
        //showVideoProgressIndicator: true,
        progressIndicatorColor: Color(0xFF21C7CF),
        progressColors: ProgressBarColors(
          playedColor: Color(0xFF21C7CF),
          handleColor: Color(0xFF32ECB9),
        ),
        );
    }else{
      return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("No hay video disponible")
            ],
          ),
        ),
      );
    }
    } else{
      return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("No hay video disponible")
            ],
          ),
        ),
      );
    }
  }
}