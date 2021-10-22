import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/database/profiles_db.dart';
import 'package:practica2/src/main.dart';
import 'package:practica2/src/models/profiles_model.dart';
import 'package:practica2/src/utils/color_settings.dart';

class drawerPelis extends StatelessWidget {
  const drawerPelis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ProfileDB _profileDB = ProfileDB();
    //_profileDB.getProfile(1);
    /*DatabaseHelper _databaseHelper = DatabaseHelper();

                                                        _databaseHelper.getProfile(1);*/
    
    return Theme(
      data: Theme.of(context).copyWith(
       // Set the transparency here
       canvasColor: Colors.transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
      ),
      child: Container(
        width: 200,
        child: Drawer(
              child: Stack(
                children: [
                  BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), //this is dependent on the import statment above
                      child: Container(
                          decoration: BoxDecoration(color: Color(0xFF32ECB9).withOpacity(0.35))
                      )
                  ),
                  
                  ListView(
                  children: [
                    /*UserAccountsDrawerHeader(
                      onDetailsPressed: (){Navigator.pop(context); Navigator.pushNamed(context, "/perfil");}, //v2.2 Se retira del stack el Drawer para que al regresar a la pantalla anterior se tenga que vovler a desplegar y asi, los datos del UserAccount se actualicen.
                       accountName: Text("${resultGet[0]['nombre']} ${resultGet[0]['apaterno']}さん"), 
                      accountEmail: Text("${resultGet[0]['email']}"),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: Image.file(File(resultGet[0]['avatar'])).image,
                      ),
                      decoration: BoxDecoration(
                        color: ColorSettings.colorPrimary,
                      ),
                    ),*/
                    SizedBox(height: 300,),
                    ListTile(
                      title: Text("Inicio", style: TextStyle(color: Colors.white),),
                      leading: Icon(Icons.movie_creation_outlined, color: Colors.white),
                      //trailing: Icon(Icons.chevron_right),
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pushNamedAndRemoveUntil(context, "/movie", (route) => false);
                      }
                    ),
                    SizedBox(height: 50,),
                    ListTile(
                      title: Text("Favoritos", style: TextStyle(color: Colors.white)),
                      leading: Icon(Icons.favorite_outline, color: Colors.white,),
                      //trailing: Icon(Icons.chevron_right),
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/opc1");
                      }
                    ),
                  ],
                ),
              ]
              ),
              ),
      ),
    );
  }
}