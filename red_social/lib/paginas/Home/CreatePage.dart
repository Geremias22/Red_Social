import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Publicación"),
      ),
      body: const Center(
        child: Text("Pantalla para crear una nueva publicación."),
      ),
    );
  }
}
