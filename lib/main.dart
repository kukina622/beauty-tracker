import 'package:beauty_tracker/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  final supabaseUrl = dotenv.get('SUPABASE_URL');
  final supabaseKey = dotenv.get('SUPABASE_ANON_KEY');

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  runApp(BeautyTrackerApp());
}

class BeautyTrackerApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'Beauty Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFF9A9E),
        scaffoldBackgroundColor: const Color(0xFFFFF5F5),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFFF9A9E),
          secondary: Color(0xFF5ECCC4),
          tertiary: Color(0xFFFFB6B9),
          surface: Color(0xFFFFF5F5),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'NotoSansTC',
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2D3142),
          ),
          headlineMedium: TextStyle(
            fontFamily: 'NotoSansTC',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2D3142),
          ),
          titleLarge: TextStyle(
            fontFamily: 'NotoSansTC',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2D3142),
          ),
          bodyLarge: TextStyle(
            fontFamily: 'NotoSansTC',
            fontSize: 16,
            color: const Color(0xFF2D3142),
          ),
          bodyMedium: TextStyle(
            fontFamily: 'NotoSansTC',
            fontSize: 14,
            color: const Color(0xFF2D3142),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFFFFF5F5),
          foregroundColor: const Color(0xFF2D3142),
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'NotoSansTC',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2D3142),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF9A9E),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            textStyle: TextStyle(
              fontFamily: 'NotoSansTC',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            overlayColor: Colors.transparent,
            foregroundColor: const Color(0xFF2D3142),
            textStyle: TextStyle(
              fontFamily: 'NotoSansTC',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFFF9A9E), width: 1),
          ),
          hintStyle: TextStyle(
            fontFamily: 'NotoSansTC',
            color: Colors.grey.shade400,
          ),
          labelStyle: TextStyle(
            fontFamily: 'NotoSansTC',
            color: const Color(0xFF2D3142),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: WidgetStateProperty.all(Colors.white),
          side: BorderSide(color: Colors.grey.shade600, width: 2),
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Color(0xFFFF9A9E);
            }
            return Theme.of(context).colorScheme.surface;
          }),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      builder: EasyLoading.init(),
    );
  }
}
