import 'dart:convert';
import 'package:http/http.dart' as http;

class JamendoService {
  static const String baseUrl = 'https://api.jamendo.com/v3.0';
  // Clé client pour l'API Jamendo (à obtenir sur https://developer.jamendo.com/)
  static const String clientId = 'c1085d7c';

  // Obtenir les morceaux populaires
  Future<List<Map<String, dynamic>>> getPopularTracks() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/tracks/?client_id=$clientId&format=json&limit=20&orderby=popularity_total'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        throw Exception('Erreur lors de la récupération des morceaux populaires');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  // Rechercher des morceaux
  Future<List<Map<String, dynamic>>> searchTracks(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/tracks/?client_id=$clientId&format=json&limit=20&search=$query'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        throw Exception('Erreur lors de la recherche');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  // Obtenir les playlists populaires
  Future<List<Map<String, dynamic>>> getPopularPlaylists() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/playlists/?client_id=$clientId&format=json&limit=20&orderby=popularity_total'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        throw Exception('Erreur lors de la récupération des playlists');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  // Obtenir les artistes populaires
  Future<List<Map<String, dynamic>>> getPopularArtists() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/artists/?client_id=$clientId&format=json&limit=20&orderby=popularity_total'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        throw Exception('Erreur lors de la récupération des artistes');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  // Obtenir les détails d'un artiste
  Future<Map<String, dynamic>> getArtistDetails(String artistId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/artists/tracks/?client_id=$clientId&format=json&id=$artistId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['results'][0];
      } else {
        throw Exception('Erreur lors de la récupération des détails de l\'artiste');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  // Obtenir les genres musicaux
  Future<List<Map<String, dynamic>>> getMusicTags() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/tags/?client_id=$clientId&format=json&order=name'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        throw Exception('Erreur lors de la récupération des genres');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  // Obtenir les morceaux par genre
  Future<List<Map<String, dynamic>>> getTracksByTag(String tag) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/tracks/?client_id=$clientId&format=json&tags=$tag&limit=20'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        throw Exception('Erreur lors de la récupération des morceaux par genre');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }
}
