import 'package:flutter/material.dart';

class CreatePlaylistPage extends StatefulWidget {
  const CreatePlaylistPage({super.key});

  @override
  State<CreatePlaylistPage> createState() => _CreatePlaylistPageState();
}

class _CreatePlaylistPageState extends State<CreatePlaylistPage> {
  final TextEditingController _playlistNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'New Playlist',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Logique pour sauvegarder la playlist
            },
            child: const Text(
              'Done',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Zone d'ajout d'image
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.music_note,
                    color: Colors.grey,
                    size: 80,
                  ),
                  Positioned(
                    bottom: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 20,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        onPressed: () {
                          // Logique pour ajouter une image
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Nom de la playlist
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Playlist Name',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            TextField(
              controller: _playlistNameController,
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Description de la playlist
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Description',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            TextField(
              controller: _descriptionController,
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              maxLines: 2,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Bouton pour ajouter de la musique
            Row(
              children: [
                const Icon(
                  Icons.add_circle,
                  color: Colors.green,
                  size: 24,
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    // Logique pour ajouter des musiques
                  },
                  child: const Text(
                    'Add Music',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 13,),
            ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Create',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
