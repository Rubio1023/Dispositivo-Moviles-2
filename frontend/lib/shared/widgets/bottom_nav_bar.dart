// lib/shared/widgets/bottom_nav_bar.dart (Anteriormente BottomNavBar)

import 'package:flutter/material.dart';

// Definición de colores (se recomienda importarlos de un archivo de estilos)
const Color primaryColor = Color(0xFFFF9800);
const Color darkOverlay = Color.fromARGB(245, 0, 0, 0);

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: darkOverlay.withOpacity(0.8),
          borderRadius: BorderRadius.circular(30),
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
            // ... (Botones de navegación sin cambios) ...
            IconButton(
              icon: Icon(Icons.home, color: primaryColor, size: 28),
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
            ),
            IconButton(
              icon: const Icon(Icons.list, color: Colors.white, size: 28),
              onPressed: () => Navigator.pushReplacementNamed(context, '/list'),
            ),
            Container(
              decoration: const BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: const Icon(Icons.add, color: Colors.black, size: 28),
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 28),
              onPressed: () => Navigator.pushReplacementNamed(context, '/cart'),
            ),
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