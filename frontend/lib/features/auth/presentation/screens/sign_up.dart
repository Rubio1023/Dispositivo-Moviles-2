import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos LayoutBuilder para adaptar el diseño según el espacio disponible
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.maxHeight;
        
        // Se mantiene la proporción 25% para el encabezado
        const double topSectionHeightRatio = 0.25; 
        final double topSectionHeight = availableHeight * topSectionHeightRatio; 
        
        const double lineOffset = 40; // Offset para mover la línea hacia arriba
        final double availableWidth = constraints.maxWidth; // Ancho total disponible

        return Scaffold(
          backgroundColor: Colors.white, 
          body: Column(
            children: [
              // 1. ÁREA SUPERIOR (GROVE STREET) - 25%
              Container(
                height: topSectionHeight, 
                width: double.infinity,
                color: Colors.white,
                child: Stack(
                  children: [
                    const Center(
                      child: Text(
                        "GROVE STREET",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Colors.black, 
                        ),
                      ),
                    ),
                    
                    // Línea Divisoria (Alineada y Desplazada)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: lineOffset), 
                        child: Container(
                          height: 1.0, 
                          width: availableWidth * 0.8, 
                          color: Colors.grey.withOpacity(0.5), 
                        ),
                      ),
                    ),
                  ],
                ),
              ), 
              // 2. FORMULARIO (Parte Inferior - Expanded)
              Expanded( // Ocupa todo el espacio restante disponible (75%)
                child: Align(
                  alignment: Alignment.topCenter,
                  // ConstrainedBox limita el ancho máximo en pantallas grandes
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 500, // Máximo ancho para Desktop/Tablet
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white, 
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, -3),
                          )
                        ]
                      ),
                      
                      // 🎉 SOLUCIÓN: Usamos SingleChildScrollView aquí
                      child: SingleChildScrollView( 
                        padding: const EdgeInsets.fromLTRB(30, 25, 30, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch, 
                          children: [
                            // TÍTULO DEL FORMULARIO
                            const Text(
                              "REGISTRO",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45,
                              ),
                            ),
                            const SizedBox(height: 25),
                            
                            // Campo NOMBRE
                            const TextField(
                              decoration: InputDecoration(
                                labelText: "NOMBRE",
                                contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 15),
                            
                            // Campo APELLIDO
                            const TextField(
                              decoration: InputDecoration(
                                labelText: "APELLIDO",
                                contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 15),

                            // Campo CORREO ELECTRÓNICO
                            const TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "CORREO ELECTRÓNICO",
                                contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 15),
                            
                            // Campo CONTRASEÑA
                            const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "CONTRASEÑA",
                                contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 30),
                            
                            // Botón REGISTRARSE
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder()
                                ),
                              onPressed: () {
                                // Lógica de registro aquí
                              },
                              child: const Text(
                                'CREAR CUENTA',
                                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}