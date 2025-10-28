import 'package:flutter/material.dart';
import 'features/auth/presentation/screens/welcome.dart';
import 'features/auth/presentation/screens/login.dart';
import 'features/auth/presentation/screens/sign_up.dart';
import 'features/home/presentation/screens/inicio.dart';
import 'features/cart/presentation/screens/cart.dart';
import 'features/profile/presentation/screens/profile.dart';

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
