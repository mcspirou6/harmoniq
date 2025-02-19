import 'package:flutter/material.dart';
import '../components/artist_card.dart';
import '../components/playlist_item.dart';
import '../components/music_card.dart';
import '../components/category_card.dart';
import '../components/playlist_card.dart';
import '../components/custom_bottom_navigation_bar.dart';
import '../services/jamendo_service.dart';
import '../models/track.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final JamendoService _jamendoService = JamendoService();
  List<Track> _popularTracks = [];
  List<Map<String, dynamic>> _popularArtists = [];
  List<Map<String, dynamic>> _genres = [];
  bool _isLoading = true;

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
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final tracksJson = await _jamendoService.getPopularTracks();
      final tracks = tracksJson.map((json) => Track.fromJson(json)).toList();
      
      final artists = await _jamendoService.getPopularArtists();
      final genres = await _jamendoService.getMusicTags();

      setState(() {
        _popularTracks = tracks;
        _popularArtists = artists;
        _genres = genres;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
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
                      const SizedBox(height: 25),

                      // Section Morceaux populaires
                      const Text(
                        'Morceaux Populaires',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _popularTracks.length,
                          itemBuilder: (context, index) {
                            final track = _popularTracks[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/listenMusiquePage',
                                  arguments: {
                                    'title': track.name,
                                    'artist': track.artistName,
                                    'imagePath': track.imageUrl,
                                    'audioUrl': track.audioUrl,
                                  },
                                );
                              },
                              child: Container(
                                width: 150,
                                margin: const EdgeInsets.only(right: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        imageUrl: track.imageUrl,
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      track.name,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      track.artistName,
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Section Artistes populaires
                      const Text(
                        'Artistes Populaires',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _popularArtists.length,
                          itemBuilder: (context, index) {
                            final artist = _popularArtists[index];
                            return GestureDetector(
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
                              child: Container(
                                width: 120,
                                margin: const EdgeInsets.only(right: 16),
                                child: Column(
                                  children: [
                                    ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: artist['image'] ?? '',
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.person),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      artist['name'] ?? '',
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Section Genres
                      const Text(
                        'Genres',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _genres.map((genre) {
                          return ActionChip(
                            label: Text(genre['name'] ?? ''),
                            onPressed: () {
                              // Navigation vers les morceaux du genre
                            },
                          );
                        }).toList(),
                                          ),
                    ],
                  ),
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