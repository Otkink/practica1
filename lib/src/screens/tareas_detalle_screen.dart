import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TareaDetalle extends StatefulWidget {
  TareaDetalle({Key? key}) : super(key: key);

  @override
  _TareaDetalleState createState() => _TareaDetalleState();
}

class _TareaDetalleState extends State<TareaDetalle> {
  DateTime selectedDate = DateTime.now();
  bool isSwitched = false;

  TextEditingController _txtNom = new TextEditingController();
  TextEditingController _txtDsc = new TextEditingController();
  TextEditingController _txtFe = new TextEditingController();
  TextEditingController _txtSt = new TextEditingController(); //estatusTarea de tipo boolean PROVISIONAL

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
              Container(child: Text("Editar tarea", style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.w300))),
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
                      },
                    child: Text("Entregar", style: TextStyle(color: Color(0xFFFF6B92), fontSize: 20)),
                  ),
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
                        },
                      child: Text("Descartar cambios", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w100)),
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