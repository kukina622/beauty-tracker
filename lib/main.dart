import 'package:beauty_tracker/app_initializer.dart';
import 'package:beauty_tracker/providers/product_provider.dart';
import 'package:beauty_tracker/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInitializer.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: BeautyTrackerApp(),
    ),
  );
}

class BeautyTrackerApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'Beauty Tracker',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('zh', 'TW')],
      locale: const Locale('zh', 'TW'),
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
          titleSmall: TextStyle(
            fontFamily: 'NotoSansTC',
            fontSize: 16,
            fontWeight: FontWeight.w500,
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
        datePickerTheme: DatePickerThemeData(
          backgroundColor: Colors.white,
          dividerColor: Colors.grey.shade300,
          headerForegroundColor: Colors.white,
          headerBackgroundColor: const Color(0xFFFF9A9E),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: Color(0xFFf9f9f9),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return const Color(0xFFFF9A9E); // activeColor
            }
            return Colors.white; // inactiveThumbColor
          }),
          trackColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return const Color(0xFFFF9A9E).withValues(alpha: 0.3); // activeTrackColor
            }
            return Colors.grey.shade300; // inactiveTrackColor
          }),
          trackOutlineColor: WidgetStateProperty.resolveWith(
            (final Set<WidgetState> states) {
              return Colors.transparent;
            },
          ),
        ),
      ),
      builder: EasyLoading.init(),
    );
  }
}
