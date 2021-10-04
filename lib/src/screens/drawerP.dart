import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica2/src/database/profiles_db.dart';
import 'package:practica2/src/main.dart';
import 'package:practica2/src/utils/color_settings.dart';

class drawerP extends StatelessWidget {
  const drawerP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileDB _profileDB = ProfileDB();
    _profileDB.getProfile(1);
    
    return Drawer(
          child: ListView(
            children: [
              /*UserAccountsDrawerHeader(
                accountName: Text("Daniel Torresさん"), 
                accountEmail: Text("dtt@itcelaya.edu.mx"),
                currentAccountPicture: CircleAvatar(
                  child: Image.network("https://www.pngall.com/wp-content/uploads/5/Profile-Avatar-PNG.png"),
                ),
                decoration: BoxDecoration(
                  color: ColorSettings.colorPrimary,
                ),
              ),*/
              UserAccountsDrawerHeader(
                onDetailsPressed: (){Navigator.pushNamed(context, "/perfil");},
                accountName: Text("${resultGet[0]['nombre']} ${resultGet[0]['apaterno']}さん"), 
                accountEmail: Text("dtt@itcelaya.edu.mx"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: Image.file(File(resultGet[0]['avatar'])).image,
                  //modificar para que este ajutado al circulo
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
            ],
          ),
          );
  }
}