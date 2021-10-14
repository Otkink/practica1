import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:practica2/src/screens/tareas_screen/tareas_screen.dart';

class TareaDetalle extends StatefulWidget {
  TareasModel? tarea;
  TareaDetalle({Key? key, this.tarea}) : super(key: key);

  @override
  _TareaDetalleState createState() => _TareaDetalleState();
}

class _TareaDetalleState extends State<TareaDetalle> {
  late DatabaseHelper _databaseHelper;

  DateTime selectedDate = DateTime.now();
  bool isSwitched = false;

  TextEditingController _txtNom = new TextEditingController();
  TextEditingController _txtDsc = new TextEditingController();
  TextEditingController _txtFe = new TextEditingController();
  TextEditingController _txtSt = new TextEditingController(); //estatusTarea de tipo boolean PROVISIONAL

  @override
  void initState() {
    super.initState();

    if(widget.tarea != null){
      _txtNom.text = widget.tarea!.nomTarea!;
      _txtDsc.text = widget.tarea!.dscTarea!;
      selectedDate = DateTime.tryParse(widget.tarea!.fechaEntrega!)!; //transforma el strin a un Datetime
      isSwitched = widget.tarea!.entregada! == 1 ? true : false;
    }

    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFFFD548F),
                      Color(0xFFF87063)
                    ]
                  ),
                ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.only(left: 50, top: 50, right: 50), 
          child: ListView(
            physics: BouncingScrollPhysics(), //para elimminar el scroll glow/overscroll del ListView
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(child: widget.tarea == null ? Text("Crear tarea", style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.w300)) : Text("Editar tarea", style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.w300))),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: TextFormField(
                controller: _txtNom,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Tarea",
                  labelStyle: TextStyle(color: Colors.black26),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  ),
                ),
              )),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: TextFormField(
                minLines: 6, // any number you need (It works as the rows for the textarea)
                maxLines: null,
                controller: _txtDsc,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                //keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: "Descripcion",
                  labelStyle: TextStyle(color: Colors.black26),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  ),
                ),
              )),
                  
            Container(
                margin: EdgeInsets.only(top: 50),
                child: InkWell(
                  onTap: (){_selectDate(context);},
                  child: IgnorePointer(
                    child: TextFormField(
                      enabled: false,
                    controller: _txtFe,//no es necesario puesto que la fecha ya es guardada en una variable y mostrada en el field
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: "Fecha de entrega",
                      labelStyle: TextStyle(color: Colors.black26),
                      floatingLabelBehavior: FloatingLabelBehavior.always, //establece su estado como si se estuviera ingresando texto en el campo y aparece en la parte superior
                      hintText: "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      ),
                    ),
                                  ),
                  ),
                )),
                SizedBox(height: 40),
                Row(
                  children: [
                    Text('Entregada', style: TextStyle(color: Colors.black26),),
                    SizedBox(width: 60,),
                    AbsorbPointer(
                      child: Switch(
                        value: isSwitched, //corresponde al status de entrega true = 1, false = 0
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            print(isSwitched);
                          });
                        },
                        activeTrackColor: Colors.white30,
                        activeColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60,),
               widget.tarea != null ? Row( //Si se selecciono un elemento de la lista entonces mostrara dos botones: Guardar | Entregar
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      color: Colors.white,
                      highlightColor: Colors.white54,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      onPressed: () {
                            print(selectedDate);
                            String desc = _txtDsc.text;
                            print('inicio $desc fin');
                            print('Widget: ${widget.tarea!.nomTarea}');
                              TareasModel tarea = TareasModel(
                                idTarea: widget.tarea!.idTarea,
                                nomTarea: _txtNom.text,
                                dscTarea: _txtDsc.text,
                                fechaEntrega: selectedDate.toString(),
                                entregada: isSwitched == true ? 1 : 0
                              );
                              _databaseHelper.updateTarea(tarea.toMap()).then(
                                (value) {
                                  if(value > 0){
                                    
                                    Navigator.pushNamedAndRemoveUntil(context, '/tareas', (route) => false);
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("La solicitud no se completo")));
                                  }
                                });
                            
                          },
                        child: Text("Guardar", style: TextStyle(color: Color(0xFFFF6B92), fontSize: 20))
                      ),
                      RaisedButton(
                      color: Colors.white,
                      highlightColor: Colors.white54,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      onPressed: () {
                            print(selectedDate);
                            String desc = _txtDsc.text;
                            print('inicio $desc fin');
                            TareasModel tarea = TareasModel(
                                idTarea: widget.tarea!.idTarea,
                                nomTarea: _txtNom.text,
                                dscTarea: _txtDsc.text,
                                fechaEntrega: selectedDate.toString(),
                                entregada: 1 //El 1 indica que si ha sido entregada
                              );
                              _databaseHelper.updateTarea(tarea.toMap()).then(
                                (value) {
                                  if(value > 0){
                                    
                                    Navigator.pushNamedAndRemoveUntil(context, '/tareas', (route) => false);
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("La solicitud no se completo")));
                                  }
                                });
                          },
                        child: Text("Entregar", style: TextStyle(color: Color(0xFFFF6B92), fontSize: 20))
                      ) 
                  ],
                ) : //Si se crea un elemento entonces mostrara un boton: Guardar
                RaisedButton(
                      color: Colors.white,
                      highlightColor: Colors.white54,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      onPressed: () {
                            print(selectedDate);
                            String desc = _txtDsc.text;
                            print('inicio $desc fin');
                            if(widget.tarea == null){//SE PUEDE QUITAR LA CONDICION
                              String fechaE = selectedDate.toString();
                              TareasModel tarea = TareasModel(
                                nomTarea: _txtNom.text,
                                dscTarea: _txtDsc.text,
                                fechaEntrega: fechaE,
                                entregada: isSwitched == true ? 1 : 0
                              );

                              _databaseHelper.insertTarea(tarea.toMap()).then(
                                (value){
                                  if(value > 0){
                                    Navigator.pop(context);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => TareasScreen()));
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("La solicitud no se completo")));
                                  }
                                }
                              );
                            }
                          },
                        child: Text("Guardar", style: TextStyle(color: Color(0xFFFF6B92), fontSize: 20))
                      )
                ,
                SizedBox(height: 30,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 65),
                  child: FlatButton(
                    highlightColor: Colors.white24,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TareasScreen()));
                        },
                      child: Text("Descartar", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w100)),
                    ),
                ),
            ],
          ),
        ),
      ),
    );
  }
 _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
 
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  } 
}