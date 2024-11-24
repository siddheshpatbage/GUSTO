import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gusto/gusto.dart';
import 'package:gusto/view/login_screen.dart';
import 'package:gusto/view/post_screen.dart';
import 'package:gusto/view/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAN27fC-KnqKGNBcUYvVJiIrRyRFhWAvHE",
      appId: "1:844649098227:android:a85c1e15afbb8c57a44086",
      messagingSenderId: "844649098227",
      projectId: "gusto-7c559",
      storageBucket: "gusto-7c559.firebasestorage.app",
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/gusto': (context) => const Gusto(),
        '/post': (context) => const PostScreen(),
      },
    );
  }
}
