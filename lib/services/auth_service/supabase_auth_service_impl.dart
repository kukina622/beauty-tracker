import 'package:beauty_tracker/models/app_user.dart';
import 'package:beauty_tracker/services/auth_service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthServiceImpl implements AuthService {
  SupabaseAuthServiceImpl() {
    _currentUser = AppUser.fromSupabaseUser(supabase.auth.currentUser);
    registerListener();
  }

  @override
  AppUser? get currentUser => _currentUser;
  AppUser? _currentUser;

  @override
  bool get isLoggedIn => _currentUser?.isLoggedIn ?? false;

  SupabaseClient get supabase => Supabase.instance.client;

  @override
  Future<void> signUpWithEmail(String email, String password) async {
    final AuthResponse res = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    _currentUser = AppUser.fromSupabaseUser(res.user);
  }

  @override
  Future<void> signInWithEmail(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithApple() {
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }

  void registerListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        _currentUser = AppUser.fromSupabaseUser(data.session?.user);
      } else if (event == AuthChangeEvent.signedOut) {
        _currentUser = null;
      }
    });
  }
}
