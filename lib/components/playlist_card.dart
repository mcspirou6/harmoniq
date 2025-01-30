import 'package:flutter/material.dart';

class PlaylistCard extends StatelessWidget {
  final String imagePath;
  final String albumTitle;
  final List<String> artists;

  const PlaylistCard({
    super.key,
    required this.imagePath,
    required this.albumTitle,
    required this.artists,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100, // Taille carrée
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover, // Adapte l'image à la carte
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          albumTitle,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          artists.join(" × "), // Sépare les artistes par une croix
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
