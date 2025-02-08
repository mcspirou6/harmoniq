import 'package:flutter/material.dart';

class MusicCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final List<String> artists;
  final VoidCallback onTap; // Action à exécuter lors du clic sur la carte

  const MusicCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.artists,
    required this.onTap, // Fonction pour rediriger
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Gère le clic pour la redirection
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15), // Bord arrondi pour la forme carrée
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 120, // Hauteur fixe pour un carré parfait
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8), // Espacement
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    artists.join(' ✕ '), // Afficher les artistes
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
