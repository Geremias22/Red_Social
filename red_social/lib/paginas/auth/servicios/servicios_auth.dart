import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServiciosAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtener usuario actual
  String? getUsuarioActual() {
    User? usuario = _auth.currentUser;
    if (usuario != null) {
      print("🔹 Usuario autenticado: ${usuario.uid}");  // Verifica en consola si el UID se obtiene bien
      return usuario.uid;  // Devuelve solo el UID del usuario
    } else {
      print("⚠️ No hay usuario autenticado.");
      return null;
    }
  }

  // Cerrar sesión
  Future<void> cerrarSesion() async {
    await _auth.signOut();
  }

  // Iniciar sesión con correo y contraseña
  Future<String?> iniciarSesion(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print("Login fet");
      return null; // Si todo sale bien, devuelve null
    } on FirebaseAuthException catch (e) {
      return "Error: ${e.message}";
    }
  }

  // Registrar usuario con email y contraseña
  Future<String?> registrarUsuario(String email, String password, String nombre) async {
    try {
      print("🔥 Intentando crear usuario con Firebase Auth...");
      UserCredential credencialUsuario = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("✅ Usuario creado con UID: ${credencialUsuario.user!.uid}");

      print("⏳ Guardando información del usuario en Firestore...");
      
      // Guardar datos del usuario en Firestore
      await _firestore.collection("Usuarios").doc(credencialUsuario.user!.uid).set({
        "uid": credencialUsuario.user!.uid,
        "nombre": nombre,
        "email": email,
        "fecha_creacion": FieldValue.serverTimestamp(),
      });

      print("✅ Usuario guardado en Firestore correctamente.");
      return null; // Si todo sale bien, devuelve null
    } on FirebaseAuthException catch (e) {
      print("❌ Error de FirebaseAuth: ${e.message}");
      return "Error de FirebaseAuth: ${e.message}";
    } on FirebaseException catch (e) {
      print("🔥 Error de Firestore: ${e.message}");
      return "Error de Firestore: ${e.message}";
    } catch (e) {
      print("⚠️ Error inesperado: $e");
      return "Error inesperado: $e";
    }
  }


Future<String?> obtenerNombreUsuario() async {
  try {
    DocumentSnapshot doc = 
        await _firestore.collection("Usuarios").doc(getUsuarioActual()).get();

    if (doc.exists) {
      return doc.get("nombre"); // Devuelve el campo "nombre"
    } else {
      return null; // El documento no existe
    }
  } catch (e) {
    print("Error al obtener el nombre: $e");
    return null;
  }
}

}
