import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/errors/result_guard.dart';
import 'package:beauty_tracker/models/app_user.dart';
import 'package:beauty_tracker/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    return resultGuard(() async {
      final String webClientId = dotenv.get('GOOGLE_WEB_CLIENT_ID').toString();
      final String iosClientId = dotenv.get('GOOGLE_IOS_CLIENT_ID').toString();
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
      );
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }

      if (idToken == null) {
        throw 'No ID Token found.';
      }

      final AuthResponse res = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      _updateUser(AppUser.fromSupabaseUser(res.user));
    });
  }

  @override
  Future<Result<void>> signOut() {
    return resultGuard(() async {
      await supabase.auth.signOut();
      _updateUser(null);
    });
  }

  @override
  Future<Result<void>> changePassword(String oldPassword, String newPassword) {
    return resultGuard(() async {
      if (_currentUser == null) {
        throw 'No user is currently logged in.';
      }

      final result = await supabase.rpc<String>('change_password', params: {
        'current_plain_password': oldPassword,
        'new_plain_password': newPassword,
        'current_id': supabase.auth.currentUser?.id,
      });

      if (result != 'success') {
        throw 'Failed to change password';
      }
    });
  }

  @override
  Future<Result<void>> resetPassword(String email) {
    return resultGuard(() async {
      await supabase.auth.resetPasswordForEmail(email);
    });
  }

  @override
  Future<Result<void>> verifyRecoveryOtp(String email, String token) {
    return resultGuard(() async {
      await supabase.auth.verifyOTP(
        type: OtpType.recovery,
        token: token,
        email: email,
      );
    });
  }

  @override
  Future<Result<void>> updateForgotPassword(String newPassword) {
    return resultGuard(() async {
      await supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
    });
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
