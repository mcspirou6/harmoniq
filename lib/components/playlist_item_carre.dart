import 'package:flutter/material.dart';

class PlaylistItemCarre extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const PlaylistItemCarre({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
      subtitle: subtitle.isNotEmpty
          ? Text(
        subtitle,
        style: const TextStyle(color: Colors.black54),
      )
          : null,
      trailing: const Icon(
        Icons.navigate_next,
        color: Colors.grey,
      ),
    );
  }
}
