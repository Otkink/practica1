import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/main.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TareasDB {
  static final _nombreBD = 'NOTASBD';
  static final _versionBD = 3;//nueva version
  static final _nombreTBL = 'tblTareas';  

  //static late var resultGet;
  static Database? _database;
  Future<Database?> get database async {
    print("Estoy en get Database Tareas v$_versionBD");
    //getProfile(1);
    //_database?.setVersion(_versionBD);
    if( _database != null ) return _database;
    _database = await _initDatabase();
    return _database;
  }

 Future<Database> _initDatabase() async{
   print("estoy en _initDatabase de Tareas DB");
   //getTarea(1);
   Directory carpeta = await getApplicationDocumentsDirectory();
   String rutaBD = join(carpeta.path,_nombreBD);
   print("Tareas BD: "+rutaBD+' '+_nombreBD);
   return openDatabase(
     rutaBD,
     version: _versionBD,
     onUpgrade: _crearTabla,
   );
 }

 Future<void> _crearTabla(Database db, int oldVersion, int version) async{
   print("Estoy creando la tabla TAREAS!!!");
   oldVersion = 2;
   if(oldVersion < 3){
     print("soy old version 2");
    await db.execute("CREATE TABLE $_nombreTBL (idTarea INTEGER PRIMARY KEY, nomTarea VARCHAR(50), dscTarea TEXT, fechaEntrega DATETIME, entregada INTEGER)");
   }
 }

 Future <int> insert(Map<String,dynamic> row) async{
   var conexion = await database;
   return conexion!.insert(_nombreTBL, row);
 }

 Future<int> update(Map<String,dynamic> row) async{
   var conexion = await database;
   return conexion!.update(_nombreTBL, row, where: 'idTarea = ?', whereArgs: [row['idTarea']]);
 }

 Future<int> delete(int id) async{
   var conexion = await database;
   return await conexion!.delete(_nombreTBL, where: 'idTarea = ?', whereArgs: [id]);
 }

 Future<List<TareasModel>> getAllTareas() async {
   print("me llamaron a getAllTareas");
   var conexion = await database;
   var result = await conexion!.query(_nombreTBL);
   return result.map((tareaMap) => TareasModel.fromMap(tareaMap)).toList();
 }

 Future<TareasModel> getTarea(int id) async {
   var conexion = await database;
   var result = await conexion!.query(_nombreTBL, where: 'idTarea=?', whereArgs: [id]);
   //print(result);
   print(result);
   resultGet = result;
   //print("PDB $resultGet");
   return TareasModel.fromMap(result.first);
 }

//innecesario????
 Future<TareasModel> getTareaSE(int status) async {//recuperta todas las tareas sin entregar
   var conexion = await database;
   var result = await conexion!.query(_nombreTBL, where: 'entregada=?', whereArgs: [status]);
   //print(result);
   print(result);
   resultGet = result;
   //print("PDB $resultGet");
   return TareasModel.fromMap(result.first);
 }

 Future<TareasModel> getTareasEstatus(int status) async {//recupera todas las tareas entregadas si status = 1 //recupera todas las tareas sin entregar si status = 0
   var conexion = await database;
   var result = await conexion!.query(_nombreTBL, where: 'entregada=?', whereArgs: [status]);
   //print(result);
   print(result);
   resultGet = result;
   //print("PDB $resultGet");
   return TareasModel.fromMap(result.first);
 }
}