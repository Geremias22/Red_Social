import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:red_social/paginas/auth/Index.dart';
import 'package:red_social/componentes/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false; // Devuelve true si hay sesión activa
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data == true) {
              return const MainScreen(); // Si hay sesión, va a la pantalla principal
            } else {
              return const Index(); // Si no, muestra la pantalla de inicio (Index)
            }
          }
        },
      ),
    );
  }
}
