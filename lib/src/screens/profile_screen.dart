import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:practica2/src/database/profiles_db.dart';
import 'package:practica2/src/models/profiles_model.dart';

class ProfileScreen extends StatefulWidget {

  ProfilesModel? profile;

  ProfileScreen({Key? key, this.profile}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late ProfileDB _profileDB;

  TextEditingController _txtName = TextEditingController();
  TextEditingController _txtApaterno = TextEditingController();
  TextEditingController _txtAmaterno = TextEditingController();
  TextEditingController _txtTel = TextEditingController();
  TextEditingController _txtEmail = TextEditingController();
  String avatar = 'https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aW5zdGFncmFtJTIwcHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80';//contendra la ubicacion de la imagen


  @override
  void initState() {

    super.initState();
    

    _profileDB = ProfileDB();

    _profileDB.getProfile(1);//como solo es 1 perfil por el momento hago la consulta directamente al registro que ya existe//este metodo guarda la cadena List en una var resultGet
    print('Esta es mi consulta jiji ${ProfileDB.resultGet}');
    print("Mi correo es ${ProfileDB.resultGet[0]['nombre']}");
    /*if(widget.profile != null){//rellenar campos
      avatar = widget.profile!.avatar!;
      _txtName.text = widget.profile!.nombre!;
      _txtApaterno.text = widget.profile!.apaterno!;
      _txtAmaterno.text = widget.profile!.amaterno!;
      _txtTel.text = '${widget.profile!.telefono!}';//corregir//buscar como convertir int a String
      _txtEmail.text = widget.profile!.email!;
    }*/

    if(ProfileDB.resultGet != null){//rellenar campos
      avatar = ProfileDB.resultGet[0]['avatar'];
      _txtName.text = ProfileDB.resultGet[0]['nombre'];
      _txtApaterno.text = ProfileDB.resultGet[0]['apaterno'];
      _txtAmaterno.text = ProfileDB.resultGet[0]['amaterno'];
      _txtTel.text = '${ProfileDB.resultGet[0]['telefono']}';
      _txtEmail.text = ProfileDB.resultGet[0]['email'];
    }

  }


  @override
  Widget build(BuildContext context) {
    /*******************Esto es lo que recarga el setState, porque el initState() se mantiene intacto*************************** */
    if(ProfileDB.resultGet != null){//rellenar campos
      avatar = ProfileDB.resultGet[0]['avatar'];
      _txtName.text = ProfileDB.resultGet[0]['nombre'];
      _txtApaterno.text = ProfileDB.resultGet[0]['apaterno'];
      _txtAmaterno.text = ProfileDB.resultGet[0]['amaterno'];
      _txtTel.text = '${ProfileDB.resultGet[0]['telefono']}';
      _txtEmail.text = ProfileDB.resultGet[0]['email'];
    }
    //****************************************************** */
    return Scaffold(
      body: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(avatar),//https://wallpaperaccess.com/full/2213424.jpg
                      fit: BoxFit.fitHeight
                      )
                  )
                ),
                SafeArea(
                  child: GlassmorphicContainer(
                    width: double.infinity, 
                    height: double.infinity, 
                    borderRadius: 0, 
                    linearGradient: 
                      LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFffffff).withOpacity(0.1),
                            Color(0xFFFFFFFF).withOpacity(0.05),
                          ],
                          stops: [
                            0.1,
                            1,
                          ]),
                          border: 0, 
                          blur: 7, 
                          borderGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFffffff).withOpacity(0.5),
                              Color((0xFFFFFFFF)).withOpacity(0.5),
                            ],
                      ),
                      child: Card(//envolver en un ListView para que la informacion no desborde al final
                        margin: EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 30),
                        color: Colors.transparent,
                        shadowColor: Colors.transparent,
                        child: Stack(
                          children: [
                            Container(//corregir para que el ancho sea por palabra, sino, esto cortara a aquellas palabras mas grandes
                              child: ListView(
                                physics: BouncingScrollPhysics(), //para elimminar el scroll glow/overscroll del ListView
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: (){print("fsjdnfsjndfkn"); print(_profileDB.getProfile(1)); },
                                        child: CircleAvatar(radius: 55, backgroundImage: NetworkImage(avatar),
                                        ),
                                      ),
                                      Container(margin: EdgeInsets.only(right: 20), 
                                                child: IconButton(
                                                  onPressed: (){
                                                    if(ProfileDB.resultGet == null){ //si es nulo (es decir, que no exista el profile) antes de presionar el icono insertara uno nuevo con los datos de cada texfield
                                                      ProfilesModel profile = ProfilesModel(
                                                        avatar: avatar,
                                                        nombre: _txtName.text,
                                                        apaterno: _txtApaterno.text,
                                                        amaterno: _txtAmaterno.text,
                                                        telefono: int.tryParse(_txtTel.text),//convierto el valor String del campo a Integer
                                                        email: _txtEmail.text
                                                      );

                                                      _profileDB.insert(profile.toMap()).then(
                                                        (value){
                                                          if(value > 0){
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(content: Text("Se han guardado los datos."))
                                                            );
                                                          }else{
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(content: Text("No se pudo guardar los datos."))
                                                            );
                                                          }
                                                        }
                                                      );
                                                    } else {
                                                      ProfilesModel profile = ProfilesModel(
                                                        id: 1,//widget.profile!.id,
                                                        avatar: avatar,
                                                        nombre: _txtName.text,
                                                        apaterno: _txtApaterno.text,
                                                        amaterno: _txtAmaterno.text,
                                                        telefono: int.tryParse(_txtTel.text),//convierto el valor String del campo a Integer
                                                        email: _txtEmail.text
                                                      );
                                                      _profileDB.update(profile.toMap()).then(
                                                        (value) {
                                                          if(value > 0){
                                                            
                                                            setState(() {_profileDB.getProfile(1); });
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(content: Text("Se han actualizado los datos."))
                                                            );
                                                          }else{
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(content: Text("No se pudieron guardar los datos."))
                                                            );
                                                          }
                                                        });
                                                    }
                                                  }, 
                                                  icon: Icon(Icons.upload, color: Colors.white,)))
                                      ]
                                    ,
                                  ),
                                  //SizedBox(height: 80,),
                                  Container(margin: EdgeInsets.only(top: 50, right: 100), child: Text(ProfileDB.resultGet[0]['nombre'], style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold ))),
                                  SizedBox(height: 20,),
                                  //Text("Estudiante", style: TextStyle(fontSize: 15, color: Colors.white )),
                                  Container(/*margin: EdgeInsets.only(right: 30),*/ child: Divider(color: Colors.white, thickness: 2,)),
                                  SizedBox(height: 50),
                                  Column(
                                    children: [
                                      Text("Nombre:", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold )),
                                      SizedBox(height: 5,),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 50), //limito el tamano del UnderlineInputBorder
                                        child: TextFormField(
                                          controller: _txtName,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white, ),
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            hintText: "Ingrese su nombre",
                                            hintStyle: TextStyle(color: Colors.white38, ),
                                            enabledBorder: UnderlineInputBorder(      
                                                    borderSide: BorderSide(color: Colors.transparent,),   
                                                    ),  
                                            focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white12),
                                                ),  
                                            //border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Column(
                                    children: [
                                      Text("Apellido Paterno:", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold )),
                                      SizedBox(height: 5,),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 50), //limito el tamano del UnderlineInputBorder
                                        child: TextFormField(
                                          controller: _txtApaterno,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white, ),
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            hintText: "Ingrese su apellido p.",
                                            hintStyle: TextStyle(color: Colors.white38, ),
                                            enabledBorder: UnderlineInputBorder(      
                                                    borderSide: BorderSide(color: Colors.transparent,),   
                                                    ),  
                                            focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white12),
                                                ),  
                                            //border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Column(
                                    children: [
                                      Text("Apellido Materno:", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold )),
                                      SizedBox(height: 5,),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 50), //limito el tamano del UnderlineInputBorder
                                        child: TextFormField(
                                          controller: _txtAmaterno,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white, ),
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            hintText: "Ingrese su apellido m.",
                                            hintStyle: TextStyle(color: Colors.white38, ),
                                            enabledBorder: UnderlineInputBorder(      
                                                    borderSide: BorderSide(color: Colors.transparent,),   
                                                    ),  
                                            focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white12),
                                                ),  
                                            //border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Column(
                                    children: [
                                      Text("Numero de telefono:", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold )),
                                      SizedBox(height: 5,),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 50), //limito el tamano del UnderlineInputBorder
                                        child: TextFormField(
                                          controller: _txtTel,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white, ),
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: "# telefonico",
                                            hintStyle: TextStyle(fontSize: 15, color: Colors.white38, ),
                                            enabledBorder: UnderlineInputBorder(      
                                                    borderSide: BorderSide(color: Colors.transparent,),   
                                                    ),  
                                            focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white12),
                                                ),  
                                            //border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Column(
                                    children: [
                                      Text("Correo electronico:", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold )),
                                      SizedBox(height: 5,),
                                      Container(
                                        //margin: EdgeInsets.symmetric(horizontal: 50), //limito el tamano del UnderlineInputBorder
                                        child: TextFormField(
                                          controller: _txtEmail,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white, ),
                                          keyboardType: TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            hintText: "Email",
                                            hintStyle: TextStyle(fontSize: 15, color: Colors.white38, ),
                                            enabledBorder: UnderlineInputBorder(      
                                                    borderSide: BorderSide(color: Colors.transparent),   
                                                    ),  
                                            focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white12),
                                                ),  
                                            //border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ),
                                
                           
                                
                          ],),
                      )
                      
                  ),
                ),
            ],
        
      ),
    );
  }

  
}