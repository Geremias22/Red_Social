import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:red_social/paginas/Home/search.dart';
import 'package:red_social/paginas/auth/PortalAuth.dart';
import 'firebase_options.dart';
import 'paginas/auth/Index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Asegura que Firebase esté bien configurado
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la barra de debug
      title: 'Red Social', 
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema de la app
      ),
      home: const PortalAuth(),
 // La pantalla inicial
    );
  }
}
    