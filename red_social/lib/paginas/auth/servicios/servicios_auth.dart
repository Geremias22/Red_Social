import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServiciosAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtener usuario actual
  User? getUsuarioActual() {
    return _auth.currentUser;
  }

  // Cerrar sesión
  Future<void> cerrarSesion() async {
    await _auth.signOut();
  }

  // Iniciar sesión con correo y contraseña
  Future<String?> iniciarSesion(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
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
    
    // Prueba con una escritura con await y captura errores
    await _firestore.collection("Usuarios").doc(credencialUsuario.user!.uid).set({
      "uid": credencialUsuario.user!.uid,
      "nombre": nombre,
      "email": email,
      "fecha_creacion": FieldValue.serverTimestamp(),
    }).then((_) {
      print("✅ Usuario guardado en Firestore correctamente.");
    }).catchError((error) {
      print("❌ Error al guardar usuario en Firestore: $error");
    });

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


}
