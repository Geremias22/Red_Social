import 'package:flutter/material.dart';
import 'package:red_social/paginas/Home/Chat/bandeja_entrada.dart';
import 'package:red_social/paginas/Home/CreatePage.dart';
import 'package:red_social/paginas/Home/cam.dart';
import 'package:red_social/paginas/Home/profile.dart';
import 'package:red_social/paginas/Home/search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Lista de historias simuladas con imágenes en la carpeta correcta
  final List<Map<String, String>> _historias = [
    {"usuario": "Tu historia", "imagen": "img/imgPerfil.jpg"},
    {"usuario": "soufaya_", "imagen": "img/imgPerfil.jpg"},
    {"usuario": "lauranavarro00", "imagen": "img/imgPerfil.jpg"},
    {"usuario": "_mariapeina", "imagen": "img/imgPerfil.jpg"},
  ];

  // Lista de publicaciones simuladas con imágenes en la carpeta correcta
  final List<Map<String, dynamic>> _publicaciones = [
    {
      "usuario": "ayitsphotography",
      "verificado": true,
      "imagenPerfil": "img/imgPerfil.jpg",
      "imagenPost": "img/imgPublicacion.jpg",
      "descripcion": "Late nights in Gotham",
      "likes": 490,
      "comentarios": 67,
      "compartidos": 1165,
    },
    {
      "usuario": "travelblogger",
      "verificado": false,
      "imagenPerfil": "img/imgPerfil.jpg",
      "imagenPost": "img/imgPublicacion.jpg",
      "descripcion": "Sunset in Bali 🌅",
      "likes": 100,
      "comentarios": 120,
      "compartidos": 890,
    },
    {
      "usuario": "adventurer",
      "verificado": false,
      "imagenPerfil": "img/imgPerfil.jpg",
      "imagenPost": "img/prueba1.jpg",
      "descripcion": "Exploring the mountains 🏔️",
      "likes": 300,
      "comentarios": 220,
      "compartidos": 1500,
    },
    {
      "usuario": "Prueba1",
      "verificado": true,
      "imagenPerfil": "img/imgPerfil.jpg",
      "imagenPost": "img/burguerPost.jpg",
      "descripcion": "Post de preeba",
      "likes": 500,
      "comentarios": 220,
      "compartidos": 1500,
    },
  ];

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
        centerTitle: false,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0,
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.favorite_border, color: Colors.white),
          //   onPressed: () {
          //     // Acción para ver notificaciones o interacciones
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BandejaEntrada()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Sección de Historias
          SizedBox(
            height: 97, // Ajustado para evitar overflow
            child: Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _historias.length,
                itemBuilder: (context, index) {
                  final historia = _historias[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.purpleAccent, width: 3),
                                image: DecorationImage(
                                  image: AssetImage(historia["imagen"] ?? "img/placeholder.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (index == 0)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                  ),
                                  child: const Icon(Icons.add, size: 15, color: Colors.white),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          historia["usuario"]!,
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          const Divider(color: Colors.white24),
          // Lista de Publicaciones
          Expanded(
            child: Center(
              child: ListView.builder(
                itemCount: _publicaciones.length,
                itemBuilder: (context, index) {
                  final post = _publicaciones[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: _buildPost(post),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

 // Widget para cada publicación
  Widget _buildPost(Map<String, dynamic> post) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600, // Máximo ancho del post (ajustable)
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9, // Ocupará el 90% hasta `maxWidth`
          margin: const EdgeInsets.symmetric(vertical: 10), // Espaciado entre publicaciones
          decoration: BoxDecoration(
            color: Colors.black, // Fondo negro para mantener el diseño
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info del usuario
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(post["imagenPerfil"]),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      post["usuario"],
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    if (post["verificado"])
                      const Icon(Icons.verified, color: Colors.blue, size: 16),
                    const Spacer(),
                    const Icon(Icons.more_vert, color: Colors.white),
                  ],
                ),
              ),
              // Imagen del post con límites
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1500, // Máximo ancho de la imagen (ajustable)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados para la imagen
                  child: Image.asset(
                    post["imagenPost"]!,
                    fit: BoxFit.contain, // Ajuste para que no se estire
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset("assets/img/placeholder.jpg", fit: BoxFit.cover);
                    },
                  ),
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
                    Text("${post["likes"]} mil", style: const TextStyle(color: Colors.white)),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.comment, color: Colors.white),
                      onPressed: () {},
                    ),
                    Text("${post["comentarios"]}", style: const TextStyle(color: Colors.white)),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () {},
                    ),
                    Text("${post["compartidos"]}", style: const TextStyle(color: Colors.white)),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.bookmark_border, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              // Descripción
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  post["descripcion"],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }


}
