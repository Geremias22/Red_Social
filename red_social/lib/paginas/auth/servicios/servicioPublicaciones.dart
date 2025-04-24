import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ServicioPublicaciones {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? getUsuarioActual() {
    return _auth.currentUser?.uid;
  }

  // 🔥 Subir imagen a Firebase Storage
  Future<String> subirImagen(File imagen) async {
    String uid = getUsuarioActual()!;
    String nombreArchivo = "${DateTime.now().millisecondsSinceEpoch}.jpg";

    Reference ref = FirebaseStorage.instance
        .ref()
        .child("posts")
        .child(uid)
        .child(nombreArchivo);

    UploadTask uploadTask = ref.putFile(imagen);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  // 🔥 Crear una publicación con imagen y descripción
  Future<String?> crearPublicacion(String descripcion, String imagenUrl) async {
    try {
      String? uid = getUsuarioActual();
      if (uid == null) return "No hay usuario autenticado";

      DocumentSnapshot userDoc = await _firestore.collection("Usuarios").doc(uid).get();
      if (!userDoc.exists) return "Usuario no encontrado";

      String nombreUsuario = userDoc.get("nombre");
      String imagenPerfil = userDoc.get("profilePic") ?? "";
      bool verificado = userDoc.get("verificado") ?? false;

      await _firestore.collection("Publicaciones").add({
        "usuario": nombreUsuario,
        "uid": uid,
        "verificado": verificado,
        "imagenPerfil": imagenPerfil,
        "imagenPost": imagenUrl,
        "descripcion": descripcion,
        "likes": 0,
        "comentarios": 0,
        "compartidos": 0,
        "fecha": FieldValue.serverTimestamp(),
      });

      return null;
    } catch (e) {
      print("❌ Error al crear publicación: $e");
      return "Error al crear la publicación";
    }
  }

  Stream<QuerySnapshot> obtenerPublicaciones() {
    return _firestore
        .collection("Publicaciones")
        .orderBy("fecha", descending: true)
        .snapshots();
  }

  Future<void> darLike(String postId, int likesActuales) async {
    try {
      await _firestore.collection("Publicaciones").doc(postId).update({
        "likes": likesActuales + 1,
      });
    } catch (e) {
      print("❌ Error al dar like: $e");
    }
  }

  Future<void> agregarComentario(String postId, String comentario) async {
    try {
      String? uid = getUsuarioActual();
      if (uid == null) return;

      DocumentSnapshot userDoc = await _firestore.collection("Usuarios").doc(uid).get();
      if (!userDoc.exists) return;

      String nombreUsuario = userDoc.get("nombre");
      String imagenPerfil = userDoc.get("profilePic") ?? "";

      await _firestore.collection("Publicaciones").doc(postId).collection("Comentarios").add({
        "usuario": nombreUsuario,
        "uid": uid,
        "comentario": comentario,
        "imagenPerfil": imagenPerfil,
        "fecha": FieldValue.serverTimestamp(),
      });

      await _firestore.collection("Publicaciones").doc(postId).update({
        "comentarios": FieldValue.increment(1),
      });
    } catch (e) {
      print("❌ Error al agregar comentario: $e");
    }
  }

  Stream<QuerySnapshot> obtenerComentarios(String postId) {
    return _firestore
        .collection("Publicaciones")
        .doc(postId)
        .collection("Comentarios")
        .orderBy("fecha", descending: true)
        .snapshots();
  }

  Future<void> eliminarPublicacion(String postId) async {
    try {
      await _firestore.collection("Publicaciones").doc(postId).delete();
    } catch (e) {
      print("❌ Error al eliminar publicación: $e");
    }
  }
}
