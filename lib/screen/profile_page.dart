import 'package:flutter/material.dart';
import '../components/custom_bottom_navigation_bar.dart';
import '../components/playlist_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Photo de profil
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              const SizedBox(height: 16),
              // Nom d'utilisateur
              const Text(
                'Nom d\'utilisateur',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Email
              Text(
                'utilisateur@email.com',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              // Statistiques
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem('Playlists', '12'),
                  _buildStatItem('Abonnés', '245'),
                  _buildStatItem('Abonnements', '180'),
                ],
              ),
              const SizedBox(height: 32),
              // Section Playlists
              _buildSection('Vos Playlists'),
              // Liste des playlists
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return PlaylistItem(
                    imagePath: 'assets/playlist${index + 1}.jpg',
                    title: 'Ma Playlist ${index + 1}',
                    subtitle: '${(index + 1) * 10} titres',
                  );
                },
              ),
              const SizedBox(height: 16),
              // Section Paramètres
              _buildSettingsSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Voir tout',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    final List<Map<String, dynamic>> settings = [
      {'icon': Icons.settings, 'title': 'Paramètres'},
      {'icon': Icons.notifications, 'title': 'Notifications'},
      {'icon': Icons.privacy_tip, 'title': 'Confidentialité'},
      {'icon': Icons.help, 'title': 'Aide'},
      {'icon': Icons.logout, 'title': 'Déconnexion'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Paramètres',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...settings.map((setting) => ListTile(
          leading: Icon(
            setting['icon'] as IconData,
            color: Colors.white,
          ),
          title: Text(
            setting['title'] as String,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: Colors.white,
          ),
          onTap: () {
            // Navigation vers la page correspondante
          },
        )),
      ],
    );
  }
}
