import 'package:flutter/material.dart';

class ArtistCard extends StatelessWidget {
  final String imagePath;
  final String artistName;
  final VoidCallback onTap;

  const ArtistCard({
    super.key,
    required this.imagePath,
    required this.artistName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Lorsque l'artiste est cliqué
      child: Card(
        color: Colors.grey, // Fond gris pour chaque carte
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4, // Ombre légère
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40, // Rayon du cercle pour la photo
              backgroundImage: AssetImage(imagePath),
            ),
            const SizedBox(height: 8),
            Text(
              artistName,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
