import 'package:flutter/material.dart';
import 'package:red_social/paginas/Home/search.dart';
import 'package:red_social/paginas/Inicio/Crear_Cuenta.dart';


void main() {
  runApp(const MainApp()); 
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Search()
    );
  }
}

