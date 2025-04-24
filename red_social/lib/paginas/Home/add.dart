import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:red_social/paginas/auth/servicios/servicioPublicaciones.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  File? _imageFile;
  final TextEditingController _descripcionController = TextEditingController();
  final ServicioPublicaciones _servicioPublicaciones = ServicioPublicaciones();
  bool _cargando = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _publicar() async {
    if (_imageFile == null || _descripcionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecciona una imagen y escribe una descripción")),
      );
      return;
    }

    setState(() {
      _cargando = true;
    });

    try {
      // Subir imagen a Firebase Storage
      String urlImagen = await _servicioPublicaciones.subirImagen(_imageFile!);

      // Crear publicación en Firestore
      String? error = await _servicioPublicaciones.crearPublicacion(
        _descripcionController.text.trim(),
        urlImagen,
      );

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("❌ $error")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Publicación creada exitosamente")),
        );

        setState(() {
          _imageFile = null;
          _descripcionController.clear();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error: $e")),
      );
    } finally {
      setState(() {
        _cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crear Publicación")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _imageFile != null
                ? Image.file(_imageFile!, height: 250)
                : Container(
                    height: 250,
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: const Text("No hay imagen seleccionada"),
                  ),
            const SizedBox(height: 16),
            TextField(
              controller: _descripcionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Descripción",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text("Seleccionar Imagen"),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _cargando ? null : _publicar,
              icon: const Icon(Icons.upload),
              label: _cargando
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Text("Publicar"),
            ),
          ],
        ),
      ),
    );
  }
}
