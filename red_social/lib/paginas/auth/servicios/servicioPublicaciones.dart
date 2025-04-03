import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServicioPublicaciones {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔹 Obtener el UID del usuario actual
  String? getUsuarioActual() {
    return _auth.currentUser?.uid;
  }

  // 🔥 Crear una publicación
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

  // 📥 Obtener todas las publicaciones (ordenadas por fecha)
  Stream<QuerySnapshot> obtenerPublicaciones() {
    return _firestore.collection("Publicaciones")
      .orderBy("fecha", descending: true)
      .snapshots();
  }

  // 👍 Dar like a una publicación
  Future<void> darLike(String postId, int likesActuales) async {
    try {
      await _firestore.collection("Publicaciones").doc(postId).update({
        "likes": likesActuales + 1,
      });
    } catch (e) {
      print("❌ Error al dar like: $e");
    }
  }

  // 💬 Agregar comentario a una publicación
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

      // Actualizar contador de comentarios
      await _firestore.collection("Publicaciones").doc(postId).update({
        "comentarios": FieldValue.increment(1),
      });
    } catch (e) {
      print("❌ Error al agregar comentario: $e");
    }
  }

  // 📥 Obtener comentarios de una publicación
  Stream<QuerySnapshot> obtenerComentarios(String postId) {
    return _firestore.collection("Publicaciones")
      .doc(postId)
      .collection("Comentarios")
      .orderBy("fecha", descending: true)
      .snapshots();
  }

  // 🗑 Eliminar una publicación
  Future<void> eliminarPublicacion(String postId) async {
    try {
      await _firestore.collection("Publicaciones").doc(postId).delete();
    } catch (e) {
      print("❌ Error al eliminar publicación: $e");
    }
  }

    void crearPublicacionDemo() {
      FirebaseFirestore.instance.collection('Publicaciones').add({
        "usuario": "lucas",
        "uid": "DNIiP5vK0AecyNidYr3tuGlR3R82",
        "email": "lucasquintana@ceroca.cat",
        "verificado": false,
        "imagenPerfil": "img/imgPerfil.jpg",
        "imagenPost": "img/demoPost.jpg",
        "descripcion": "Disfrutando un hermoso atardecer 🌅",
        "likes": 120,
        "comentarios": 30,
        "compartidos": 50,
        "fecha_creacion": FieldValue.serverTimestamp(),
      }).then((_) {
        print("✅ Publicación creada con éxito.");
      }).catchError((error) {
        print("❌ Error al crear publicación: $error");
      });
    }


}
