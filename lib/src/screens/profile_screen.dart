import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:practica2/src/screens/drawerP.dart';
import 'package:practica2/src/utils/color_settings.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://wallpaperaccess.com/full/2213424.jpg'),
                  fit: BoxFit.fitHeight
                  )
              )
            ),
            SafeArea(
              child: GlassmorphicContainer(
                width: double.maxFinite, 
                height: double.maxFinite, 
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
                    margin: EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 50),
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: Stack(
                      children: [
                        Container(//corregir para que el ancho sea por palabra, sino, esto cortara a aquellas palabras mas grandes
                          child: ListView(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(radius: 55, backgroundImage: NetworkImage('https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aW5zdGFncmFtJTIwcHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80'),
                                  ),
                                  Container(margin: EdgeInsets.only(right: 20), child: IconButton(onPressed: (){print("object");}, icon: Icon(Icons.edit, color: Colors.white,)))
                                ],
                              ),
                              //SizedBox(height: 80,),
                              Container(margin: EdgeInsets.only(top: 50, right: 100), child: Text("Daniel", style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold ))),
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
                                      //controller: txtEmailCon,
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
                                      //controller: txtEmailCon,
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
                                      //controller: txtEmailCon,
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
                                      //controller: txtEmailCon,
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
                                      //controller: txtEmailCon,
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
                  
                  /*Card(
                   // margin: EdgeInsets.only(top: 500, right: 15, left: 15, bottom: 15),
                    color: Colors.transparent,
                    //shadowColor: Colors.transparent,
                    child: ListView(
                      children: [
                        Text("Daniel Torres", style: TextStyle(fontSize: 20, color: Colors.white)),
            
                        SizedBox(height: 20,),
                        
            
                        TextFormField(
                          //controller: txtEmailCon,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Introduce email",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)
                          ),
                        ),
            
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorSettings.colorButton
                          ),
                          onPressed: (){
                            print("hola");
                            setState(() {});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.login),
                              Text('Validar usuario'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),  */
              ),
            ),
        ],
    );
  }
}