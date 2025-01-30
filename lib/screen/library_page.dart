import 'package:flutter/material.dart';
import '../components/library_item.dart';
import '../components/recently_added.dart';
import '../components/custom_bottom_navigation_bar.dart';
import '../screen/playlist_page.dart';
import '../screen/artists_page.dart';
import '../screen/downloaded_page.dart';
import '../screen/music_library_page.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  int _currentIndex = 1;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Text(
              "Edit",
              style: TextStyle(color: Colors.redAccent, fontSize: 16),
            ),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Library",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            // Library Items
            LibraryItem(icon: Icons.playlist_play, title: "Playlists", destinationPage: PlaylistPage()),
            LibraryItem(icon: Icons.mic, title: "Artists", destinationPage: ArtistPage()),
            LibraryItem(icon: Icons.music_note, title: "Songs", destinationPage: MusicLibraryPage()),
            LibraryItem(icon: Icons.download, title: "Downloaded", destinationPage: DownloadedPage()),

            Divider(color: Colors.grey, height: 32),

            // Recently Added Section
            RecentlyAdded(
              imagePath: "assets/images/album_cover.jpg", // Ajoute ton image
              title: "Unknown Album",
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
      ),
    );
  }
}
