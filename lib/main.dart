import 'package:flutter/material.dart';

void main() {
  runApp(const BeautyTrackerApp());
}

class BeautyTrackerApp extends StatelessWidget {
  const BeautyTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beauty Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFF9A9E),
        scaffoldBackgroundColor: const Color(0xFFFFF5F5),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFFF9A9E),
          secondary: Color(0xFF5ECCC4),
          tertiary: Color(0xFFFFB6B9),
          surface: Colors.white,
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
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
