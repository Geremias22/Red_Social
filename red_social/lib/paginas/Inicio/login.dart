import 'package:flutter/material.dart';
import 'package:red_social/componentes/botones.dart';
import 'package:red_social/componentes/custom_appbar.dart';
import 'package:red_social/componentes/input_text.dart';
import 'Index.dart';

void main() {
  runApp(Login());
}

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Index(),
    );
  }
}



class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController tecCorreo = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: const CustomAppBar(title: "Login"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
           
            InputText(textEtiqueta: "Inserta el correo", tecInput: tecCorreo, textHint: "Escribe el correo...",),

            const SizedBox(height: 20),

            InputText(textEtiqueta: "Inserta la contraseña", tecInput: tecCorreo, textHint: "Escribe la contraseña...",),

            const SizedBox(height: 30),
            Botones(textBoton: "Aceptar", accionBoton: (){})
          ],
        ),
      ),
    );
  }
}
