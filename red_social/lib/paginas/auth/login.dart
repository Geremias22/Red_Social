import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:red_social/paginas/Configuracion/settings.dart';
import 'package:red_social/paginas/auth/servicios/servicios_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:red_social/componentes/botones.dart';
import 'package:red_social/componentes/custom_appbar.dart';
import 'package:red_social/componentes/input_text.dart';
import 'package:red_social/componentes/main_screen.dart'; // Ahora redirige a la pantalla principal
import 'package:red_social/paginas/auth/Index.dart';


class Login extends StatelessWidget {
  const Login({super.key});

  // Método para manejar el inicio de sesión
  Future<void> _login(BuildContext context, String email, String password) async {
  ServiciosAuth authService = ServiciosAuth();
  String? resultado = await authService.iniciarSesion(email, password);

  if (resultado == null) {
    // Login exitoso
    var userData = await authService.getUserData();
    String nombre = userData?['nombre'] ?? 'Usuario';

    // Guardar en SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('nombreUsuario', nombre);

    // Mostrar mensaje de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Bienvenido, $nombre')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  } else {
    // Mostrar error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(resultado)),
    );
  }
}

  

  @override
  Widget build(BuildContext context) {
    TextEditingController tecCorreo = TextEditingController();
    TextEditingController tecPassw = TextEditingController();

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

            // Campo de correo
            InputText(
              textEtiqueta: "Inserta el correo",
              tecInput: tecCorreo,
              textHint: "Escribe el correo...",
            ),

            const SizedBox(height: 20),

            // Campo de contraseña
            InputText(
              textEtiqueta: "Inserta la contraseña",
              tecInput: tecPassw,
              textHint: "Escribe la contraseña...",
              passwd: true, // Hace que el campo oculte la contraseña
            ),

            const SizedBox(height: 30),

            // Botón de login
            Botones(
              textBoton: "Aceptar",
              accionBoton: () => _login(context, tecCorreo.text, tecPassw.text),
            )
          ],
        ),
      ),
    );
  }
}
