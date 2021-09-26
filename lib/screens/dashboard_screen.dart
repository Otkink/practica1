import 'package:flutter/material.dart';
import 'package:practica2/src/screens/drawerP.dart';
import 'package:practica2/src/utils/color_settings.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Dashboard'),
          backgroundColor: ColorSettings.colorPrimary,
        ),
        drawer: drawerP(),
    );
  }
}