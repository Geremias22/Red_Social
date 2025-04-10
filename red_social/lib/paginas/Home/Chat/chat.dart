import 'package:flutter/material.dart';
import 'package:red_social/paginas/auth/servicios/servicio_chat.dart';
import 'package:red_social/paginas/auth/servicios/servicios_auth.dart';
import 'package:red_social/componentes/burbujaMSG.dart';

class Chat extends StatefulWidget {
  final String idReceptor;
  const Chat({super.key, required this.idReceptor});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      Future.delayed(const Duration(milliseconds: 500), () {
        hacerScrollAbajo();
      });
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      hacerScrollAbajo();
    });
  }

  void hacerScrollAbajo() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  void enviarMensaje() {
    if (_controller.text.trim().isNotEmpty) {
      ServicioChat().enviarMensaje(widget.idReceptor, _controller.text.trim());
      _controller.clear();
      FocusScope.of(context).requestFocus(_focusNode);
      Future.delayed(const Duration(milliseconds: 50), () {
        hacerScrollAbajo();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final idActual = ServiciosAuth().getUsuarioActualUID();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: Colors.blue[200],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: ServicioChat().getMensajes(idActual!, widget.idReceptor),
              builder: (context, snapshot) {
                if (snapshot.hasError) return const Text("Error cargando mensajes.");
                if (!snapshot.hasData) return const Text("Cargando...");

                return ListView(
                  controller: _scrollController,
                  children: snapshot.data!.docs.map((doc) {
                    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                    return Burbujamsg(
                      mensaje: data['mensaje'],
                      idAutor: data['idAutor'],
                      timestamp: TimeOfDay.fromDateTime(data['timestamp'].toDate()),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  onSubmitted: (_) => enviarMensaje(),
                  decoration: const InputDecoration(
                    hintText: "Escribe tu mensaje...",
                    filled: true,
                    fillColor: Color.fromARGB(255, 200, 235, 255),
                  ),
                ),
              ),
              IconButton(
                onPressed: enviarMensaje,
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
