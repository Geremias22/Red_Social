import 'package:flutter/material.dart';
import 'package:red_social/componentes/bottom_nav.dart';

class BandejaEntrada extends StatefulWidget {
  const BandejaEntrada({super.key});

  @override
  State<BandejaEntrada> createState() => _BandejaEntradaState();
}

class _BandejaEntradaState extends State<BandejaEntrada> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mensajes'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 7, // Número de mensajes
        itemBuilder: (context, index) {
          return _buildMessageItem();
        },
      ),
      
    );
  }

  Widget _buildMessageItem() {
    return Padding(
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
              children: const [
                Text(
                  'Nombre Usuario',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Último mensaje...',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
