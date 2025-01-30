import 'package:flutter/material.dart';
import '../components/custom_bottom_navigation_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _currentIndex = 2;
  bool _darkMode = true;
  bool _highQualityStreaming = false;
  bool _downloadWithWifiOnly = true;
  double _streamingQuality = 2;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Paramètres',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          _buildSection('Compte', [
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text(
                'Profil',
                style: TextStyle(color: Colors.white),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.white),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.white),
              title: const Text(
                'Email',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'utilisateur@email.com',
                style: TextStyle(color: Colors.grey[400]),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.white),
              onTap: () {},
            ),
          ]),
          _buildSection('Lecture', [
            SwitchListTile(
              title: const Text(
                'Mode sombre',
                style: TextStyle(color: Colors.white),
              ),
              value: _darkMode,
              onChanged: (bool value) {
                setState(() {
                  _darkMode = value;
                });
              },
              secondary: const Icon(Icons.dark_mode, color: Colors.white),
            ),
            ListTile(
              leading: const Icon(Icons.equalizer, color: Colors.white),
              title: const Text(
                'Égaliseur',
                style: TextStyle(color: Colors.white),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.white),
              onTap: () {},
            ),
          ]),
          _buildSection('Streaming', [
            SwitchListTile(
              title: const Text(
                'Streaming haute qualité',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Utilise plus de données',
                style: TextStyle(color: Colors.grey[400]),
              ),
              value: _highQualityStreaming,
              onChanged: (bool value) {
                setState(() {
                  _highQualityStreaming = value;
                });
              },
              secondary: const Icon(Icons.high_quality, color: Colors.white),
            ),
            ListTile(
              leading: const Icon(Icons.music_note, color: Colors.white),
              title: const Text(
                'Qualité du streaming',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Slider(
                value: _streamingQuality,
                min: 1,
                max: 3,
                divisions: 2,
                label: _getQualityLabel(_streamingQuality),
                onChanged: (double value) {
                  setState(() {
                    _streamingQuality = value;
                  });
                },
              ),
            ),
          ]),
          _buildSection('Téléchargements', [
            SwitchListTile(
              title: const Text(
                'Télécharger uniquement en Wi-Fi',
                style: TextStyle(color: Colors.white),
              ),
              value: _downloadWithWifiOnly,
              onChanged: (bool value) {
                setState(() {
                  _downloadWithWifiOnly = value;
                });
              },
              secondary: const Icon(Icons.wifi, color: Colors.white),
            ),
            ListTile(
              leading: const Icon(Icons.folder, color: Colors.white),
              title: const Text(
                'Emplacement de téléchargement',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Stockage interne',
                style: TextStyle(color: Colors.grey[400]),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.white),
              onTap: () {},
            ),
          ]),
          _buildSection('À propos', [
            ListTile(
              leading: const Icon(Icons.info, color: Colors.white),
              title: const Text(
                'Version',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                '1.0.0',
                style: TextStyle(color: Colors.grey[400]),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.description, color: Colors.white),
              title: const Text(
                'Conditions d\'utilisation',
                style: TextStyle(color: Colors.white),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.white),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip, color: Colors.white),
              title: const Text(
                'Politique de confidentialité',
                style: TextStyle(color: Colors.white),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.white),
              onTap: () {},
            ),
          ]),
        ],
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

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        const Divider(color: Colors.grey),
      ],
    );
  }

  String _getQualityLabel(double value) {
    switch (value.round()) {
      case 1:
        return 'Normale';
      case 2:
        return 'Élevée';
      case 3:
        return 'Très élevée';
      default:
        return '';
    }
  }
}
