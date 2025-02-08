import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show debugPrint;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtenir l'utilisateur actuel
  User? get currentUser => _auth.currentUser;

  // Stream pour l'état de l'authentification
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Connexion avec Google
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Créer un fournisseur Google
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      
      // Sur Android, utiliser signInWithProvider au lieu de signInWithPopup
      final userCredential = await _auth.signInWithProvider(googleProvider);

      // Si la connexion réussit, sauvegarder les infos utilisateur
      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': userCredential.user!.displayName,
          'email': userCredential.user!.email,
          'photoURL': userCredential.user!.photoURL,
          'lastLogin': FieldValue.serverTimestamp(),
          'premium': false,
        }, SetOptions(merge: true));
      }

      return userCredential;
    } catch (e) {
      debugPrint('Erreur de connexion Google: $e');
      rethrow;
    }
  }

  // Inscription
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      debugPrint('Début de l\'inscription pour $email');
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint('Compte créé avec succès');

      debugPrint('Sauvegarde des informations utilisateur dans Firestore');
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'premium': false,
      });
      debugPrint('Informations utilisateur sauvegardées');

      debugPrint('Mise à jour du nom d\'utilisateur');
      await userCredential.user!.updateDisplayName(username);
      debugPrint('Inscription terminée avec succès');

      return userCredential;
    } catch (e) {
      debugPrint('Erreur lors de l\'inscription: $e');
      rethrow;
    }
  }

  // Connexion
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Déconnexion
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Réinitialisation du mot de passe
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
