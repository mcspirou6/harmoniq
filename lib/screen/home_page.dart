import 'package:flutter/material.dart';
import '../components/artist_card.dart';
import '../components/playlist_item.dart';
import '../components/music_card.dart';
import '../components/category_card.dart';
import '../components/playlist_card.dart';
import '../components/custom_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> artists = [
      {'image': 'assets/artist1.jpg', 'name': 'Artist 1', 'genre': 'Pop'},
      {'image': 'assets/artist2.jpg', 'name': 'Artist 2', 'genre': 'Rock'},
      {'image': 'assets/artist3.jpg', 'name': 'Artist 3', 'genre': 'Jazz'},
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            filled: true,
            fillColor: Colors.grey[200],
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.black),
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/profile.jpg'),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Catégories
              const Text(
                'Catégories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    6,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: CategoryCard(
                        title: 'Catégorie $index',
                        backgroundColor:
                            Colors.primaries[index % Colors.primaries.length],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Section Playlists récentes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Playlists récentes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  PlaylistItem(
                      title: 'Le premier',
                      subtitle: 'Mon favori',
                      imagePath: 'assets/melody.jpg'),
                  PlaylistItem(
                      title: 'Le second',
                      subtitle: 'Mon autre favori',
                      imagePath: 'assets/melody.jpg'),
                ],
              ),
              const SizedBox(height: 25),

              // Section Albums populaires
              const Text(
                'Albums populaires',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: PlaylistCard(
                        imagePath: 'assets/album.jpg',
                        albumTitle: 'Album $index',
                        artists: ['Artiste $index'],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Section Recommandations
              const Text(
                'Recommandations',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: MusicCard(
                        imagePath: 'assets/clip_card.jpg',
                        title: 'Titre $index',
                        artists: ['Artiste $index'],
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Section Nouveautés musicales
              const Text(
                'Nouveautés musicales',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: MusicCard(
                        imagePath: 'assets/clip_card.jpg',
                        title: 'Titre $index',
                        artists: ['Artiste $index'],
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Section Artistes à découvrir
              const Text(
                'Artistes à découvrir',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: artists
                      .map((artist) => Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: ArtistCard(
                              imagePath: artist['image'],
                              artistName: artist['name'],
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/artistDetail',
                                  arguments: {
                                    'artistName': artist['name'],
                                    'artistImage': artist['image'],
                                  },
                                );
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
      ),
    );
  }
}
