import 'dart:io';
//PROBLEMA> Al tener el teclado abierto y luego cambiar la imagen provoca que el area del teclado se quede en blanco y el Scaffold queda comprimida en el area restante/ //SOLO LA PRIMERA VEZ QUE SE cambia la foto
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/database/profiles_db.dart';
import 'package:practica2/src/main.dart';
import 'package:practica2/src/models/profiles_model.dart';
import 'package:path/path.dart';

class ProfileScreen extends StatefulWidget {

  ProfilesModel? profile;

  ProfileScreen({Key? key, this.profile}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  /**VARIABLES TEMPORALES */
  late String tmpNombre = '';
  late String tmpApaterno = '';
  late String tmpAmaterno = '';
  late String tmpTel = '';
  late String tmpEmail = '';

  var _hasChanged = false; //indica si el textfield ha cambiado sus valores de entrada
  /**temporales */

  //String avatar = 'https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aW5zdGFncmFtJTIwcHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80';//contendra la ubicacion de la imagen
  File? image;
  String avatar = resultGet[0]['avatar'];
  //String avatar2 = '';
  Future pickImage() async{ //metodo para escoger la imagen de la Galeria
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null){
        print("Cancele la accion");
        return;
      } else{
        //final imageTemporary = File(image.path);
        //print(image.path);
        avatar = image.path; //image.path siempre es la ruta al archivo temporal
        /*final imagePermanent = await saveImagePermanently(image.path);
        print('Esto es temporal: $avatar');
        print('Esto es permanente: $imagePermanent');
        avatar = imagePermanent.path;*/
        final imageTemporary = File(image.path);
        setState(() { }); //actualiza la pagina para que aparezca la nueva imagen
        setState(() => this.image = imageTemporary );
        //setState(() => this.image = imagePermanent);
      }
    } on PlatformException catch (e) {
      print('Seleccion de imagen fallida: $e');
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  void refreshProfile(){
    print("recargando...");
    _databaseHelper.getProfile(1); 
    
    print('refreshProfile: ${resultGet[0]['nombre']}');
    setState(() {}); //vuelvo a hacer la consulta para actualizar el valor de resultGet
  }


  //late ProfileDB _profileDB;
  late DatabaseHelper _databaseHelper;

  TextEditingController _txtName = TextEditingController();
  TextEditingController _txtApaterno = TextEditingController();
  TextEditingController _txtAmaterno = TextEditingController();
  TextEditingController _txtTel = TextEditingController();
  TextEditingController _txtEmail = TextEditingController();
  

  @override
  void initState() {

    super.initState();
    _databaseHelper = DatabaseHelper();
    _databaseHelper.getProfile(1);
    //_profileDB = ProfileDB();
    //_profileDB.getProfile(1);//como solo es 1 perfil por el momento hago la consulta directamente al registro que ya existe//este metodo guarda la cadena List en una var resultGet
    
    if(resultGet != null){//rellena campos antes de abrir la pantalla
      avatar = avatar!= resultGet[0]['avatar'] ? avatar : resultGet[0]['avatar'];
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
      if(_hasChanged){ //solo si hubo algun cambio en los textfield, entonces, despues de recargar el state de la pantalla se actualizaran los campos con los valores temporales //esto es a causa de que si modifico un textfield sin cargarlos a la tabla y luego cambio la foto, los textfields son cargados con la informacion que hay en la tabla.
        _databaseHelper.getProfile(1);
        avatar = avatar!= resultGet[0]['avatar'] ? avatar : resultGet[0]['avatar'];
        _txtName.text = tmpNombre=='' ? resultGet[0]['nombre'] : tmpNombre;
        print('hasCHangd $tmpNombre');
        _txtApaterno.text = tmpApaterno=='' ? resultGet[0]['apaterno'] : tmpApaterno;
        _txtAmaterno.text = tmpAmaterno=='' ? resultGet[0]['amaterno'] : tmpAmaterno;
        _txtTel.text = tmpTel=='' ? '${resultGet[0]['telefono']}' : tmpTel;
        _txtEmail.text = tmpEmail=='' ? resultGet[0]['email'] : tmpEmail;
      }else{//si no hubo cambios en los textfield pero si en la imagen, entonces se actualiza todo
        _databaseHelper.getProfile(1);
        avatar = avatar!= resultGet[0]['avatar'] ? avatar : resultGet[0]['avatar'];
        print('hasntCahnge $tmpNombre');
        _txtName.text = resultGet[0]['nombre'];
        _txtApaterno.text = resultGet[0]['apaterno'];
        _txtAmaterno.text = resultGet[0]['amaterno'];
        _txtTel.text = '${resultGet[0]['telefono']}';
        _txtEmail.text = resultGet[0]['email'];
      }
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
                                        child: CircleAvatar(radius: 55, backgroundImage: (avatar != resultGet[0]['avatar']) ? Image.file(File(avatar)).image : Image.file(File(resultGet[0]['avatar'])).image //NetworkImage(avatar),
                                        ),
                                      ),
                                      Container(margin: EdgeInsets.only(right: 20), 
                                                child: IconButton(
                                                  onPressed: () async {
                                                    String avatarPermanente = avatar; //Si es la primera vez que se entra en la pantalla y no se selecciona ninguna imagen, entonces tendra el valor recuperado de la BD. Si se selecciona una imagen entonces tomara el valor de la ruta temporal, pero como ya se selecciono alguna, entonces sera sustituida posteriormente por la ruta permanente.
                                                    if (image == null){}//si es null es porque no se ha seleccionado ninguna imagen, si hay una imagen es porque el usuario quiere cambiar la foto, si no le gusta, simplemente
                                                      else{ 
                                                        //image!.delete(); //sirve para borrar la imagen almacenada permanentemente
                                                        imageCache!.clear();//limpia las imagenes de la cache de la app
                                                        final imagePermanent = await saveImagePermanently(image!.path); //hasta que se selccione una imagen y se presione el IconButton, es entonces que se guardara permanentemente
                                                        print('Esto es temporal: $avatar');
                                                        
                                                        print('Esto es permanente: $imagePermanent');
                                                        avatarPermanente = imagePermanent.path; //actualizo la ruta que contiene la variable para que sea actualizada o insertada en el registro
                                                      }


                                                    if(resultGet == null){ //si es nulo (es decir, que no existe el registro) antes de presionar el icono insertara uno nuevo con los datos de cada texfield
                                                      ProfilesModel profile = ProfilesModel(
                                                        avatar: avatarPermanente,
                                                        nombre: _txtName.text,
                                                        apaterno: _txtApaterno.text,
                                                        amaterno: _txtAmaterno.text,
                                                        telefono: int.tryParse(_txtTel.text),//convierto el valor String del campo a Integer
                                                        email: _txtEmail.text
                                                      );

                                                      _databaseHelper.insertProfile(profile.toMap()).then(
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
                                                        avatar: avatarPermanente,
                                                        nombre: _txtName.text,
                                                        apaterno: _txtApaterno.text,
                                                        amaterno: _txtAmaterno.text,
                                                        telefono: int.tryParse(_txtTel.text),//convierto el valor String del campo a Integer
                                                        email: _txtEmail.text
                                                      );
                                                      _databaseHelper.updateProfile(profile.toMap()).then(
                                                        (value) {
                                                          if(value > 0){
                                                            refreshProfile();
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
                                          onChanged: (text){ tmpNombre = text; _hasChanged = true; },
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
                                          onChanged: (text){ tmpApaterno = text; _hasChanged = true;},
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
                                          onChanged: (text){ tmpAmaterno = text; _hasChanged = true;}, //if(_hasChanged){_txtName.text = re}else{_txtName.text = resultGet[0]['nombre'];}
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
                                          onChanged: (text){ tmpTel = text; _hasChanged = true;},
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
                                          onChanged: (text){ tmpEmail = text; _hasChanged = true;},
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