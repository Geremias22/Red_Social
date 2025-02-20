import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
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