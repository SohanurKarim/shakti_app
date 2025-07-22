import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shakti_contact/views/auth_screen/login_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
      _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GridView Theme Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        cardColor: Colors.white,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        cardColor: Colors.grey[900],
      ),
      themeMode: _themeMode,
      home: LoginScreen(
        onToggleTheme: toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}


