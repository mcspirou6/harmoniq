import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedFontSize: 14,
      unselectedFontSize: 12,
      elevation: 10,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, size: 28),
          activeIcon: Icon(Icons.home, size: 28),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.my_library_music_outlined, size: 28),
          activeIcon: Icon(Icons.my_library_music, size: 28),
          label: 'Library',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined, size: 28),
          activeIcon: Icon(Icons.settings, size: 28),
          label: 'Paramètres',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline, size: 28),
          activeIcon: Icon(Icons.person, size: 28),
          label: 'Profil',
        ),
      ],
    );
  }
}
