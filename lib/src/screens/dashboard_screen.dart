import 'package:flutter/material.dart';
import 'package:practica2/src/database/profiles_db.dart';
import 'package:practica2/src/screens/drawerP.dart';
import 'package:practica2/src/utils/color_settings.dart';
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ProfileDB _profileDB = ProfileDB();
    _profileDB.getProfile(1);//Hago la consulta despues de que se "inicio sesion" para que la varible resultGet este inicializada con el usuario logeado
    //esto es suponiendo que no existe forma de "invitado" y siempre se accede a estas pantallas con un usuario
    

    return Scaffold(
      appBar: AppBar(
          title: Text('Dashboard'),
          backgroundColor: ColorSettings.colorPrimary,
        ),
        drawer: drawerP(),
    );
  }
}