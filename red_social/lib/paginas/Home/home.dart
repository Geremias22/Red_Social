import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:red_social/componentes/ComentariosScreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 35,
        automaticallyImplyLeading: false,
        title: const Text(
          "Para ti",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _firestore.collection('Publicaciones').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No hay publicaciones aún.", style: TextStyle(color: Colors.white)),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var post = snapshot.data!.docs[index];
              return _buildPost(post);
            },
          );
        },
      ),
    );
  }

  Widget _buildPost(DocumentSnapshot post) {
    var data = post.data() as Map<String, dynamic>;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info del usuario
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(data["imagenPerfil"] ?? ""),
              ),
              const SizedBox(width: 10),
              Text(
                data["usuario"] ?? "Usuario",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const Icon(Icons.more_vert, color: Colors.white),
            ],
          ),

          // Imagen del post
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              data["imagenPost"] ?? "",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset("assets/img/placeholder.jpg", fit: BoxFit.cover);
              },
            ),
          ),

          // Acciones de la publicación
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.white),
                  onPressed: () {},
                ),
                Text("${data["likes"] ?? 0}", style: const TextStyle(color: Colors.white)),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.comment, color: Colors.white),
                  onPressed: () {
                    // Navegar a la pantalla de comentarios
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComentariosScreen(postId: post.id),
                      ),
                    );
                  },
                ),
                Text("${data["comentarios"] ?? 0}", style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
