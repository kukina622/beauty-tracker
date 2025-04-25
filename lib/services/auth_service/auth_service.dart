import 'package:beauty_tracker/models/app_user.dart';

abstract class AuthService {
  AppUser? get currentUser;
  bool get isLoggedIn => false;

  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Future<void> signUpWithEmail(String email, String password);
  Future<void> signInWithEmail(String email, String password);
  Future<void> signOut();
}
