import 'package:flutter/material.dart';
import 'screens/Welcome.dart';
import 'screens/Login.dart';
import 'screens/SignUp.dart';
import 'screens/Inicio.dart';
import 'screens/Cart.dart';
import 'screens/Profile.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Silent Hill',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF001F54)),
      ),
      //  Ruta inicial
      initialRoute: '/',
      routes: {
        '/': (context) => const Welcome(),
        '/inicio': (context) => const Inicio(),
        '/login': (context) => const Login(),
        '/signup': (context) => const SignUp(),
        '/cart': (context) => const Cart(),
        '/profile': (context) => const Profile(),
      },
    );
  }
}
