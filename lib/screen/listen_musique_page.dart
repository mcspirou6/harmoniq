import 'package:flutter/material.dart';
import '../components/custom_bottom_navigation_bar.dart';

class ListenMusiquePage extends StatefulWidget {
  final String title;
  final String artist;
  final String imagePath;

  const ListenMusiquePage({
    super.key,
    required this.title,
    required this.artist,
    required this.imagePath,
  });

  @override
  ListenMusiquePageState createState() => ListenMusiquePageState();
}

class ListenMusiquePageState extends State<ListenMusiquePage> {
  int _currentIndex = 2; // Onglet Library sélectionné
  double _sliderValue = 0.5; // Valeur par défaut pour la barre de progression
  double _volumeValue = 0.5; // Valeur par défaut pour le volume
  bool _isMuted = false;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _updateVolume(double value) {
    setState(() {
      _volumeValue = value;
      if (value == 0) {
        _isMuted = true;
      } else {
        _isMuted = false;
      }
      // Ici, vous pouvez ajouter l'intégration avec un plugin audio
      // comme just_audio ou audioplayers pour contrôler le volume réel
    });
  }

  void _toggleMute() {
    setState(() {
      if (_isMuted) {
        _volumeValue = _volumeValue > 0 ? _volumeValue : 0.5;
        _isMuted = false;
      } else {
        _volumeValue = 0;
        _isMuted = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Retourner à la page précédente
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            Text(
              widget.artist,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // Logique pour ouvrir un menu
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Image de l'album
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                widget.imagePath, // Remplace avec ton image
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Barre de progression
          Column(
            children: [
              Slider(
                value: _sliderValue,
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
                activeColor: Colors.black,
                inactiveColor: Colors.grey,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('1:04', style: TextStyle(color: Colors.black)),
                    Text('3:45', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),

          // Contrôle du volume
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_down),
                onPressed: _toggleMute,
              ),
              Expanded(
                child: Slider(
                  value: _volumeValue,
                  onChanged: _updateVolume,
                  activeColor: Colors.blue,
                ),
              ),
              const Icon(Icons.volume_up),
            ],
          ),

          // Boutons de contrôle
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous, size: 48, color: Colors.black),
                onPressed: () {
                  // Logique pour revenir à la musique précédente
                },
              ),
              IconButton(
                icon: const Icon(Icons.play_circle_fill, size: 64, color: Colors.black),
                onPressed: () {
                  // Logique pour lecture/pause
                },
              ),
              IconButton(
                icon: const Icon(Icons.skip_next, size: 48, color: Colors.black),
                onPressed: () {
                  // Logique pour aller à la musique suivante
                },
              ),
            ],
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
