import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos LayoutBuilder para adaptar el diseño según el espacio disponible (parecido al mediaquery)
    return LayoutBuilder(
      // constraints nos da las dimensiones a usar
      builder: (context, constraints) {
        // Altura total del widget (Scaffold body)
        final availableHeight = constraints.maxHeight;
        // Definimos proporciones para las secciones
        const double topSectionHeightRatio = 0.25; // 25% para la sección superior donde va el titulo grove street
        final double topSectionHeight = availableHeight * topSectionHeightRatio; // calcula la altura en pixeles de la pantalla para saber cual es el 25% (aviableHeight es la altura total de la pantalla)
        final double formSectionHeight = availableHeight * (1.0 - topSectionHeightRatio); //calculo para saber la altura del formulario (75%) se hace restando el valor total 100% (1.0 menos el 25% del titulo)
        const double lineOffset = 40; // Offset para mover la línea hacia arriba (por ejemplo, 40 píxeles)
        final double availableWidth = constraints.maxWidth; // Ancho total disponible
        
        return Scaffold(
          // Establecemos el fondo de todo el Scaffold a blanco
          backgroundColor: Colors.white, 
          body: Column(
            children: [
              // 1. ÁREA SUPERIOR (GROVE STREET) - Mantiene el 25% de altura
              Container(
                height: topSectionHeight, 
                width: double.infinity,
                color: Colors.white, // Color de fondo explícito
                child: Stack( // Usamos Stack para posicionar el título y la línea por separado
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
                      alignment: Alignment.bottomCenter, // La alineamos al fondo del Container (25%)
                      child: Padding(
                        // Agregamos un padding inferior para "subir" la línea
                        padding: const EdgeInsets.only(bottom: lineOffset), 
                        child: Container(
                          height: 1.0, // Altura de la línea
                          width: availableWidth * 0.8, // Ancho de la línea
                          color: Colors.grey.withOpacity(0.5), // Color de la línea
                        ),
                      ),
                    ),
                  ],
                ),
              ),     
              // 2. FORMULARIO (Parte Inferior que ocupa el espacio restante)
              Expanded( // Ocupa todo el espacio restante disponible 75%
                child: Align(
                  alignment: Alignment.topCenter,
                  // ConstrainedBox limita el ancho máximo en pantallas grandes (PC/Tablet)
                  child: ConstrainedBox( // Limita el tamaño del formulario en pantallas grandes
                    constraints: const BoxConstraints(
                      maxWidth: 500, // Máximo ancho del formulario, ideal para Desktop
                      maxHeight: 450, // Máxima altura del formulario
                    ),
                    child: Container(
                      width: double.infinity, // Ocupa todo el ancho dentro de ConstrainedBox
                      decoration: const BoxDecoration(
                        color: Colors.white, 
                        borderRadius: BorderRadius.only( // Esquinas redondeadas
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30), 
                          bottomRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10, // Difuminado de la sombra
                            spreadRadius: 2, // Extensión de la sombra
                            offset: Offset(0, -3), // Sombra hacia arriba
                          )
                        ]
                      ),
                      // Usamos Padding para el contenido interno del formulario
                      padding: const EdgeInsets.fromLTRB(30, 25, 30, 0), 
                      child: Column(
                        // Estira los hijos para ocupar todo el ancho disponible
                        crossAxisAlignment: CrossAxisAlignment.stretch, 
                        children: [
                          // TÍTULO
                          const Text(
                            "INICIAR SESIÓN",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // SUBTÍTULO
                          const Text(
                            "Escribe tu correo y contraseña para iniciar sesión",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 15),
                          // Campo Correo Electrónico
                          TextField(
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.black.withOpacity(0.5)), // opacidad del texto del label
                              labelText: "Correo Electrónico",
                              contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 15),
                          // Campo Contraseña
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.black.withOpacity(0.5)),// opacidad del texto del label
                              labelText: "Contraseña",
                              contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 30),
                          // Botón Iniciar Sesión
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 18),// altura del boton
                                shape: RoundedRectangleBorder(),
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/inicio');
                              },
                              child: const Text(
                                'Iniciar Sesión',
                                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          const SizedBox(height: 20),
                          // Botón Registrarse
                          Row( // permite poner texto y boton en la misma linea
                            mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos horizontalmente (uno al lado del otro)
                            children: [
                              // Texto NO clickeable
                              const Text(
                                "¿No tienes una cuenta?",
                                style: TextStyle(fontSize: 14, color: Colors.black),
                              ),
                              // Botón clickeable para Registro
                              TextButton(
                                style: ButtonStyle(
                                  // Esta propiedad anula todos los efectos de hover, splash y focus
                                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/sign_up'); 
                                },
                                child: const Text(
                                  'Regístrate',
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}
