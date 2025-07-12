import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/models/app_user.dart';

abstract class AuthService {
  AppUser? get currentUser;
  bool get isLoggedIn => false;

  Future<Result<void>> signInWithGoogle();
  Future<Result<void>> signInWithApple();
  Future<Result<void>> signUpWithEmail(String email, String password);
  Future<Result<void>> signInWithEmail(String email, String password);
  Future<Result<void>> signOut();
  Future<Result<void>> changePassword(String oldPassword, String newPassword);
}
