import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final Color backgroundColor;

  const CategoryCard({
    super.key,
    required this.title,
    this.backgroundColor = Colors.blue, // Couleur par défaut
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12), // Bords arrondis
      ),
      height: 100, // Taille carrée
      width: 100,
      alignment: Alignment.center, // Centrer le texte
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
