import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica2/src/database/profiles_db.dart';
import 'package:practica2/src/main.dart';
import 'package:practica2/src/models/profiles_model.dart';
import 'package:practica2/src/utils/color_settings.dart';

class drawerP extends StatelessWidget {
  const drawerP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileDB _profileDB = ProfileDB();
    _profileDB.getProfile(1);
    /*ProfilesModel profile = ProfilesModel( //EN CASO DE BORRADO ACCIDENTAL, DESCOMENTAR ESTE METODO Y RECARGAR ESTA PANTALLA
                                                        id: 1,//widget.profile!.id,
                                                        avatar: "/data/user/0/com.example.practica2/cache/image_picker5101347763199675778.jpg",
                                                        nombre: 'Daniel',
                                                        apaterno: 'Torres',
                                                        amaterno: 'Tolentino',
                                                        telefono: 4888741321,//convierto el valor String del campo a Integer
                                                        email: 'dsada@dasdasd.com'
                                                      );
                                                      _profileDB.update(profile.toMap()).then(
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
            ],
          ),
          );
  }
}