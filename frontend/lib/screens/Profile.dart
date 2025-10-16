import 'package:flutter/material.dart';
import 'package:frontend/core/utils/session_manager.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    SessionManager.getUser().then((u) {
      setState(() => user = u);
    });
  }

  void _logout() async {
    await SessionManager.clear();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    final name = user?['name'] ?? user?['username'] ?? 'Usuario';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información del Usuario'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white70,
                child: Icon(Icons.person, size: 60, color: Colors.blueGrey),
              ),
              const SizedBox(height: 20),
              Text('Hola, $name',
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 12)),
                child: const Text('Cerrar sesión',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
