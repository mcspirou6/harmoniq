import 'package:flutter/material.dart';

class PlaylistItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const PlaylistItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600]),
                )
              ],
            ),
          ),
          const IconButton(
              onPressed: null,
              icon: Icon(Icons.navigate_next))
        ],
      ),
    );
  }
}
