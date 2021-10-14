import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/database/tareas_db.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:practica2/src/screens/opcion1_screen.dart';
import 'package:practica2/src/screens/tareas_detalle_screen.dart';

class TareasScreen extends StatefulWidget {
  const TareasScreen({Key? key}) : super(key: key);

  @override
  State<TareasScreen> createState() => _TareasScreenState();
}

class _TareasScreenState extends State<TareasScreen> {

  //late TareasDB _tareasDB;
  late DatabaseHelper _databaseHelper;

   List<String> items = List<String>.generate(20, (i) => 'Item ${i + 1}');
   var eliminado = false;

  @override
  void initState() {
    super.initState();
    //_tareasDB = TareasDB();
    _databaseHelper = DatabaseHelper();
  }
  void refreshList(){
    setState(() { //llamar a la consulta nuevamente
      items = List<String>.generate(20, (i) => 'Item ${i + 1}');

    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top
              ),
              child: Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.all(18.0),
                    onPressed: (){Navigator.pop(context);}, 
                    icon: Icon(Icons.arrow_back, color: Colors.white,),
                    
                  ),
                  Text(
                    'Tareas',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFF6B92),
                    Color(0xFFFF7B69)
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

            bottomNavigationBar:Container(
    child: TabBar(
      //unselectedLabelColor: Colors.white,
      indicatorPadding: EdgeInsets.all(5),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Color(0xFFFF6B92),
                    onTap: (index){refreshList();}, //cada vez que se hace click en un Tab se llama al metodo para actualizar el scaffold
                      tabs: [
                        Tab(
                          child: Container(width: 60 , child: Icon(Icons.pending_actions, color: Color(0xFFFF6B92),)),
                        ),
                        Tab(
                          child: Container(width: 60, child: Icon(Icons.task, color: Color(0xFFFF6B92))),
                        ),
                      ]
                    ),
                ),
            
            body: TabBarView(
              children: [
                Scaffold(
                  floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
                  floatingActionButton: Container(margin: EdgeInsets.only(bottom: 35),
                    child: FloatingActionButton(
                    
                      backgroundColor: Colors.white,
                      child: Icon(Icons.add, color: Color(0xFFFF6B92),size: 35,),
                      onPressed: (){
                        print("Add");
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/t_det");
                      }),
                  ),
                    appBar: AppBar(
                      leadingWidth: 0.0, //para alinear el texto a la izquierda
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      title: Text("Pendientes", style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.normal) ),
                    ),
                  body: FutureBuilder(
                    future: _databaseHelper.getTareasEstatus(0),///_tareaDB.getTarea(0);
                    builder: (BuildContext context, AsyncSnapshot<List<TareasModel>> snapshot) {
                      if (snapshot.hasError){
                        return Center(child: Text("Ocurrio un error en la peticion"));
                      } else {
                        if (snapshot.connectionState == ConnectionState.done) {
                          List<TareasModel> tareas = snapshot.data!;
                          
                          return ListView.builder(
                                    itemCount: tareas.length,
                                    itemBuilder: (context, index) {
                                      TareasModel tarea = tareas[index];
                                      final item = items[index];
                                      return Dismissible(
                                        // Each Dismissible must contain a Key. Keys allow Flutter to
                                        // uniquely identify widgets.
                                        key: Key(tarea.idTarea.toString()),
                                        // Provide a function that tells the app
                                        // what to do after an item has been swiped away.
                                        confirmDismiss: (DismissDirection direction) async{
                                          if(direction == DismissDirection.endToStart){
                                          await showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("Confirmación"),
                                                    content: Text("¿Desea eliminar esta tarea?"),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                            print("eliinado00");
                                                            //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tarea eliminada.')));
                                                            eliminado = true;
                                                            _databaseHelper.deleteTarea(tarea.idTarea!); //elimino el registro de la tabla
                                                            // Remove the item from the data source.
                                                            setState(() {
                                                              tareas.removeAt(index);
                                                              });
                                                          },
                                                        child: Text("Eliminar", style: TextStyle(color: Colors.red),)
                                                      ),
                                                      FlatButton(
                                                        onPressed: () => Navigator.of(context).pop(false),
                                                        child: Text("Cancelar"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ); 
                                          }else{
                                            TareasModel tareaUpdated = TareasModel(//recupero todos los valores tal cual del registro y solo cambio el status a entregada, luego realizo el update
                                              idTarea: tarea.idTarea,
                                              nomTarea: tarea.nomTarea,
                                              dscTarea: tarea.dscTarea,
                                              fechaEntrega: tarea.fechaEntrega,
                                              entregada: 1 //establezco el status a entregada
                                            );
                                            _databaseHelper.updateTarea(tareaUpdated.toMap()).then(
                                              (value) {
                                                if(value > 0){
                                                  setState(() {});
                                                  //Navigator.pushNamedAndRemoveUntil(context, '/tareas', (route) => false);
                                                }else{
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("La solicitud no se completo")));
                                                }
                                              });
                                            print("Tarea entregada");
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tarea entregada.'), duration: Duration(milliseconds: 500)));
                                              // Remove the item from the data source.
                                              setState(() {
                                                items.removeAt(index);
                                              });
                                          }
                                          if(eliminado){ //lo muestro aqui porque el context del boton no es el Scaffold por alguna razon 
                                            eliminado = false; //resetea el valor para que no vuelva a entrar hast que sea cambiado en el boton ELiminar del AlertDialog
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tarea eliminada.'), duration: Duration(milliseconds: 500),));
                                          }
                                        },
                                        /*onDismissed: (direction) {
                                      
                                          if (direction == DismissDirection.startToEnd) {
                                              print("Tarea entregada");
                                              // Remove the item from the data source.
                                              setState(() {
                                                items.removeAt(index);
                                              });
                                              // Then show a snackbar.
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tarea entregada.')));
                                              
                                            } else {
                                              print('Tarea eliminada');
                                              // Then show a snackbar.
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tarea eliminada.')));
                                            }
                                      
                                          setState(() {
                                            items.removeAt(index);
                                          });
                                        },*/
                                        // Show a red background as the item is swiped away.
                                        background: Container( //scroll a la derecha ENTREGADA
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(margin: EdgeInsets.only(left: 20) , child: Icon(Icons.task_alt_rounded, color: Colors.white,)),      
                                            ],
                                          ), 
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFFF6B92),
                                                Color(0xFFFF7B69)
                                              ]
                                            ),
                                          ),
                                        ),
                                        secondaryBackground: Container( //scroll a la izq. ELIMINADA
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [               
                                              Container(margin: EdgeInsets.only(right: 20) , child: Icon(Icons.delete_forever, color: Colors.white,)),
                                            ],
                                          ), 
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFFF6B92),
                                                Color(0xFFFF7B69)
                                              ]
                                            ),
                                          ),
                                        ),
                                      
                                        child: ListTile(
                                          title: DateTime.parse(tarea.fechaEntrega!).isBefore(DateTime.now()) == false ? Text(tarea.nomTarea.toString()) : Text('(VENCIDA) ${tarea.nomTarea.toString()}', style: TextStyle(color: Colors.grey)),
                                          subtitle:  DateTime.parse(tarea.fechaEntrega!).isBefore(DateTime.now()) == false ? Text("Fecha de entrega: ${tarea.fechaEntrega.toString()}") : Text("Fecha de entrega: ${tarea.fechaEntrega.toString()}", style: TextStyle(color: Colors.red[400]),),
                                          onTap: (){
                                            print("U've picked me");
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => TareaDetalle(tarea: tarea,)));
                                            //Navigator.pushNamed(context, "/t_det");
                                          
                                          }
                                        ),
                                      );
                                    },
                                                );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }
                    },
                  )
                ),
