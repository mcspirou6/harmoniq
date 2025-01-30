import 'package:flutter/material.dart';
import '../components/artist_card.dart'; // Importer le composant ArtistCard
import '../components/custom_bottom_navigation_bar.dart'; // Importer le Custom Bottom Navigation Bar

class ArtistPage extends StatefulWidget {
  const ArtistPage({super.key});

  @override
  ArtistPageState createState() => ArtistPageState();
}

class ArtistPageState extends State<ArtistPage> {
  int _currentIndex = 2; // Onglet Library sélectionné

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Fonction pour revenir à la page Library
  void _goBackToLibrary() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fond noir
      appBar: AppBar(
        backgroundColor: Colors.white, // Couleur de fond de l'AppBar
        leading: GestureDetector(
          onTap: _goBackToLibrary, // Revenir à la page Library en cliquant sur le titre
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: _goBackToLibrary, // Revenir à la page Library
              ),
              const Text(
                'Library',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Ajouter la logique de recherche ici si nécessaire
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Artists',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Nombre de colonnes
                  crossAxisSpacing: 16, // Espacement horizontal entre les éléments
                  mainAxisSpacing: 16, // Espacement vertical entre les éléments
                  childAspectRatio: 1, // L'élément sera carré
                ),
                itemCount: 10, // Nombre d'artistes à afficher
                itemBuilder: (context, index) {
                  return ArtistCard(
                    imagePath: 'assets/artist$index.jpg', // Chemin de l'image de l'artiste
                    artistName: 'Artist $index', // Nom de l'artiste
                    onTap: () {
                      // Logique pour gérer le clic sur un artiste
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
