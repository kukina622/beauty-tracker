abstract class AuthService {
  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Future<void> signInWithEmail(String email, String password);
  Future<void> signOut();
}