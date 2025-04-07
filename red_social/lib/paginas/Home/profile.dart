import 'package:flutter/material.dart';
import 'package:red_social/paginas/Configuracion/settings.dart';
import 'package:red_social/paginas/Home/CreatePage.dart';
import 'package:red_social/paginas/auth/servicios/servicios_auth.dart';

import 'home.dart';
import 'search.dart';

class Profile extends StatefulWidget {
  final String? userId;
  

  const Profile({super.key, this.userId});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? userId;
  String? nomUsuari;
  final ServiciosAuth _authService = ServiciosAuth();

  @override
  void initState() {
    super.initState();
    userId = widget.userId ?? _authService.getUsuarioActualUID(); // Si es null, obtén el actual
    //nomUsuari = (widget.userId ?? ServiciosAuth().obtenerNombreUsuario()) as String?;
    _cargarNombreUsuario();
    print("🔹 userId en Profile: $userId"); // Verifica en consola
  }

  Future<void> _cargarNombreUsuario() async {
    String? nombre = await ServiciosAuth().obtenerNombreUsuario();
    if (nombre != null) {
      setState(() {
        nomUsuari = nombre;
      });
    } else {
      setState(() {
        nomUsuari = "No encontrado";
      });
    }
  }

  void _showBottomSheet(String title) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 300,
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text("Usuario $index"),
                      subtitle: const Text("Descripción corta"),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Seguir"),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "${nomUsuari ?? 'Desconocido'}",  // Si es null, muestra 'Desconocido'
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "0", 
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), 
                              ),
                              GestureDetector(
                                onTap: () => _showBottomSheet("Publicaciones"),
                                child: const Text("Publicaciones", style: TextStyle(color: Colors.blue)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "0", 
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), 
                              ),
                              GestureDetector(
                                onTap: () => _showBottomSheet("Seguidores"),
                                child: const Text("Seguidores", style: TextStyle(color: Colors.blue)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "0", 
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), 
                              ),
                              GestureDetector(
                                onTap: () => _showBottomSheet("Seguidos"),
                                child: const Text("Seguidos", style: TextStyle(color: Colors.blue)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Read More >",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.add, size: 40, color: Colors.grey)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
