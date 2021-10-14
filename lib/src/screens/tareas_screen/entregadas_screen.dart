import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/tareas_model.dart';

class TareasEntregadas extends StatefulWidget {
  TareasModel? tarea;
  TareasEntregadas({Key? key, this.tarea}) : super(key: key);

  @override
  _TareasEntregadasState createState() => _TareasEntregadasState();
}

class _TareasEntregadasState extends State<TareasEntregadas> {
  late DatabaseHelper _databaseHelper;
  late DateTime fechaLimite = DateTime.parse(widget.tarea!.fechaEntrega!);

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color(0xFFFD548F),
      Color(0xFFF87063)
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //centro los elementos verticalmente
          children: [
            Container(
              padding: EdgeInsets.only(left: 50, top: 50, right: 50), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, //alineo los elementos a la izquierda
                children: [
                  Container(
                    height: 80, 
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(), 
                      child: Text("${widget.tarea!.nomTarea}", style: TextStyle(foreground: Paint()..shader = linearGradient, fontSize: 30, fontWeight: FontWeight.bold)))
                  ),
                  Divider(color: Colors.grey,),
                    SizedBox(height: 50),
                  Text("Descripción", style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 10,),
                  Container(
                    height: 250,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text("${widget.tarea!.dscTarea}", style: TextStyle(color: Colors.pink)),
                    ),
                  ),
                  //SizedBox(height: 10,),
                  //Text("${widget.tarea!.dscTarea}", style: TextStyle(color: Colors.pink)),
                    SizedBox(height: 30),
                  Text("Fecha límite", style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 10,),
                  Text("${fechaLimite.day} / ${fechaLimite.month} / ${fechaLimite.year}", style: TextStyle(color: Colors.pink)),
                    SizedBox(height: 50),
                  RaisedButton(
                      onPressed: () {
                        showDialog<String>(//muestro un alertdialog
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Deshacer entrega', style: TextStyle(color: Color(0xFFFD548F))),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,//para que se ajuste solo al tamano de los children
                              children: [
                                Text("¿Realmente desea realizar esta acción?")
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {Navigator.pop(context);},
                                child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
                              ),
                              TextButton(
                                onPressed: () {
                                  TareasModel tarea = TareasModel(
                                    idTarea: widget.tarea!.idTarea,
                                    nomTarea: widget.tarea!.nomTarea,
                                    dscTarea: widget.tarea!.dscTarea,
                                    fechaEntrega: widget.tarea!.fechaEntrega,
                                    entregada: 0 //actualizo el estatus a no entregada
                                  );
                                  _databaseHelper.updateTarea(tarea.toMap()).then(
                                    (value) {
                                      if(value > 0){
                                        
                                        Navigator.pushNamedAndRemoveUntil(context, '/tareas', (route) => false);
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("La solicitud no se completo")));
                                      }
                                    });
                                  //Navigator.pop(context, 'Aceptar');
                                },
                                child: const Text('Aceptar', style: TextStyle(color: Color(0xFFFF6B92))),
                              ),
                            ],),
                        );
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      padding: const EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xFFFD548F),
                              Color(0xFFF87063)
                            ]
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(80.0)),
                        ),
                        child: Container(
                          constraints: const BoxConstraints(minWidth: 88.0, minHeight: 50.0), // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: const Text(
                            'Deshacer entrega',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(alignment: Alignment.center, child: TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Descartar", style: TextStyle(color: Colors.grey))))
                ]
              ),
            ),
          ],
        ),
      ),
    );
    /*return Container(
      decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFFFD548F),
                      Color(0xFFF87063)
                    ]
                  ),
                ),
      child: Scaffold(
        //backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(1.7),
                  child: Container(
                    margin: const EdgeInsets.all(30.0),
                padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFFFD548F),
                      Color(0xFFF87063)
                    ]
                  ),
                
                    ),
                    child: Center(
                      child: SizedBox(height: 100,),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(30.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  
                ),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(15),
                  elevation: 10,
                  child: ListTile(
                    contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                    title: Text('Titulo'),
                    subtitle: Text(
                        'Este es el subtitulo del card. Aqui podemos colocar descripción de este card.'),
                    leading: Icon(Icons.home),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(15),
                elevation: 10,
                child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                  title: Text('Titulo'),
                  subtitle: Text(
                      'Este es el subtitulo del card. Aqui podemos colocar descripción de este card.'),
                  leading: Icon(Icons.home),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(15),
                elevation: 10,
                child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                  title: Text('Titulo'),
                  subtitle: Text(
                      'Este es el subtitulo del card. Aqui podemos colocar descripción de este card.'),
                  leading: Icon(Icons.home),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(15),
                elevation: 10,
                child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                  title: Text('Titulo'),
                  subtitle: Text(
                      'Este es el subtitulo del card. Aqui podemos colocar descripción de este card.'),
                  leading: Icon(Icons.home),
                ),
              )
            ]
          ),
        ),
      ),
    );*/
  }
}