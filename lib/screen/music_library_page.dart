import 'package:flutter/material.dart';
import '../components/music_card.dart';
import '../components/custom_bottom_navigation_bar.dart';

class MusicLibraryPage extends StatefulWidget {
  const MusicLibraryPage({super.key});

  @override
  State<MusicLibraryPage> createState() => _MusicLibraryPageState();
}

class _MusicLibraryPageState extends State<MusicLibraryPage> {
  int _currentIndex = 0;

  // Gestion des changements d'onglets
  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
      // Redirige vers la page d'accueil
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
      // Redirige vers la page Playlist
        Navigator.pushNamed(context, '/library');
        break;
      case 2:
      // Redirige vers la page Paramètres
        Navigator.pushNamed(context, '/settings');
        break;
      case 3:
      // Redirige vers la page Profil
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }
  void _goBackToLibrary() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> suggestedMusic = [
      {'image': 'assets/music1.jpg', 'title': 'Song 1', 'artists': 'Artist A'},
      {'image': 'assets/music2.jpg', 'title': 'Song 2', 'artists': 'Artist B'},
      {'image': 'assets/music3.jpg', 'title': 'Song 3', 'artists': 'Artist C'},
      {'image': 'assets/music4.jpg', 'title': 'Song 4', 'artists': 'Artist D'},
    ];

    final List<Map<String, String>> songList = List.generate(
      10,
          (index) => {'title': 'Name', 'artist': 'Artist Name'},
    );

    return Scaffold(
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
                'Library',
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
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section de Suggestions (Liste horizontale)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Suggestions',
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 160, // Hauteur pour les cartes horizontales
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: suggestedMusic.length,
              itemBuilder: (context, index) {
                final music = suggestedMusic[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: MusicCard(
                    imagePath: music['image']!,
                    title: music['title']!,
                    artists: [music['artists']!],
                    onTap: () {
                      // Navigation ou action sur clic
                    },
                  ),
                );
              },
            ),
          ),

          // Section Boutons Play et Shuffle
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow, color: Colors.black),
                label: const Text('Play'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.shuffle, color: Colors.black),
                label: const Text('Shuffle'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Section Liste Verticale des Musiques
          Expanded(
            child: ListView.builder(
              itemCount: songList.length,
              itemBuilder: (context, index) {
                final song = songList[index];
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.music_note, color: Colors.black),
                  ),
                  title: Text(song['title']!, style: const TextStyle(color: Colors.black)),
                  subtitle: Text(song['artist']!, style: TextStyle(color: Colors.grey[400])),
                  trailing: const Icon(Icons.more_vert, color: Colors.black),
                  onTap: () {
                    // Action au clic
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
      ),
    );
  }
}

