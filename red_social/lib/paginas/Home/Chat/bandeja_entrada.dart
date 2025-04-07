import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:red_social/paginas/Home/Chat/chat.dart'; // Ajusta si el path es distinto

class BandejaEntrada extends StatelessWidget {
  const BandejaEntrada({super.key});

  @override
  Widget build(BuildContext context) {
    final String? uidActual = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mensajes"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Usuarios").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Text("Error al cargar usuarios.");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final usuarios = snapshot.data!.docs;

          return ListView.builder(
            itemCount: usuarios.length,
            itemBuilder: (context, index) {
              final datosUsuario = usuarios[index].data() as Map<String, dynamic>;

              // Ignorar usuario actual
              if (datosUsuario["uid"] == uidActual) {
                return const SizedBox.shrink();
              }

              final String nombreReceptor = datosUsuario["nombre"] ?? "Sin nombre";
              final String idReceptor = datosUsuario["uid"];

              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(nombreReceptor),
                subtitle: Text(datosUsuario["email"]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chat(
                        idReceptor: idReceptor,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
