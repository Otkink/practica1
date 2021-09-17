import 'package:flutter/material.dart';
import 'package:practica2/screens/login-screen.dart';
import 'package:practica2/utils/color_settings.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: LoginScreen(),
      duration: 5000,
      imageSrc: 'imgs/logo.png',
      imageSize: 150,
      text: 'ようこそ',
      backgroundColor: ColorSettings.colorPrimary,
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(fontSize:  35, fontWeight: FontWeight.bold),
      colors: [
        Colors.pink,
        Colors.purple,
        Colors.blue,
        Colors.green,
        Colors.orange,
        Colors.red
      ],
      );
  }
}