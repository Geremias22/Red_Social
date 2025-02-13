import 'package:flutter/material.dart';
import 'package:red_social/componentes/chatInput.dart';

class Chat extends StatefulWidget {
  final String userName;
  const Chat({super.key, required this.userName});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // Nodo de enfoque
  final List<String> _messages = []; // Lista de mensajes

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(_messageController.text);
      });
      _messageController.clear();

      // Mantener el input enfocado
      FocusScope.of(context).requestFocus(_focusNode);
    }
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Liberar memoria
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.userName)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // Muestra los mensajes nuevos en la parte inferior
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _messages[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Se usa el nuevo componente ChatInput
          ChatInput(
            controller: _messageController,
            focusNode: _focusNode,
            onSendMessage: _sendMessage,
          ),
        ],
      ),
    );
  }
}
