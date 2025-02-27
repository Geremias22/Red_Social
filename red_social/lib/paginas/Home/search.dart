import 'package:flutter/material.dart';
import 'home.dart';
import 'profile.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> searchHistory = [];
  int _selectedIndex = 1; // Índice de "Buscar"
  final TextEditingController searchController = TextEditingController();

  void addToHistory(String search) {
    setState(() {
      if (!searchHistory.contains(search) && search.isNotEmpty) {
        searchHistory.insert(0, search);
        if (searchHistory.length > 5) {
          searchHistory.removeLast();
        }
      }
    });
    searchController.clear(); // Limpia el campo después de enviar
  }

  void clearHistory() {
    setState(() {
      searchHistory.clear();
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
            hintText: "Search...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.grey[200],
            filled: true,
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: IconButton(
              icon: const Icon(Icons.send, color: Colors.grey),
              onPressed: () => addToHistory(searchController.text),
            ),
          ),
          onSubmitted: (value) => addToHistory(value), // Permite enviar con Enter
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Historial de búsqueda",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: clearHistory,
                  child: const Text("Borrar historial", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              children: searchHistory.map((search) {
                return ListTile(
                  leading: const Icon(Icons.history, color: Colors.grey),
                  title: Text(search),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
