import 'package:flutter/material.dart';
import 'package:red_social/componentes/botones.dart';
import 'package:red_social/componentes/input_text.dart';
import 'package:red_social/paginas/Inicio/Index.dart';
import 'package:red_social/paginas/Inicio/login.dart';

class CrearCuenta extends StatefulWidget {
  
  const CrearCuenta({super.key});

  @override
  State<CrearCuenta> createState() => _CrearCuentaState();
}

class _CrearCuentaState extends State<CrearCuenta> {
  TextEditingController tecNom = TextEditingController();
  TextEditingController tecCorreo = TextEditingController();
  TextEditingController tecPassw = TextEditingController();
  TextEditingController tecRePassw = TextEditingController();
  final bool invert = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold( // Envolvemos todo en un Scaffold
      backgroundColor: Colors.black, // Establece el fondo negro
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            height: 700,
            width: 450,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 253, 147, 17),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Center(
                  child: Text(
                    "Crear cuenta",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          
              const SizedBox(height: 20),
          
              // Input Nombre
              InputText( textEtiqueta: "Introduce el nombre", textHint: "Introduce tu nombre..", tecInput: tecNom, invert: invert,),
          
              //Input Correo
              InputText(textEtiqueta: "Introduce el correo", textHint: "Introduce tu correo...", tecInput: tecCorreo, invert: invert ),
          
              //Input Contraseña
              InputText(textEtiqueta: "Introduce la contraseña", textHint: "Introduce tu contraseña...", tecInput: tecPassw, invert: invert ),
          
              //Input Repetir Contraseña
              InputText(textEtiqueta: "Repite la contraseña", textHint: "Repite tu contraseña...", tecInput: tecRePassw, invert: invert ),

              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                
                  //Boton para volver al Index (inicio)
                  Botones(
                    textBoton: "Volver", 
                    accionBoton:(){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Index()), 
                    );} 
                  ),
                
                  //Boton para volver al Index (inicio)
                  Botones(
                    textBoton: "Crear cuenta", 
                    accionBoton:(){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()), 
                    );} 
                  ),
                
                  ],
                ),
              )
              //Botones
              
              
            ],
          ),
          ),
        ), 
      ),
    );
  }
}