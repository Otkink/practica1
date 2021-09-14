import 'package:flutter/material.dart';
import 'package:practica2/screens/drawerP.dart';

class Opcion1Screen extends StatefulWidget {
  Opcion1Screen({Key? key}) : super(key: key);

  @override
  _Opcion1ScreenState createState() => _Opcion1ScreenState();
}

class _Opcion1ScreenState extends State<Opcion1Screen> {

  TextEditingController montoController = TextEditingController();

  double monto = 0;
  double propina = 0;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Propinas"),
        backgroundColor: Colors.orangeAccent,
      ),
      drawer: drawerP(),
      body: Column( mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            controller: montoController,
            keyboardType: TextInputType.number, 
            decoration: const InputDecoration(
              icon: Icon(Icons.list_alt_outlined, color: Colors.red),
              hintText: 'Monto de consumo',
              labelText: 'Gasto',
            ),
           // onChanged: (value) => setState(() => monto = (double.parse(value))), //recupera un string del textfformfield y lo convierto para guardarlo en una variable double
          ),
        ),
        SizedBox(height: 50,),
        Container(margin: EdgeInsets.symmetric(horizontal: 100), child: RaisedButton( 
                      onPressed: () {   if(montoController.text.isNotEmpty && double.tryParse(montoController.text)!=null){ //valido si el campo no esta vacio y si es un double valido
                                        monto = double.parse(montoController.text);//convierto la entrada a un double
                                        showDialog<String>(//muestro un alertdialog
                                          context: context,
                                          builder: (BuildContext context) => AlertDialog(
                                            title: const Text('Resumen de pago'),
                                            content: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,//para que se ajuste solo al tamano de los children
                                              children: [Text("Consumo: \$$monto"),
                                                        Text("%10 propina: \$${(propina = monto*0.1).toStringAsFixed(2)}"), //10% de propina
                                                        SizedBox(height: 10),
                                                        Text("Total: \$${(monto+propina).toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold) )//redondeo las decimales a solo 2
                                              ],),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {Navigator.pop(context, 'Aceptar');},
                                                child: const Text('Aceptar'),
                                              ),
                                            ],
                                          ),
                                        );}

                                        else{ showDialog<String>(//muestro un alertdialog
                                          context: context,
                                          builder: (BuildContext context) => AlertDialog(
                                            title: const Text('Advertencia'),
                                            content: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,//para que se ajuste solo al tamano de los children
                                              children: [Text("Ingrese una cantidad valida"),
                                              ],),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {Navigator.pop(context, 'Aceptar');},
                                                child: const Text('Aceptar'),
                                              ),
                                            ],
                                          ),
                                        );}
                                      
                                        },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      padding: const EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: const BoxDecoration(
                          gradient:LinearGradient(
                            colors: <Color>[
                              Color(0xFFFF5E6F),
                              Color(0xFFFF5668),
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(80.0)),
                        ),
                        child: Container(
                          constraints: const BoxConstraints(minWidth: 180.0, minHeight: 60.0), // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: Text(
                            'Calcular',
                            textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Nunito', color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20 ),
                          ),
                        ),
                      ),
                    ),
                    )
        ],),
      );
  }
}
