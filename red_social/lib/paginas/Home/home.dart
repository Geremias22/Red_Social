import 'package:flutter/material.dart';
import 'package:red_social/componentes/bottom_nav.dart';
import 'package:red_social/paginas/Home/Chat/bandeja_entrada.dart';
import 'package:red_social/paginas/Home/cam.dart'; // Importamos el BottomNav

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0; // Controla la pestaña actual

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Aquí puedes manejar la navegación entre pantallas
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco base
      appBar: AppBar(
        title: const Text("Historias"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.camera_alt, color: Colors.red),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Cam()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.message, color: Colors.green),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BandejaEntrada()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Fondo con líneas diagonales (simulación)
          Container(
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              image: const DecorationImage(
                image: AssetImage('assets/diagonal_lines.png'), // Imagen con líneas diagonales
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Caja blanca en el centro
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  "Publicaciones vacías",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 0),
    );
  }
}
