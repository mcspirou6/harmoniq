import 'package:flutter/material.dart';
import '../components/music_card.dart';
import '../components/playlist_card.dart';
import '../screen/listen_musique_page.dart';
import '../services/jamendo_service.dart';
import '../models/track.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArtistDetailPage extends StatefulWidget {
  final String artistName;
  final String artistImage;

  const ArtistDetailPage({
    super.key,
    required this.artistName,
    required this.artistImage,
  });

  @override
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  bool _isFollowing = false;
  final ScrollController _scrollController = ScrollController();
  double _opacity = 0;
  final JamendoService _jamendoService = JamendoService();
  List<Track> _artistTracks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadArtistTracks();
  }

  void _onScroll() {
    final double offset = _scrollController.offset;
    setState(() {
      _opacity = (offset > 200) ? 1.0 : offset / 200;
    });
  }

  Future<void> _loadArtistTracks() async {
    try {
      final tracksJson = await _jamendoService.searchTracks(widget.artistName);
      final tracks = tracksJson.map((json) => Track.fromJson(json)).toList();

      setState(() {
        _artistTracks = tracks;
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: CachedNetworkImage(
                    imageUrl: widget.artistImage,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                backgroundColor: Colors.black.withAlpha((_opacity * 255).toInt()),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.artistName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '10M auditeurs mensuels',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _isFollowing = !_isFollowing;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isFollowing ? Colors.grey[800] : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  _isFollowing ? 'Suivi' : 'Suivre',
                                  style: TextStyle(
                                    color: _isFollowing ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              IconButton(
                                icon: const Icon(Icons.shuffle, color: Colors.white),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _buildSection('Populaire'),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: MusicCard(
                              imagePath: 'assets/song${index + 1}.jpg',
                              title: 'Chanson ${index + 1}',
                              artists: [widget.artistName],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListenMusiquePage(
                                      title: 'Chanson ${index + 1}',
                                      artist: widget.artistName,
                                      imagePath: 'assets/song${index + 1}.jpg',
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    _buildSection('Albums'),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: PlaylistCard(
                              imagePath: 'assets/album${index + 1}.jpg',
                              albumTitle: 'Album ${index + 1}',
                              artists: [widget.artistName],
                            ),
                          );
                        },
                      ),
                    ),
                    _buildSection('Singles'),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: MusicCard(
                              imagePath: 'assets/single${index + 1}.jpg',
                              title: 'Single ${index + 1}',
                              artists: [widget.artistName],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListenMusiquePage(
                                      title: 'Single ${index + 1}',
                                      artist: widget.artistName,
                                      imagePath: 'assets/single${index + 1}.jpg',
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    _buildSection('Titres populaires'),
                    _isLoading
                        ? const SliverFillRemaining(
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final track = _artistTracks[index];
                                return ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: CachedNetworkImage(
                                      imageUrl: track.imageUrl,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  title: Text(
                                    track.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    track.albumName,
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
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
                                );
                              },
                              childCount: _artistTracks.length,
                            ),
                          ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Voir tout',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
