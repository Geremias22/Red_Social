import 'package:flutter/material.dart';
import 'package:red_social/componentes/bottom_nav.dart';
import 'package:red_social/paginas/Home/Chat/chat.dart';


class BandejaEntrada extends StatefulWidget {
  const BandejaEntrada({super.key});

  @override
  State<BandejaEntrada> createState() => _BandejaEntradaState();
}

class _BandejaEntradaState extends State<BandejaEntrada> {
  final List<String> usuarios = [
    "Juan Pérez",
    "Ana López",
    "Carlos Ruiz",
    "María Gómez",
    "David Fernández",
    "Laura Sánchez",
    "Pedro Martínez"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mensajes'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          return _buildMessageItem(usuarios[index]);
        },
      ),
      
    );
  }

  Widget _buildMessageItem(String userName) {
    return InkWell(
      onTap: () {
        // Navegar a la pantalla de chat
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Chat(userName: userName),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue.shade200,
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Último mensaje...',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
