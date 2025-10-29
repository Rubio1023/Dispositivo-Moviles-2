  import 'package:flutter/material.dart';

  // Definición de colores para consistencia
  const Color primaryColor = Color(0xFFFFFFFF); // blanco
  const Color darkOverlay = Color.fromARGB(245, 0, 0, 0); // Fondo oscuro casi opaco

  class Welcome extends StatelessWidget {
    const Welcome({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          children: [
            // 1. Fondo de Imagen
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/fondo.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 2. Overlay Oscuro para legibilidad
            Container(
              color: darkOverlay.withOpacity(0.5), // Capa oscura semi-transparente
            ),

            // 3. Contenido Central
            SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end, // Alinea el contenido hacia abajo
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                      // Título de Bienvenida
                      const Text(
                        'Grove Street',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40), // Espacio entre título y logo

                      // Logo
                      Image.asset('assets/logo.png', height: 120),
                      const SizedBox(height: 20),

                      // Subtítulo
                      const Text(
                        'LA ROPA Y EL ESTILO QUE BUSCAS EN UN SOLO LUGAR.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 60), // Espacio antes del botón

                      // Botón Principal (Login o Continuar)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor, // Usamos el color principal
                          minimumSize: const Size(25, 55), // alto y ancho mínimos de boton
                          shape: RoundedRectangleBorder( // contorno del boton
                            borderRadius: BorderRadius.circular(30), 
                          ),
                        ),
                        onPressed: () {
                          // Navega a la pantalla de login/registro
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          'Continuar',
                          style: TextStyle(
                            color: Colors.black, // Contraste con el color principal
                            fontSize: 18, // Tamaño de fuente
                            fontWeight: FontWeight.w900 // Negrita
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Sección de Registro/Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "¿No tienes cuenta?",
                            style: TextStyle(color: Colors.white70, fontSize: 16),
                          ),
                          //boton de registrarse tipo texto
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/sign_up');
                            },
                            child: const Text(
                              'Registrarse',
                              style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40), // Margen inferior
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
