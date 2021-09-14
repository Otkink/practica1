import 'package:flutter/material.dart';
import 'package:practica2/utils/color_settings.dart';

class drawerP extends StatelessWidget {
  const drawerP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("Daniel Torresさん"), 
                accountEmail: Text("dtt@itcelaya.edu.mx"),
                currentAccountPicture: CircleAvatar(
                  child: Image.network("https://www.pngall.com/wp-content/uploads/5/Profile-Avatar-PNG.png"),
                ),
                decoration: BoxDecoration(
                  color: ColorSettings.colorPrimary
                ),
              ),
              ListTile(
                title: Text("Propinas"),
                subtitle: Text("Calcular total"),
                leading: Icon(Icons.monetization_on_outlined),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.pushNamed(context, "/opc1");
                }
              ),
              ListTile(
                title: Text("Titulo 2"),
                subtitle: Text("Descripcion corta"),
                leading: Icon(Icons.thermostat),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  
                }
              ),
            ],
          ),
          );
  }
}