/***************************************************************************************************************************************************** */
              Container(child: Scaffold(
              
                    appBar: AppBar(
                      leadingWidth: 0.0, //para alinear el texto a la izquierda
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      title: Text("Entregadas", style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.normal) ),
                    ),
                  body: FutureBuilder(
                    future: _databaseHelper.getTareasEstatus(1),///_tareaDB.getTarea(0);
                    builder: (BuildContext context, AsyncSnapshot<List<TareasModel>> snapshot) {
                      if (snapshot.hasError){
                        return Center(child: Text("Ocurrio un error en la peticion"));
                      } else {
                        if (snapshot.connectionState == ConnectionState.done) {
                          List<TareasModel> tareas = snapshot.data!;
                          
                          return ListView.builder(
                                    itemCount: tareas.length,
                                    itemBuilder: (context, index) {
                                      TareasModel tarea = tareas[index];
                                      return Dismissible(
                                        // Each Dismissible must contain a Key. Keys allow Flutter to
                                        // uniquely identify widgets.
                                        key: Key(tarea.idTarea.toString()),
                                        // Provide a function that tells the app
                                        // what to do after an item has been swiped away.
                                        confirmDismiss: (DismissDirection direction) async{
                                          if(direction == DismissDirection.endToStart){
                                          await showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("Confirmación"),
                                                    content: Text("¿Desea eliminar esta tarea?"),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                            print("eliinado Entregado");
                                                            //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tarea eliminada.')));
                                                            eliminado = true;
                                                            
                                                            //_databaseHelper.getTarea(1);
                                                            // Remove the item from the data source.
                                                            setState(() {
                                                              items.removeAt(index);});
                                                          },
                                                        child: Text("Eliminar", style: TextStyle(color: Colors.red),)
                                                      ),
                                                      FlatButton(
                                                        onPressed: () => Navigator.of(context).pop(false),
                                                        child: Text("Cancelar"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ); 
                                          }else{
                                            print("Tarea entregada");
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tarea entregada.'), duration: Duration(milliseconds: 500)));
                                              // Remove the item from the data source.
                                              setState(() {
                                                items.removeAt(index);
                                              });
                                          }
                                          if(eliminado){ //lo muestro aqui porque el context del boton no es el Scaffold por alguna razon 
                                            eliminado = false; //resetea el valor para que no vuelva a entrar hasta que sea cambiado en el boton Eliminar del AlertDialog
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tarea eliminada.'), duration: Duration(milliseconds: 500),));
                                          }
                                        },
                                        
                                        // Show a red background as the item is swiped away.
                                        background: Container( //scroll a la derecha ENTREGADA
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(margin: EdgeInsets.only(left: 20) , child: Icon(Icons.task_alt_rounded, color: Colors.white,)),      
                                            ],
                                          ), 
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFFF6B92),
                                                Color(0xFFFF7B69)
                                              ]
                                            ),
                                          ),
                                        ),
                                        secondaryBackground: Container( //scroll a la izq. ELIMINADA
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [               
                                              Container(margin: EdgeInsets.only(right: 20) , child: Icon(Icons.delete_forever, color: Colors.white,)),
                                            ],
                                          ), 
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFFF6B92),
                                                Color(0xFFFF7B69)
                                              ]
                                            ),
                                          ),
                                        ),
                                      
                                        child: ListTile(
                                          title: Text(tarea.nomTarea.toString()),
                                          subtitle: Text("Fecha de entrega: ${tarea.fechaEntrega.toString()}"),
                                          onTap: (){
                                            print("U've picked me");
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => TareaDetalle(tarea: tarea,)));
                                            //Navigator.pushNamed(context, "/t_det");
                                          
                                          }
                                        ),
                                      );
                                    },
                                                );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }
                    },
                  )
                ),
              ),
              ]
            ),
        ),
/***************************************************************************************************************************************************** */
      );
    
  }
}