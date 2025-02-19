import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screen/home_page.dart';
import 'screen/start_page.dart';
import 'screen/library_page.dart';
import 'screen/artists_page.dart';
import 'screen/downloaded_page.dart';
import 'screen/playlist_page.dart';
import 'screen/music_library_page.dart';
import 'screen/listen_musique_page.dart';
import 'screen/create_playlist_page.dart';
import 'screen/search_page.dart';
import 'screen/profile_page.dart';
import 'screen/settings_page.dart';
import 'screen/auth_page.dart';
import 'screen/artist_detail_page.dart';
import 'screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harmoniq',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/auth': (context) => const AuthPage(),
        '/start': (context) => const StartPage(),
        '/home': (context) => const HomePage(),
        '/library': (context) => const LibraryPage(),
        '/artistPage': (context) => const ArtistPage(),
        '/downloadedPage': (context) => const DownloadedPage(),
        '/musicLibraryPage': (context) => const MusicLibraryPage(),
        '/playlistPage': (context) => const PlaylistPage(),
        '/listenMusiquePage': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return ListenMusiquePage(
            title: args['title'] as String,
            artist: args['artist'] as String,
            imagePath: args['imagePath'] as String,
          );
        },
        '/createPlaylist': (context) => const CreatePlaylistPage(),
        '/search': (context) => const SearchPage(),
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/artistDetail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return ArtistDetailPage(
            artistName: args['artistName'] as String,
            artistImage: args['artistImage'] as String,
          );
        },
      },
    );
  }
}
