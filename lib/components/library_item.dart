import 'package:flutter/material.dart';

class LibraryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget destinationPage; // Page de destination

  const LibraryItem({
    super.key,
    required this.icon,
    required this.title,
    required this.destinationPage, // On passe la page en paramètre
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Naviguer vers la page de destination
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.redAccent, size: 24),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Icon(Icons.navigate_next, color: Colors.grey, size: 24),
          ],
        ),
      ),
    );
  }
}
