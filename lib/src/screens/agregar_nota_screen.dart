import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/notas_model.dart';
import 'package:practica2/src/utils/color_settings.dart';

class AgregarNotaScreen extends StatefulWidget {
  NotasModel? nota;
  AgregarNotaScreen({Key? key, this.nota}) : super(key: key);

  @override
  _AgregarNotaScreenState createState() => _AgregarNotaScreenState();
}

class _AgregarNotaScreenState extends State<AgregarNotaScreen> {

  late DatabaseHelper _databaseHelper;

  TextEditingController _controllerTitulo = TextEditingController();
  TextEditingController _controllerDetalle = TextEditingController();

  @override
  void initState() {

    if(widget.nota != null){
      _controllerTitulo.text = widget.nota!.titulo!;
      _controllerDetalle.text = widget.nota!.detalle!;
    }

    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSettings.colorPrimary,
        title: widget.nota == null ? Text("ノートを追加") : Text("ノートを編集"),
      ),
      body: Column(
        children: [
          _crearTextFieldTitulo(),
          SizedBox(height: 10,),
          _crearTextFieldDetalle(),
          ElevatedButton(
            onPressed: (){
              NotasModel nota = NotasModel(
                titulo: _controllerTitulo.text,
                detalle: _controllerDetalle.text
              );

              _databaseHelper.insert(nota.toMap()).then(
                (value){
                  if(value > 0){
                    //Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Registro insertado exitosamente"))
                    );
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("La solicitud no se completo "))
                    );
                  }
                }
              );
            },
            child: Text(" 保存"),

          )
        ],
      ),
    );
  }

  Widget _crearTextFieldTitulo(){
    return TextField(
      controller: _controllerTitulo,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        labelText: "ノートタイトル",
        errorText: "Este campo es obligatorio"
      ),
      onChanged: (value){
         
      },
    );
  }

  Widget _crearTextFieldDetalle(){
    return TextField(
      controller: _controllerDetalle,
      keyboardType: TextInputType.text,
      maxLines: 8,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        labelText: "ノートの詳細",
        errorText: "Este campo es obligatorio"
      ),
      onChanged: (value){
         
      },
    );
  }
}