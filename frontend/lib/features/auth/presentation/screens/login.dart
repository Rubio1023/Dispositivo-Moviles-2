import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el tamaño de la pantalla
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // 1. IMAGEN DE FONDO (Cubre toda la pantalla)
          Container(
            height: screenHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                // Asegúrate de que esta ruta sea correcta: assets/fondo.jpg
                image: AssetImage('assets/fondo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 2. LOGO Y TÍTULO (Posicionados en la parte superior)
          Positioned(
            top: screenHeight * 0.1, // 10% de la altura desde arriba
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Asegúrate de que esta ruta sea correcta: assets/logo.png
                Image.asset('assets/logo.png', height: 100),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // 3. FORMULARIO
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Welcome to Grove Street",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Campo E-mail
                    TextField(
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        prefixIcon: const Icon(Icons.email, color: Colors.black54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Campo Password
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock, color: Colors.black54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Botón Iniciar Sesión
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        // El ancho ya lo da Column(crossAxisAlignment: stretch)
                      ),
                      onPressed: () {
                        // Navegación (Asegúrate que '/inicio' existe en main.dart)
                        Navigator.pushReplacementNamed(context, '/inicio');
                      },
                      child: const Text(
                        'Iniciar Sesión',
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Olvidaste Contraseña
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    // Botón Registrarse
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/sign_up');
                      },
                      child: const Text(
                        'Registrarse',
                        style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
