import 'package:flutter/material.dart';
import 'package:red_social/componentes/botones.dart';
import 'package:red_social/componentes/input_text.dart';
import 'package:red_social/paginas/Inicio/Index.dart';
import 'package:red_social/paginas/Inicio/login.dart';

class CrearCuenta extends StatefulWidget {
  const CrearCuenta({super.key});

  @override
  State<CrearCuenta> createState() => _CrearCuentaState();
}

class _CrearCuentaState extends State<CrearCuenta> {
  TextEditingController tecNom = TextEditingController();
  TextEditingController tecCorreo = TextEditingController();
  TextEditingController tecPassw = TextEditingController();
  TextEditingController tecRePassw = TextEditingController();
  final bool invert = false; // Mantiene la estética oscura

  // Método para validar el correo
  bool validarCorreo(String correo) {
    String patron =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'; // Expresión regular
    return RegExp(patron).hasMatch(correo);
  }

  // Método para validar la creación de la cuenta
  void validarYCrearCuenta() {
    String correo = tecCorreo.text.trim();
    String passw = tecPassw.text;
    String rePassw = tecRePassw.text;

    if (correo.isEmpty || passw.isEmpty || rePassw.isEmpty) {
      mostrarMensaje("Todos los campos son obligatorios.");
      return;
    }

    if (!validarCorreo(correo)) {
      mostrarMensaje("Formato de correo inválido, debe se '@gmail.com' por ejemplo");
      return;
    }

    if (passw.length < 6) {
      mostrarMensaje("La contraseña debe tener al menos 6 caracteres.");
      return;
    }

    if (passw != rePassw) {
      mostrarMensaje("Las contraseñas no coinciden.");
      return;
    }

    // Si todo está correcto, navega al Login
    mostrarMensaje("Cuenta creada exitosamente!", esExito: true);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    });
  }

  // Método para mostrar mensajes en un SnackBar
  void mostrarMensaje(String mensaje, {bool esExito = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          mensaje,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: esExito ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text(
          "Crear Cuenta",
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: const Color.fromARGB(167, 251, 251, 251),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 50, right: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Crear Cuenta",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              InputText(
                textEtiqueta: "Introduce el nombre",
                textHint: "Introduce tu nombre..",
                tecInput: tecNom,
                invert: invert,
              ),
              const SizedBox(height: 20),
              InputText(
                textEtiqueta: "Introduce el correo",
                textHint: "Introduce tu correo...",
                tecInput: tecCorreo,
                invert: invert,
              ),
              const SizedBox(height: 20),
              InputText(
                textEtiqueta: "Introduce la contraseña",
                textHint: "Introduce tu contraseña...",
                tecInput: tecPassw,
                invert: invert,
                passwd: true,
              ),
              const SizedBox(height: 20),
              InputText(
                textEtiqueta: "Repite la contraseña",
                textHint: "Repite tu contraseña...",
                tecInput: tecRePassw,
                invert: invert,
                passwd: true,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Botones(
                    textBoton: "Crear Cuenta",
                    accionBoton: validarYCrearCuenta, // Validación antes de crear
                  ),
                  const SizedBox(height: 15),
                  Botones(
                    textBoton: "Volver",
                    accionBoton: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Index()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
