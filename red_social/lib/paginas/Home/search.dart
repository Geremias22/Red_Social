import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:red_social/componentes/Template_profile.dart';
import 'profile.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Map<String, dynamic>> searchResults = [];
  final TextEditingController searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para buscar usuarios en Firestore por nombre
  void searchUsers(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults.clear();
      });
      return;
    }

    QuerySnapshot users = await _firestore
        .collection("Usuarios")
        .where("nombre", isGreaterThanOrEqualTo: query)
        .where("nombre", isLessThan: query + 'z')
        .get();

    setState(() {
      searchResults = users.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: "Buscar usuario...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.grey[200],
            filled: true,
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, color: Colors.grey),
              onPressed: () {
                searchController.clear();
                setState(() {
                  searchResults.clear();
                });
              },
            ),
          ),
          onChanged: searchUsers, // Llama al método al escribir
        ),
      ),
      body: searchResults.isEmpty
          ? Center(
              child: Text("No se encontraron usuarios"),
            )
          : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final user = searchResults[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(user['nombre'][0].toUpperCase()),
                  ),
                  title: Text(user['nombre']),
                  subtitle: Text(user['email']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TemplateProfile(userId: user['uid']),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
