import 'package:flutter/material.dart';
import 'package:red_social/componentes/botones.dart';
import 'package:red_social/paginas/auth/Crear_Cuenta.dart';
import 'package:red_social/paginas/auth/login.dart';

void main() {
  runApp(const Index());
}

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Botones(textBoton: 'Crear cuenta', accionBoton: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CrearCuenta()),
                  );
                },
              ),
            const SizedBox(height: 20),
            Botones(textBoton: 'Login', accionBoton: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
