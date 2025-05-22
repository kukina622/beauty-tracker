import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/errors/result_guard.dart';
import 'package:beauty_tracker/models/app_user.dart';
import 'package:beauty_tracker/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthServiceImpl extends ChangeNotifier implements AuthService {
  SupabaseAuthServiceImpl() {
    _updateUser(AppUser.fromSupabaseUser(supabase.auth.currentUser));
    supabase.auth.onAuthStateChange.listen((data) => _handleAuth(data.event));
  }

  @override
  AppUser? get currentUser => _currentUser;
  AppUser? _currentUser;

  @override
  bool get isLoggedIn => _currentUser?.isLoggedIn ?? false;

  SupabaseClient get supabase => Supabase.instance.client;

  @override
  Future<Result<void>> signUpWithEmail(String email, String password) {
    return resultGuard(() async {
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      _updateUser(AppUser.fromSupabaseUser(res.user));
    });
  }

  @override
  Future<Result<void>> signInWithEmail(String email, String password) {
    return resultGuard(() async {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      _updateUser(AppUser.fromSupabaseUser(res.user));
    });
  }

  @override
  Future<Result<void>> signInWithApple() {
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> signInWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> signOut() {
    throw UnimplementedError();
  }

  void _updateUser(AppUser? user) {
    _currentUser = user;
    notifyListeners();
  }

  void _handleAuth(AuthChangeEvent state) {
    if (state == AuthChangeEvent.signedIn) {
      _updateUser(AppUser.fromSupabaseUser(supabase.auth.currentUser));
    } else if (state == AuthChangeEvent.signedOut) {
      _updateUser(null);
    }
    notifyListeners();
  }
}
