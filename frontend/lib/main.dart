import 'package:flutter/material.dart';
import 'screens/welcome.dart';
import 'screens/login.dart';
import 'screens/sign-up.dart';
import 'screens/inicio.dart';
import 'screens/cart.dart';
import 'screens/profile.dart';

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
