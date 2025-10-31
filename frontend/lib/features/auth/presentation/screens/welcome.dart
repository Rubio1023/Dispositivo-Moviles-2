import 'package:flutter/material.dart';

// Definición de Colores
const Color primaryColor = Color(0xFFFFFFFF); // Blanco puro (#FFFFFF)
const Color accentColor = Color(0xFF1E90FF); // Azul visible para botones
const double lineOffset = 40; // Desplazamiento de la línea divisoria
const double horizontalPadding = 40.0; // Padding horizontal estándar para el contenido

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos MediaQuery para obtener las dimensiones disponibles de la pantalla.
    final screenHeight = MediaQuery.of(context).size.height;
    
    // 25% para la sección superior (título y línea)
    const double topSectionHeightRatio = 0.25; 
    final double topSectionHeight = screenHeight * topSectionHeightRatio;
    
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          // 1. ÁREA SUPERIOR (GROVE STREET) - 25% de altura
          Container(
            height: topSectionHeight,
            width: double.infinity,
            color: primaryColor, // Fondo blanco
            child: const Center(
              child: Text(
                "GROVE STREET",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          
          // 2. CONTENIDO PRINCIPAL (Expanded) - Ocupa el 75% restante
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 500, // Máximo ancho para tablet/desktop
                ),
                // Padding horizontal aplicado una sola vez a todo el contenido
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    // Empieza desde arriba, usamos Spacer para empujar el contenido hacia arriba
                    mainAxisAlignment: MainAxisAlignment.start, 
                    crossAxisAlignment: CrossAxisAlignment.stretch, 
                    children: [
                      // imagen del logo
                      Image.asset(
                        'assets/images/logo.png',
                        height: 200,
                      ),
                      // Espacio entre logo y botones
                      const SizedBox(height: 60), 
                      
                      // Botón Principal (Iniciar Sesión)
                      // Envolvemos el botón en Padding para reducir su ancho efectivo y centrarlo
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25), // Nuevo padding lateral de 25px
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 18), 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                          ),
                          onPressed: () {
                            if (context.mounted) {
                              Navigator.of(context).pushNamed('/login'); 
                            }
                          },
                          child: const Text(
                            'Iniciar Sesión', 
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Sección de Registro (TextButton)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "¿No tienes cuenta?",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/sign_up');
                            },
                            child: Text(
                              'Regístrate Aquí',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // Espaciador final para empujar el contenido hacia arriba
                      const Spacer(), 
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
