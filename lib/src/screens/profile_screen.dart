import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica2/src/database/profiles_db.dart';
import 'package:practica2/src/main.dart';
import 'package:practica2/src/models/profiles_model.dart';

class ProfileScreen extends StatefulWidget {

  ProfilesModel? profile;

  ProfileScreen({Key? key, this.profile}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  //String avatar = 'https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aW5zdGFncmFtJTIwcHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80';//contendra la ubicacion de la imagen
  File? image;
  String avatar = resultGet[0]['avatar'];
  String avatar2 = '';
  Future pickImage() async{ //metodo para escoger la imagen de la Galeria
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null){
        print("Cancele la accion");
        return;
      } else{
        final imageTemporary = File(image.path);
        print(image.path);
        avatar = image.path;

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
              setState(() {_profileDB.getProfile(1); }); //vuelvo a hacer la consulta para actualizar el valor de resultGet
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Se ha actualizado la foto."))
              );
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("No se pudo actualizar la foto."))
              );
            }
        });

        setState(() => this.image = imageTemporary);
      }
    } on PlatformException catch (e) {
      print('Seleccion de imagen fallida: $e');
    }
  }

  late ProfileDB _profileDB;

  TextEditingController _txtName = TextEditingController();
  TextEditingController _txtApaterno = TextEditingController();
  TextEditingController _txtAmaterno = TextEditingController();
  TextEditingController _txtTel = TextEditingController();
  TextEditingController _txtEmail = TextEditingController();
  

  @override
  void initState() {

    super.initState();

    _profileDB = ProfileDB();
    _profileDB.getProfile(1);//como solo es 1 perfil por el momento hago la consulta directamente al registro que ya existe//este metodo guarda la cadena List en una var resultGet
    /*//lo invoco desde aqui para que cada vez acceda a esta pantalla se actualice la variable
    print('Esta es mi consulta jiji ${resultGet}');
    print("Mi correo es ${resultGet[0]['nombre']}");*/
    /*if(widget.profile != null){//rellenar campos
      avatar = widget.profile!.avatar!;
      _txtName.text = widget.profile!.nombre!;
      _txtApaterno.text = widget.profile!.apaterno!;
      _txtAmaterno.text = widget.profile!.amaterno!;
      _txtTel.text = '${widget.profile!.telefono!}';//corregir//buscar como convertir int a String
      _txtEmail.text = widget.profile!.email!;
    }*/
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
                                                            
                                                            setState(() {_profileDB.getProfile(1); }); //vuelvo a hacer la consulta para actualizar el valor de resultGet
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(content: Text("Se ha actualizado la foto."))
                                                            );
                                                          }else{
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(content: Text("No se pudo actualizar la foto."))
                                                            );
                                                          }
                                                        });*/

    if(resultGet != null){//rellena campos antes de abrir la pantalla
      avatar = resultGet[0]['avatar'];
      _txtName.text = resultGet[0]['nombre'];
      _txtApaterno.text = resultGet[0]['apaterno'];
      _txtAmaterno.text = resultGet[0]['amaterno'];
      _txtTel.text = '${resultGet[0]['telefono']}';
      _txtEmail.text = resultGet[0]['email'];
    }

  }


  @override
  Widget build(BuildContext context) {
    /*******************Esto es lo que recarga el setState, porque el initState() se mantiene intacto*************************** */
    if(resultGet != null){//rellenar campos
      avatar = resultGet[0]['avatar'];
      _txtName.text = resultGet[0]['nombre'];
      _txtApaterno.text = resultGet[0]['apaterno'];
      _txtAmaterno.text = resultGet[0]['amaterno'];
      _txtTel.text = '${resultGet[0]['telefono']}';
      _txtEmail.text = resultGet[0]['email'];
    }
    //****************************************************** */
    return Scaffold(
      body: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.file(File(avatar)).image,//https://wallpaperaccess.com/full/2213424.jpg
                      fit: BoxFit.cover
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
                            Colors.black45.withOpacity(0.1),
                            Colors.black45.withOpacity(0.05),
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
                                        onTap: (){ pickImage();},
                                        child: CircleAvatar(radius: 55, backgroundImage: Image.file(File(avatar)).image //NetworkImage(avatar),
                                        ),
                                      ),
                                      Container(margin: EdgeInsets.only(right: 20), 
                                                child: IconButton(
                                                  onPressed: (){
                                                    if(resultGet == null){ //si es nulo (es decir, que no existe el registro) antes de presionar el icono insertara uno nuevo con los datos de cada texfield
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
                                                            
                                                            setState(() {_profileDB.getProfile(1); }); //vuelvo a hacer la consulta para actualizar el valor de resultGet
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
                                  Container(margin: EdgeInsets.only(top: 50, right: 100), child: Text(resultGet[0]['nombre'], style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold ))),
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