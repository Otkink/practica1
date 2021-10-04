import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/models/profiles_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProfileDB {
  static final _nombreBD = 'NOTASBD';
  static final _versionBD = 2;//nueva version
  static final _nombreTBL = 'tblProfiles';  

  static late var resultGet;

  static Database? _database;
  Future<Database?> get database async {
    print("Estoy en get Database");
    if( _database != null ) return _database;
    _database = await _initDatabase();
    return _database;
  }

 Future<Database> _initDatabase() async{
   print("estoy en _initDatabase");
   Directory carpeta = await getApplicationDocumentsDirectory();
   String rutaBD = join(carpeta.path,_nombreBD);
   print(rutaBD+' '+_nombreBD);
   return openDatabase(
     rutaBD,
     version: _versionBD,
     onUpgrade: _crearTabla,
   );
 }

 Future<void> _crearTabla(Database db, int oldVersion, int version) async{
   print("Estoy creando la tabla!!!");
   oldVersion = 1;
   if(oldVersion == 1){
    await db.execute("CREATE TABLE $_nombreTBL (id INTEGER PRIMARY KEY, avatar TEXT, nombre VARCHAR(20), apaterno VARCHAR(20), amaterno varchar(20), telefono INTEGER, email VARCHAR(100))");
   }
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

 Future<List<ProfilesModel>> getAllProfiles() async {
   var conexion = await database;
   var result = await conexion!.query(_nombreTBL);
   return result.map((notaMap) => ProfilesModel.fromMap(notaMap)).toList();
 }

 Future<ProfilesModel> getProfile(int id) async {
   var conexion = await database;
   var result = await conexion!.query(_nombreTBL, where: 'id=?', whereArgs: [id]);
   print(result);
   print(result[0]['nombre']);
   resultGet = result;
   print("PDB $resultGet");
   return ProfilesModel.fromMap(result.first);
 }
}