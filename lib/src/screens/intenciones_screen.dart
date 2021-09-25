import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:url_launcher/url_launcher.dart';

class IntencionesScreen extends StatefulWidget {
  IntencionesScreen({Key? key}) : super(key: key);

  @override
  _IntencionesScreenState createState() => _IntencionesScreenState();
}

class _IntencionesScreenState extends State<IntencionesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Intenciones Implicitas"),
        backgroundColor: ColorSettings.colorPrimary,
      ),
      body: ListView(
        children: [
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.white54,
              title: Text('ウェブページを開く'),
              subtitle: Row(
                children: [
                  Icon(Icons.touch_app_rounded, size: 18.0, color: Colors.red,),
                  Text('https://celaya.tecnm.mx/'),
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.language, color: Colors.black),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(width: 1.0)),
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _abrirWeb,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.white54,
              title: Text('電話'),
              subtitle: Row(
                children: [
                  Icon(Icons.touch_app_rounded, size: 18.0, color: Colors.red,),
                  Text('Cel: 4616874125'),
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.phone_android, color: Colors.black),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(width: 1.0)),
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _llamadaTelefonica,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.white54,
              title: Text('メッセージ送信'),
              subtitle: Row(
                children: [
                  Icon(Icons.touch_app_rounded, size: 18.0, color: Colors.red,),
                  Text('Cel: 4616874125'),
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.sms_sharp, color: Colors.black),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(width: 1.0)),
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _enviarSMS,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.white54,
              title: Text('電子メール送信'),
              subtitle: Row(
                children: [
                  Icon(Icons.touch_app_rounded, size: 18.0, color: Colors.red,),
                  Text('dtt@itcelaya.edu.mx へ'),
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.email_outlined, color: Colors.black),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(width: 1.0)),
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _enviarEmail,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.white54,
              title: Text('写真を撮る'),
              subtitle: Row(
                children: [
                  Icon(Icons.touch_app_rounded, size: 18.0, color: Colors.red,),
                  Text('笑ってね (≧◡≦)'),
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.camera_alt_outlined, color: Colors.black),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(width: 1.0)),
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: (){},
            ),
          )
        ],
      ),
    );
  }

  _abrirWeb() async{
    const url = 'https://celaya.tecnm.mx/';
    if( !await canLaunch(url)){ //この「！」が必要だ
      await launch(url);
    }
  }
  

  _llamadaTelefonica() async{
    const url = 'tel:4616874125';
    if( !await canLaunch(url)){ //この「！」が必要だ
      await launch(url);
    }
  }

  _enviarSMS() async{
    const url = 'sms:4616874125';
    if( !await canLaunch(url)){ //この「！」が必要だ
      await launch(url);
    }
  }

  _enviarEmail() async{
    final Uri params = Uri(
      scheme: 'mailto',
      path: '17030428@itcelaya.edu.mx',
      query: 'subject=挨拶&body=ようこそへ'
    );
    
    var email = params.toString();
    if (!await canLaunch(email)) {
      await launch(email);
    }
  }

  tomarFoto(){

  }
}