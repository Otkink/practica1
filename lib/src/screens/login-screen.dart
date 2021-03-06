import 'package:flutter/material.dart';
import 'package:practica2/src/screens/dashboard_screen.dart';
import 'package:practica2/src/utils/color_settings.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var isLoading = false;
  TextEditingController txtEmailCon = TextEditingController();
  TextEditingController txtPwdCon = TextEditingController();

  @override
  Widget build(BuildContext context) {

    
  TextFormField txtEmail = TextFormField(
    controller: txtEmailCon,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      hintText: "Introduce email",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)
    ),
  );

  TextFormField txtPwd = TextFormField(
    controller: txtPwdCon,
    keyboardType: TextInputType.visiblePassword,
    maxLength: 5,
    obscureText: true,
    decoration: InputDecoration(
      hintStyle: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
          hintText: "Introduce contrasena",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          
        ),
  );

    ElevatedButton btnLogin = ElevatedButton( 
      style: ElevatedButton.styleFrom(
        primary: ColorSettings.colorButton
      ),
      onPressed: (){
        print(txtEmailCon.text);
        isLoading = true;
        setState(() {});
        Future.delayed(Duration(seconds: 5), (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.login),
          Text('Validar usuario')
        ],
      ),
    );

    return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('imgs/4909661.jpg'),
                  fit: BoxFit.fill
                  )
              )
            ),
            //LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
              //return SingleChildScrollView(
                //child: 
                Card(
                margin: EdgeInsets.symmetric(horizontal: 15),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      txtEmail,
                      SizedBox(height: 5),
                      txtPwd,
                      btnLogin
                    ],
                  ),
                ),
              ),
              //);
            //}),
              
            Positioned(
              child: Image.asset('imgs/logo.png', width: 150,),
              top: 250,
            ),
            Positioned(
              child: isLoading==true ? CircularProgressIndicator() : Container(),
              top: 500)
          ],
        );
  }
  
    

}