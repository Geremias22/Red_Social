// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text('Hello!'),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:red_social/paginas/Inicio/Crear_Cuenta.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:red_social/paginas/Inicio/Index.dart';


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

