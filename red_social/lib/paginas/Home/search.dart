import 'package:flutter/material.dart';
import 'home.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> searchHistory = [];
  int _selectedIndex = 1;

  void addToHistory(String search) {
    setState(() {
      if (!searchHistory.contains(search) && search.isNotEmpty) {
        searchHistory.insert(0, search);
        if (searchHistory.length > 5) {
          searchHistory.removeLast();
        }
      }
    });
  }

  void clearHistory() {
    setState(() {
      searchHistory.clear();
    });
  }

  void _onItemTapped(int index) {
    if (index == 0) { // Volver a Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            suffixIcon: IconButton(
              icon: Icon(Icons.send, color: Colors.grey),
              onPressed: () {
                addToHistory(searchController.text);
                searchController.clear();
              },
            ),
          ),
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
                Text(
                  "Historial de búsqueda",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: clearHistory,
                  child: Text("Borrar historial", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              children: searchHistory.map((search) {
                return ListTile(
                  leading: Icon(Icons.history, color: Colors.grey),
                  title: Text(search),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}
