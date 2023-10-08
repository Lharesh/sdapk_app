import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthService {
  AuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  Future<String> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return 'Signed in';
  }

  Future<String> signUp(String email, String password) async {
    final userCredentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredentials.user!.uid;
  }

  Future<String?> getUserName() async {
    String? uid = _firebaseAuth.currentUser?.uid;
    if (uid != null) {
      try {
        final userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (userDoc.exists) {
          return userDoc.data()?['email'];
        } else {
          // User document doesn't exist
          return null;
        }
      } catch (e) {
        // Handle any errors that may occur during the Firestore query
        'Error getting user data: $e';
        return null;
      }
    } else {
      // No user is signed in
      return null;
    }
  }
}

final authProvider = Provider<AuthService>((ref) => AuthService());
