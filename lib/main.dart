import 'package:flutter/material.dart';
import 'Controllers/theme.dart'; // Importe o tema
import 'Views/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transporte Universitário',
      theme: AppTheme.themeData, // Aplique o tema aqui
      home: HomePage(),
      
    );
  }
}