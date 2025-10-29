import 'package:flutter/material.dart';

// Definición de colores
const Color primaryColor = Color(0xFFFF9800); // Naranja Brillante
const Color darkOverlay = Color.fromARGB(245, 0, 0, 0); // Fondo oscuro casi opaco

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int selectedCategory = 0;
  final categories = ['All', 'Sports', 'Theaters', 'Movies', 'Music'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos Colors.transparent ya que el fondo se maneja en el Stack
      backgroundColor: Colors.transparent, 
      body: Stack(
        children: [
          // 1. Fondo (Image + Optional Gradient)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            // Puedes añadir un gradiente oscuro para que el texto se lea mejor
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.4), Colors.black.withOpacity(0.7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2. Barra Superior (Logo y Menú)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          // TODO: Abrir Drawer o Navegación
                        },
                        icon: const Icon(Icons.menu, color: Colors.white, size: 30),
                      ),
                      Image.asset('assets/logo.png', height: 40),
                    ],
                  ),
                ),

                // 3. Buscador
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withAlpha(230),
                      prefixIcon: const Icon(Icons.search, color: Colors.black54),
                      hintText: 'Search for events, venues, or categories...',
                      hintStyle: const TextStyle(color: Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // 4. Filtros de categorías
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 20),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedCategory == index;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          label: Text(
                            categories[index],
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.white,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          selected: isSelected,
                          selectedColor: primaryColor, // Usando color definido
                          backgroundColor: Colors.white.withOpacity(0.2), // Fondo más oscuro
                          onSelected: (value) {
                            setState(() => selectedCategory = index);
                            // TODO: Implementar la lógica de filtrado aquí
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: isSelected ? BorderSide.none : const BorderSide(color: Colors.white30)
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // 5. Lista de tarjetas (Grid View)
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.7, // Se ajusta para dejar más espacio al texto
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return const ItemCard(); // Usamos un widget separado para las tarjetas
                    },
                  ),
                ),
              ],
            ),
          ),

          // 6. Barra inferior de navegación flotante
          const BottomNavBar(),
        ],
      ),
    );
  }
}

// Widget Separado para la Tarjeta de Ítem
class ItemCard extends StatelessWidget {
  const ItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9), // Fondo casi blanco
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen temporal con ClipRRect para esquinas redondeadas
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Container(
              height: 120, // Altura ajustada
              color: Colors.grey[200],
              child: const Center(
                child: Icon(Icons.movie, size: 50, color: Colors.black38),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Event Title (Index X)", // Título de ejemplo
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                const Text(
                  "Location or Date", // Subtítulo
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.star, size: 16, color: primaryColor),
                        SizedBox(width: 4),
                        Text("4.8"),
                      ],
                    ),
                    const Icon(Icons.favorite_border,
                        color: Colors.black54),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget Separado para la Barra de Navegación
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 15), // Margen para que flote
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: darkOverlay.withOpacity(0.8), // Fondo oscuro flotante
          borderRadius: BorderRadius.circular(30), // Bordes redondeados completos
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home (Activo)
            IconButton(
              icon: Icon(Icons.home, color: primaryColor, size: 28),
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
            ),
            // Listas
            IconButton(
              icon: const Icon(Icons.list, color: Colors.white, size: 28),
              onPressed: () => Navigator.pushReplacementNamed(context, '/list'),
            ),
            // Botón Central (Añadir)
            Container(
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: const Icon(Icons.add, color: Colors.black, size: 28),
            ),
            // Carrito
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 28),
              onPressed: () => Navigator.pushReplacementNamed(context, '/cart'),
            ),
            // Perfil
            IconButton(
              icon: const Icon(Icons.person_outline, color: Colors.white, size: 28),
              onPressed: () => Navigator.pushReplacementNamed(context, '/profile'),
            ),
          ],
        ),
      ),
    );
  }
}
