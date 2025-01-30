import 'package:flutter/material.dart';
import '../components/artist_card.dart';
import '../components/music_card.dart';
import '../components/playlist_card.dart';
import '../components/custom_bottom_navigation_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  int _currentIndex = 1;

  final List<String> _categories = [
    'Playlists',
    'Artistes',
    'Albums',
    'Chansons',
    'Podcasts'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Rechercher musique, artiste, playlist...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            if (_searchQuery.isEmpty)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Parcourir tout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.primaries[index % Colors.primaries.length],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                _categories[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            else
              Expanded(
                child: ListView(
                  children: [
                    _buildSearchSection('Meilleurs résultats'),
                    _buildSearchSection('Chansons'),
                    _buildSearchSection('Artistes'),
                    _buildSearchSection('Playlists'),
                  ],
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildSearchSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 5,
            itemBuilder: (context, index) {
              if (title == 'Artistes') {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: ArtistCard(
                    imagePath: 'assets/artist1.jpg',
                    artistName: 'Artiste ${index + 1}',
                    onTap: () {
                      // TODO: Implement artist tap action
                    },
                  ),
                );
              } else if (title == 'Playlists') {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: PlaylistCard(
                    imagePath: 'assets/playlist1.jpg',
                    albumTitle: 'Playlist ${index + 1}',
                    artists: ['Artiste ${index + 1}'],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: MusicCard(
                    imagePath: 'assets/song1.jpg',
                    title: 'Chanson ${index + 1}',
                    artists: ['Artiste ${index + 1}'],
                    onTap: () {
                      // TODO: Implement song tap action
                    },
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
