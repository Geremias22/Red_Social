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
    return await _auth.signOut();
  }

  // Iniciar sesión con correo y contraseña
  Future<String?> iniciarSesion(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return "Error: ${e.message}";
    }
  }

  // Registrar usuario con email y contraseña
  Future<String?> registrarUsuario(String email, String password, String nombre) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Guardar información adicional en Firestore
      await _firestore.collection("Usuarios").doc(credential.user!.uid).set({
        "uid": credential.user!.uid,
        "nombre": nombre,
        "email": email,
        "sexo": null,
        "fecha_nacimiento": null,
        "img_perfil": null,
        "region": null,
        "ciudad": null,
        "fecha_creacion": FieldValue.serverTimestamp(),
        "fecha_modificacion": FieldValue.serverTimestamp(),
      });

      return null;
    } on FirebaseAuthException catch (e) {
      return "Error: ${e.message}";
    }
  }
}
