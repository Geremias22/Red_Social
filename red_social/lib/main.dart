import 'package:flutter/material.dart';
import 'package:red_social/paginas/Configuracion/settings.dart';
import 'package:red_social/paginas/Home/CreatePage.dart';
import 'package:red_social/paginas/Home/home.dart';
import 'package:red_social/paginas/Home/profile.dart';
import 'package:red_social/paginas/Home/search.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:red_social/paginas/auth/Crear_Cuenta.dart';
import 'package:red_social/paginas/auth/Index.dart';



void main() async{
  await Hive.initFlutter();
  await Hive.openBox("box_lista_reserva");
  runApp(const MainApp()); 
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Index()
    );
  }
}
































































