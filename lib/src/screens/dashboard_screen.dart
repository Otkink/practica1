import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/database/profiles_db.dart';
import 'package:practica2/src/models/profiles_model.dart';
import 'package:practica2/src/network/api_popular.dart';
import 'package:practica2/src/screens/drawerP.dart';
import 'package:practica2/src/utils/color_settings.dart';
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //ProfileDB _profileDB = ProfileDB();
    //_profileDB.getProfile(1);//Hago la consulta despues de que se "inicio sesion" para que la varible resultGet este inicializada con el usuario logeado
    //esto es suponiendo que no existe forma de "invitado" y siempre se accede a estas pantallas con un usuario
    DatabaseHelper _databaseHelper = DatabaseHelper();
    _databaseHelper.getProfile(1);
    /*  ProfilesModel profile = ProfilesModel( //EN CASO DE BORRADO ACCIDENTAL, DESCOMENTAR ESTE METODO Y RECARGAR ESTA PANTALLA
                                                        id: 1,//widget.profile!.id,
                                                        avatar: "/data/user/0/com.example.practica2/cache/image_picker5101347763199675778.jpg",
                                                        nombre: 'Daniel',
                                                        apaterno: 'Torres',
                                                        amaterno: 'Tolentino',
                                                        telefono: 4888741321,//convierto el valor String del campo a Integer
                                                        email: 'dsada@dasdasd.com'
                                                      );
                                                      _databaseHelper.insertProfile(profile.toMap()).then(
                                                        (value) {
                                                          if(value > 0){
                                                            
                                                            //setState(() {_profileDB.getProfile(1); }); //vuelvo a hacer la consulta para actualizar el valor de resultGet
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(content: Text("Se ha actualizado la foto."))
                                                            );
                                                          }else{
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(content: Text("No se pudo actualizar la foto."))
                                                            );
                                                          }
                                                        });*/
    //ApiPopular? apiPopular = ApiPopular();
    //apiPopular.getPopularDetails(379686); 

    return Scaffold(
      appBar: AppBar(
          title: Text('Dashboard'),
          backgroundColor: ColorSettings.colorPrimary,
        ),
        drawer: drawerP(),
    );
  }
}