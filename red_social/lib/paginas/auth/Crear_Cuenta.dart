import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:red_social/componentes/botones.dart';
import 'package:red_social/componentes/custom_appbar.dart';
import 'package:red_social/componentes/input_text.dart';
import 'package:red_social/paginas/auth/Index.dart';
import 'package:red_social/paginas/auth/login.dart';
import 'package:red_social/paginas/auth/servicios/servicios_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

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

  void probarEscrituraFirestore() async {
    try {
      print("📝 Intentando escribir un documento de prueba en Firestore...");
      
      await FirebaseFirestore.instance.collection("Prueba").doc("test").set({
        "mensaje": "Hola desde Flutter",
        "timestamp": FieldValue.serverTimestamp(),
      });

      print("✅ Escritura exitosa en Firestore.");

    } catch (e) {
      print("❌ Error al escribir en Firestore: $e");
    }
  }


  // Método para validar y registrar cuenta en Firebase
  void validarYCrearCuenta() async {
  print("🔄 Verificando conexión antes de crear usuario...");
  verificarConexionFirestore();  // Llama a la función antes de registrar

    String nombre = tecNom.text.trim();
    String correo = tecCorreo.text.trim();
    String passw = tecPassw.text;
    String rePassw = tecRePassw.text;

    if (nombre.isEmpty || correo.isEmpty || passw.isEmpty || rePassw.isEmpty) {
      mostrarMensaje("Todos los campos son obligatorios.");
      return;
    }

    if (!validarCorreo(correo)) {
      mostrarMensaje("Formato de correo inválido.");
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

    print("📢 Intentando registrar usuario en Firebase...");
    
    // Agrega print antes y después de llamar a Firebase
    print("⏳ Enviando solicitud a Firebase...");
    String? resultado = await ServiciosAuth().registrarUsuario(correo, passw, nombre);
    print("🔥 Respuesta de Firebase: $resultado");

    if (resultado == null) {
      print("✅ Usuario registrado exitosamente.");
      mostrarMensaje("Cuenta creada exitosamente!", esExito: true);

      // Retraso breve antes de la navegación
      Future.delayed(const Duration(seconds: 2), () {
        print("🔄 Navegando a pantalla de login...");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      });

    } else {
      print("❌ Error al registrar usuario: $resultado");
      mostrarMensaje(resultado);
    }
  }

  void verificarConexionFirestore() async {
    try {
      FirebaseFirestore.instance.settings =  const firestore.Settings(
        persistenceEnabled: false,
      );

      print("🔄 Verificando conexión con Firestore...");
      await FirebaseFirestore.instance.collection("TestConexion").doc("check").set({
        "status": "online",
        "timestamp": FieldValue.serverTimestamp(),
      });

      print("✅ Conexión exitosa con Firestore.");
    } catch (e) {
      print("❌ No hay conexión con Firestore: $e");
    }
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
      appBar: const CustomAppBar(title: "Crear Cuenta"),
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
                    accionBoton: validarYCrearCuenta, // Llama al método de validación
                  ),
                  const SizedBox(height: 15),
                  Botones(
                    textBoton: "Volver",
                     accionBoton: probarEscrituraFirestore,
                    //() {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => Index()),
                    //   );
                    // },
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
