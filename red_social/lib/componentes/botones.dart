import 'package:flutter/material.dart';

class Botones extends StatefulWidget {
  final String textBoton;
  final Function() accionBoton;

  const Botones({super.key, required this.textBoton, required this.accionBoton});

  @override
  _BotonesState createState() => _BotonesState();
}

class _BotonesState extends State<Botones> {
  bool isHovering = false; // Para detectar si el mouse está encima

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true), // Activa hover
      onExit: (_) => setState(() => isHovering = false), // Desactiva hover
      child: InkWell(
        onTap: widget.accionBoton,
        borderRadius: BorderRadius.circular(20), // Hace la animación más fluida
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200), // Animación suave
          decoration: BoxDecoration(
            color: isHovering ? const Color.fromARGB(255, 255, 140, 0) : Color.fromARGB(255, 253, 147, 17), // Cambio de color
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 3), // Borde más visible
            boxShadow: [
              BoxShadow(
                color: isHovering ? Color.fromARGB(255, 255, 174, 74) : const Color.fromARGB(2255, 253, 147, 17), // Sombra dinámica
                blurRadius: isHovering ? 15 : 8,
                spreadRadius: isHovering ? 5 : 2,
                offset: Offset(0, 5),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
          child: Text(
            widget.textBoton,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
          ),
        ),
      ),
    );
  }
}
