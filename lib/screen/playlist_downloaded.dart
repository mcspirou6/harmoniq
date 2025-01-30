import 'package:flutter/material.dart';
import '../components/custom_bottom_navigation_bar.dart';
import '../components/playlist_item_carre.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  int _currentIndex = 2; // Onglet Library sélectionné

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      // Ajouter ici la navigation si nécessaire
    });
  }
  void _goBackToLibrary() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, // Couleur de fond de l'AppBar
        leading: GestureDetector(
          onTap: _goBackToLibrary, // Revenir à la page Library en cliquant sur le titre
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: _goBackToLibrary, // Revenir à la page Library
              ),
              const Text(
                'Downloaded',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Ajouter la logique de recherche ici si nécessaire
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barre de recherche
          Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Find in Playlists",
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),

          // Liste des Playlists
          Expanded(
            child: ListView(
              children: const [
                // Composant pour une playlist "New Playlist"
                PlaylistItemCarre(
                  imagePath: "assets/images/gray_square.png",
                  title: "New Playlist....",
                  subtitle: "",
                ),
                Divider(color: Colors.grey),

                // Composant pour une playlist existante
                PlaylistItemCarre(
                  imagePath: "assets/images/music_icon.png",
                  title: "Untitled Playlist",
                  subtitle: "",
                ),
                Divider(color: Colors.grey),
              ],
            ),
          ),
        ],
      ),

      // Barre de navigation personnalisée
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
