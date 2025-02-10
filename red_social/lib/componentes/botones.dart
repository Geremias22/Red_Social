import 'package:flutter/material.dart';

class Botones extends StatefulWidget {
  final String textBoton;
  final Function() accionBoton;

  const Botones({super.key, required this.textBoton, required this.accionBoton});

  @override
  _BotonesState createState() => _BotonesState();
}

class _BotonesState extends State<Botones> {
  bool isHovering = false; // Para detectar el hover

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true), // Activa hover
      onExit: (_) => setState(() => isHovering = false), // Desactiva hover
      child: InkWell(
        onTap: widget.accionBoton,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200), // Animación suave
          decoration: BoxDecoration(
            color: isHovering ? Colors.grey[300] : Colors.white, // Cambio de color al hacer hover
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 2), // Borde blanco
            boxShadow: [
              BoxShadow(
                color: isHovering ? Colors.white54 : Colors.grey[600]!, // Sombra dinámica
                blurRadius: isHovering ? 12 : 6,
                spreadRadius: isHovering ? 3 : 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Center(
            child: Text(
              widget.textBoton,
              style: TextStyle(
                color: Colors.black87, // Texto oscuro para contrastar con el botón blanco
                fontSize: isHovering ? 18 : 18,
                fontWeight: isHovering ? FontWeight.w900 : FontWeight.w500,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
