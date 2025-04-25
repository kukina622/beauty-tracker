import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class AppUser {
  AppUser({required this.id, required this.email});

  factory AppUser.fromSupabaseUser(supabase.User? user) {
    return AppUser(id: user?.id ?? '', email: user?.email ?? '');
  }

  bool get isLoggedIn => id.isNotEmpty;

  final String id;
  final String email;
}
