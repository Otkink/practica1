import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/main.dart';
import 'package:practica2/src/models/notas_model.dart';
import 'package:practica2/src/models/profiles_model.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _nombreBD = 'NOTASBD';
  static final _versionBD = 1;
  static final _nombreTBL = 'tblNotas';  

  static Database? _database;
  Future<Database?> get database async {
    print("Estoy en get Database");
    if( _database != null ) return _database;
    _database = await _initDatabase();
    return _database;
  }

 Future<Database> _initDatabase() async{
   Directory carpeta = await getApplicationDocumentsDirectory();
   String rutaBD = join(carpeta.path,_nombreBD);
   print(rutaBD+' '+_nombreBD);
   return openDatabase(
     rutaBD,
     version: _versionBD,
     onCreate: _crearTabla
   );
 }

 Future<void> _crearTabla(Database db, int version) async{
   await db.execute("CREATE TABLE $_nombreTBL (id INTEGER PRIMARY KEY, titulo VARCHAR(50), detalle VARCHAR(100))");
   await db.execute("CREATE TABLE tblProfiles (id INTEGER PRIMARY KEY, avatar TEXT, nombre VARCHAR(20), apaterno VARCHAR(20), amaterno varchar(20), telefono INTEGER, email VARCHAR(100))");
   await db.execute("CREATE TABLE tblTareas (idTarea INTEGER PRIMARY KEY, nomTarea VARCHAR(50), dscTarea TEXT, fechaEntrega DATETIME, entregada INTEGER)");
 }

 Future <int> insert(Map<String,dynamic> row) async{
   var conexion = await database;
   return conexion!.insert(_nombreTBL, row);
 }

 Future<int> update(Map<String,dynamic> row) async{
   var conexion = await database;
   return conexion!.update(_nombreTBL, row, where: 'id = ?', whereArgs: [row['id']]);
 }

 Future<int> delete(int id) async{
   var conexion = await database;
   return await conexion!.delete(_nombreTBL, where: 'id = ?', whereArgs: [id]);
 }

 Future<List<NotasModel>> getAllNotes() async {
   var conexion = await database;
   var result = await conexion!.query(_nombreTBL);
   return result.map((notaMap) => NotasModel.fromMap(notaMap)).toList();
 }

 Future<NotasModel> getNote(int id) async {
   var conexion = await database;
   var result = await conexion!.query(_nombreTBL, where: 'id=?', whereArgs: [id]);
   return NotasModel.fromMap(result.first);
 }


/****************CONSULTAS PROFILE**************** */

 Future <int> insertProfile(Map<String,dynamic> row) async{
   var conexion = await database;
   return conexion!.insert("tblProfiles", row);
 }

 Future<int> updateProfile(Map<String,dynamic> row) async{
   var conexion = await database;
   return conexion!.update("tblProfiles", row, where: 'id = ?', whereArgs: [row['id']]);
 }

 Future<int> deleteProfile(int id) async{
   var conexion = await database;
   return await conexion!.delete("tblProfiles", where: 'id = ?', whereArgs: [id]);
 }

 Future<List<ProfilesModel>> getAllProfiles() async {
   var conexion = await database;
   var result = await conexion!.query("tblProfiles");
   return result.map((notaMap) => ProfilesModel.fromMap(notaMap)).toList();
 }

 Future<ProfilesModel> getProfile(int id) async {
   var conexion = await database;
   var result = await conexion!.query("tblProfiles", where: 'id=?', whereArgs: [id]);
   //print(result);
   print(result);
   resultGet = result;
   //print("PDB $resultGet");
   return ProfilesModel.fromMap(result.first);
 }
/**************FIN PROFILE************************ */

/*-------------------------------------------------*/
/**************CONSULTAS TAREAS******************* */

 Future <int> insertTarea(Map<String,dynamic> row) async{
   var conexion = await database;
   return conexion!.insert('tblTareas', row);
 }

 Future<int> updateTarea(Map<String,dynamic> row) async{
   var conexion = await database;
   print("Actualizare la tarea");
   print("${row['idTarea']}");
   print(row);
   return conexion!.update('tblTareas', row, where: 'idTarea = ?', whereArgs: [row['idTarea']]);
 }

 Future<int> deleteTarea(int id) async{
   var conexion = await database;
   print('Oh no! me eliminan $id');
   return await conexion!.delete('tblTareas', where: 'idTarea = ?', whereArgs: [id]);
 }

 Future<List<TareasModel>> getAllTareas() async {
   print("me llamaron a getAllTareas");
   var conexion = await database;
   var result = await conexion!.query('tblTareas');
   return result.map((tareaMap) => TareasModel.fromMap(tareaMap)).toList();
 }

 Future<TareasModel> getTarea(int id) async {
   var conexion = await database;
   var result = await conexion!.query('tblTareas', where: 'idTarea=?', whereArgs: [id]);
   //print(result);
   //print(result);
   //resultGet = result;
   //print("PDB $resultGet");
   return TareasModel.fromMap(result.first);
 }

//innecesario????
 Future<TareasModel> getTareaSE(int status) async {//recuperta todas las tareas sin entregar
   var conexion = await database;
   var result = await conexion!.query('tblTareas', where: 'entregada=?', whereArgs: [status]);
   //print(result);
   //print(result);
   //resultGet = result;
   //print("PDB $resultGet");
   return TareasModel.fromMap(result.first);
 }

 Future<List<TareasModel>> getTareasEstatus(int status) async {//recupera todas las tareas entregadas si status = 1 //recupera todas las tareas sin entregar si status = 0
   var conexion = await database;
   var result = await conexion!.query('tblTareas', where: 'entregada=?', whereArgs: [status], orderBy: 'fechaEntrega'); //ordenadas por fecha mas reciente
   //print(result);
   //print(result);
   //resultGet = result;
   //print("PDB $resultGet");
   return result.map((tareaMap) => TareasModel.fromMap(tareaMap)).toList();
 }
/***************FIN TAREAS************************ */
}