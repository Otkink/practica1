import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/database/profiles_db.dart';
import 'package:practica2/src/main.dart';
import 'package:practica2/src/models/profiles_model.dart';
import 'package:practica2/src/utils/color_settings.dart';

class drawerP extends StatelessWidget {
  const drawerP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ProfileDB _profileDB = ProfileDB();
    //_profileDB.getProfile(1);
    DatabaseHelper _databaseHelper = DatabaseHelper();

                                                        _databaseHelper.getProfile(1);
    
    return Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                onDetailsPressed: (){Navigator.pop(context); Navigator.pushNamed(context, "/perfil");}, //v2.2 Se retira del stack el Drawer para que al regresar a la pantalla anterior se tenga que vovler a desplegar y asi, los datos del UserAccount se actualicen.
                 accountName: Text("${resultGet[0]['nombre']} ${resultGet[0]['apaterno']}さん"), 
                accountEmail: Text("${resultGet[0]['email']}"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: Image.file(File(resultGet[0]['avatar'])).image,
                ),
                decoration: BoxDecoration(
                  color: ColorSettings.colorPrimary,
                ),
              ),
              ListTile(
                title: Text("Propinas"),
                subtitle: Text("Calcular total"),
                leading: Icon(Icons.monetization_on_outlined),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/opc1");
                }
              ),
              ListTile(
                title: Text("Intenciones"),
                subtitle: Text("Intenciones implicitas"),
                leading: Icon(Icons.phone_android),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/intenciones");
                }
              ),
              ListTile(
                title: Text("Notas"),
                subtitle: Text("CRUD Notas"),
                leading: Icon(Icons.note),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/notas");
                }
              ),
              ListTile(
                title: Text("映画"),
                subtitle: Text("Prueba API REST"),
                leading: Icon(Icons.movie),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/movie");
                }
              ),
              ListTile(
                title: Text("Tareas"),
                subtitle: Text("Lista de entregables"),
                leading: Icon(Icons.task),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/tareas");
                }
              ),
            ],
          ),
          );
  }
}